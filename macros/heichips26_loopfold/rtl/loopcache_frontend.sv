// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

// Transparent two-line instruction buffer with an adaptive next-word
// prefetcher. Three consecutive sequential PC transitions raise enough
// confidence to fetch PC+4 whenever the external link would otherwise be
// idle. A small opcode classifier suppresses confidence immediately after a
// control-flow instruction, preventing speculative branch fall-through fetches
// from polluting the two resident lines. Prefetched words are marked until
// first demand use, allowing software to measure issued and useful prefetches.
module loopcache_frontend #(
    parameter integer LINE_WORDS = 8,
    parameter [31:0]  MMIO_BASE  = 32'h1000_0000
) (
    input  wire        clk_i,
    input  wire        rst_ni,
    input  wire        cache_enable_i,
    input  wire        cache_flush_i,
    input  wire        prefetch_enable_i,

    input  wire        core_mem_valid_i,
    input  wire        core_mem_instr_i,
    input  wire [31:0] core_mem_addr_i,
    input  wire [31:0] core_mem_wdata_i,
    input  wire [ 3:0] core_mem_wstrb_i,
    output logic       core_mem_ready_o,
    output logic [31:0] core_mem_rdata_o,

    output logic       ext_mem_valid_o,
    output logic       ext_mem_instr_o,
    output logic [31:0] ext_mem_addr_o,
    output logic [31:0] ext_mem_wdata_o,
    output logic [ 3:0] ext_mem_wstrb_o,
    input  wire        ext_mem_ready_i,
    input  wire [31:0] ext_mem_rdata_i,

    output logic [31:0] cycle_count_o,
    output logic [31:0] external_ifetch_count_o,
    output logic [31:0] loop_hit_count_o,
    output logic [31:0] stall_count_o
);

    localparam integer INDEX_BITS = $clog2(LINE_WORDS);
    localparam integer LINE_LSB   = INDEX_BITS + 2;
    localparam integer TAG_BITS     = 12 - LINE_LSB;
    localparam integer COUNTER_BITS = 16;

    logic [31:0] way0_data_q [0:LINE_WORDS-1];
    logic [31:0] way1_data_q [0:LINE_WORDS-1];
    logic [LINE_WORDS-1:0] way0_valid_q;
    logic [LINE_WORDS-1:0] way1_valid_q;
    logic [LINE_WORDS-1:0] way0_prefetched_q;
    logic [LINE_WORDS-1:0] way1_prefetched_q;
    // The external narrow-memory protocol exposes 1024 32-bit words, so only
    // byte-address bits [11:0] can identify backing memory.  Keep only the
    // useful tag bits instead of clocking two redundant 32-bit base registers.
    logic [TAG_BITS-1:0] way0_tag_q;
    logic [TAG_BITS-1:0] way1_tag_q;

    // Value 0 means way 0 is the next replacement victim; value 1 means way 1.
    logic lru_victim_q;

    logic        last_ifetch_valid_q;
    logic [11:0] last_ifetch_addr_q;
    logic        last_ifetch_control_flow_q;
    logic [ 1:0] sequential_confidence_q;
    logic        prefetch_pending_q;
    logic [11:0] prefetch_candidate_addr_q;
    logic        prefetch_active_q;
    logic [11:0] prefetch_active_addr_q;
    logic [COUNTER_BITS-1:0] prefetch_issued_count_q;
    logic [COUNTER_BITS-1:0] prefetch_useful_count_q;
    logic        counter_freeze_q;

    // Sixteen bits are ample for benchmark snapshots while the architectural
    // MMIO interface remains 32 bits through zero extension below.
    logic [COUNTER_BITS-1:0] cycle_count_q;
    logic [COUNTER_BITS-1:0] external_ifetch_count_q;
    logic [COUNTER_BITS-1:0] loop_hit_count_q;
    logic [COUNTER_BITS-1:0] stall_count_q;

    wire [INDEX_BITS-1:0] line_index =
        core_mem_addr_i[INDEX_BITS+1:2];
    wire core_addr_in_range = (core_mem_addr_i[31:12] == 20'b0);
    wire [TAG_BITS-1:0] requested_line_tag =
        core_mem_addr_i[11:LINE_LSB];

    wire is_instruction_read = core_mem_instr_i &&
                               (core_mem_wstrb_i == 4'b0000);
    wire is_mmio = (core_mem_addr_i[31:8] == MMIO_BASE[31:8]);
    wire way0_occupied = |way0_valid_q;
    wire way1_occupied = |way1_valid_q;
    wire way0_line_match = core_addr_in_range && way0_occupied &&
                           (way0_tag_q == requested_line_tag);
    wire way1_line_match = core_addr_in_range && way1_occupied &&
                           (way1_tag_q == requested_line_tag);
    wire way0_hit = cache_enable_i && is_instruction_read &&
                    way0_line_match && way0_valid_q[line_index];
    wire way1_hit = cache_enable_i && is_instruction_read &&
                    way1_line_match && way1_valid_q[line_index];
    wire cache_hit = way0_hit || way1_hit;

    wire [INDEX_BITS-1:0] prefetch_candidate_index =
        prefetch_candidate_addr_q[INDEX_BITS+1:2];
    wire [TAG_BITS-1:0] prefetch_candidate_tag =
        prefetch_candidate_addr_q[11:LINE_LSB];
    wire prefetch_candidate_cached =
        (way0_occupied && (way0_tag_q == prefetch_candidate_tag) &&
         way0_valid_q[prefetch_candidate_index]) ||
        (way1_occupied && (way1_tag_q == prefetch_candidate_tag) &&
         way1_valid_q[prefetch_candidate_index]);

    wire [12:0] sequential_next_sum =
        {1'b0, core_mem_addr_i[11:0]} + 13'd4;
    wire [11:0] sequential_next_addr = sequential_next_sum[11:0];
    wire [INDEX_BITS-1:0] sequential_next_index =
        sequential_next_addr[INDEX_BITS+1:2];
    wire [TAG_BITS-1:0] sequential_next_tag =
        sequential_next_addr[11:LINE_LSB];
    wire sequential_next_in_range = core_addr_in_range &&
                                    !sequential_next_sum[12];
    wire sequential_next_cached = sequential_next_in_range &&
        ((way0_occupied && (way0_tag_q == sequential_next_tag) &&
         way0_valid_q[sequential_next_index]) ||
         (way1_occupied && (way1_tag_q == sequential_next_tag) &&
          way1_valid_q[sequential_next_index]));

    wire can_start_prefetch = prefetch_pending_q &&
                              !prefetch_active_q &&
                              prefetch_enable_i &&
                              cache_enable_i &&
                              !counter_freeze_q &&
                              !cache_flush_i &&
                              !core_mem_valid_i &&
                              !prefetch_candidate_cached;

    assign cycle_count_o = {{(32-COUNTER_BITS){1'b0}}, cycle_count_q};
    assign external_ifetch_count_o =
        {{(32-COUNTER_BITS){1'b0}}, external_ifetch_count_q};
    assign loop_hit_count_o =
        {{(32-COUNTER_BITS){1'b0}}, loop_hit_count_q};
    assign stall_count_o = {{(32-COUNTER_BITS){1'b0}}, stall_count_q};

    logic [31:0] mmio_rdata;
    always_comb begin
        case (core_mem_addr_i[5:2])
            4'h0: mmio_rdata = {29'b0, prefetch_enable_i,
                                cache_flush_i, cache_enable_i};
            4'h1: mmio_rdata =
                {{(32-COUNTER_BITS){1'b0}}, cycle_count_q};
            4'h2: mmio_rdata =
                {{(32-COUNTER_BITS){1'b0}}, external_ifetch_count_q};
            4'h3: mmio_rdata =
                {{(32-COUNTER_BITS){1'b0}}, loop_hit_count_q};
            4'h4: mmio_rdata =
                {{(32-COUNTER_BITS){1'b0}}, stall_count_q};
            4'h5: mmio_rdata =
                {{(32-COUNTER_BITS){1'b0}}, prefetch_issued_count_q};
            4'h6: mmio_rdata =
                {{(32-COUNTER_BITS){1'b0}}, prefetch_useful_count_q};
            4'h7: mmio_rdata = {31'b0, counter_freeze_q};
            default: mmio_rdata = 32'b0;
        endcase
    end

    // A prefetch already accepted by the bridge is allowed to complete. A
    // simultaneous demand cache hit or MMIO access can still complete locally;
    // a demand miss waits until the prefetch response has been consumed.
    always_comb begin
        core_mem_ready_o = 1'b0;
        core_mem_rdata_o = 32'b0;

        ext_mem_valid_o  = prefetch_active_q;
        ext_mem_instr_o  = 1'b1;
        ext_mem_addr_o   = {20'b0, prefetch_active_addr_q};
        ext_mem_wdata_o  = 32'b0;
        ext_mem_wstrb_o  = 4'b0;

        if (!prefetch_active_q) begin
            ext_mem_instr_o = core_mem_instr_i;
            ext_mem_addr_o  = core_mem_addr_i;
            ext_mem_wdata_o = core_mem_wdata_i;
            ext_mem_wstrb_o = core_mem_wstrb_i;
        end

        if (core_mem_valid_i) begin
            if (is_mmio) begin
                core_mem_ready_o = 1'b1;
                core_mem_rdata_o = mmio_rdata;
            end else if (cache_hit) begin
                core_mem_ready_o = 1'b1;
                if (way1_hit)
                    core_mem_rdata_o = way1_data_q[line_index];
                else
                    core_mem_rdata_o = way0_data_q[line_index];
            end else if (!prefetch_active_q) begin
                ext_mem_valid_o  = 1'b1;
                core_mem_ready_o = ext_mem_ready_i;
                core_mem_rdata_o = ext_mem_rdata_i;
            end
        end
    end

    wire core_transfer = core_mem_valid_i && core_mem_ready_o;
    wire demand_ifetch_transfer = core_transfer &&
                                  is_instruction_read && !is_mmio;
    wire completed_ifetch_control_flow =
        (core_mem_rdata_o[6:0] == 7'b1100011) || // conditional branch
        (core_mem_rdata_o[6:0] == 7'b1101111) || // JAL
        (core_mem_rdata_o[6:0] == 7'b1100111);   // JALR
    wire external_transfer = ext_mem_valid_o && ext_mem_ready_i;
    wire instruction_fill = external_transfer && ext_mem_instr_o &&
                            (ext_mem_addr_o[31:12] == 20'b0);
    wire fill_is_prefetch = instruction_fill && prefetch_active_q;
    wire [INDEX_BITS-1:0] fill_index =
        ext_mem_addr_o[INDEX_BITS+1:2];
    wire [TAG_BITS-1:0] fill_line_tag =
        ext_mem_addr_o[11:LINE_LSB];
    wire [LINE_WORDS-1:0] fill_word_mask =
        ({{(LINE_WORDS-1){1'b0}}, 1'b1} << fill_index);
    wire fill_way0_match = way0_occupied &&
                           (way0_tag_q == fill_line_tag);
    wire fill_way1_match = way1_occupied &&
                           (way1_tag_q == fill_line_tag);
    wire counter_control_write = core_transfer && is_mmio &&
                                 (core_mem_addr_i[5:2] == 4'h7) &&
                                 (core_mem_wstrb_i != 4'b0000);

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            way0_valid_q                <= '0;
            way1_valid_q                <= '0;
            way0_prefetched_q           <= '0;
            way1_prefetched_q           <= '0;
            way0_tag_q                  <= '0;
            way1_tag_q                  <= '0;
            lru_victim_q                <= 1'b0;
            last_ifetch_valid_q         <= 1'b0;
            last_ifetch_addr_q          <= 12'b0;
            last_ifetch_control_flow_q  <= 1'b0;
            sequential_confidence_q     <= 2'b0;
            prefetch_pending_q          <= 1'b0;
            prefetch_candidate_addr_q   <= 12'b0;
            prefetch_active_q           <= 1'b0;
            prefetch_active_addr_q      <= 12'b0;
            prefetch_issued_count_q     <= '0;
            prefetch_useful_count_q     <= '0;
            counter_freeze_q            <= 1'b0;
            cycle_count_q               <= '0;
            external_ifetch_count_q     <= '0;
            loop_hit_count_q            <= '0;
            stall_count_q               <= '0;
        end else begin
            if (counter_control_write)
                counter_freeze_q <= core_mem_wdata_i[0];

            if (!counter_freeze_q) begin
                cycle_count_q <= cycle_count_q + 1'b1;

                if (core_mem_valid_i && !core_mem_ready_o)
                    stall_count_q <= stall_count_q + 1'b1;

                if (core_transfer && cache_hit)
                    loop_hit_count_q <= loop_hit_count_q + 1'b1;

                if (external_transfer && ext_mem_instr_o)
                    external_ifetch_count_q <=
                        external_ifetch_count_q + 1'b1;
            end

            if (core_transfer && cache_hit) begin
                if (way0_hit) begin
                    lru_victim_q <= 1'b1;
                    if (way0_prefetched_q[line_index]) begin
                        way0_prefetched_q[line_index] <= 1'b0;
                        if (!counter_freeze_q)
                            prefetch_useful_count_q <=
                                prefetch_useful_count_q + 1'b1;
                    end
                end else begin
                    lru_victim_q <= 1'b0;
                    if (way1_prefetched_q[line_index]) begin
                        way1_prefetched_q[line_index] <= 1'b0;
                        if (!counter_freeze_q)
                            prefetch_useful_count_q <=
                                prefetch_useful_count_q + 1'b1;
                    end
                end
            end

            // Complete an outstanding prefetch without pretending that it was
            // a demand response to the processor.
            if (external_transfer && prefetch_active_q)
                prefetch_active_q <= 1'b0;

            if (!cache_enable_i || !prefetch_enable_i || cache_flush_i ||
                counter_freeze_q) begin
                last_ifetch_valid_q     <= 1'b0;
                last_ifetch_control_flow_q <= 1'b0;
                sequential_confidence_q <= 2'b0;
                prefetch_pending_q      <= 1'b0;
            end else begin
                if (prefetch_pending_q && prefetch_candidate_cached)
                    prefetch_pending_q <= 1'b0;

                if (demand_ifetch_transfer) begin
                    last_ifetch_addr_q  <= core_mem_addr_i[11:0];
                    last_ifetch_valid_q <= core_addr_in_range;
                    last_ifetch_control_flow_q <=
                        completed_ifetch_control_flow;

                    if (last_ifetch_valid_q &&
                        !last_ifetch_control_flow_q &&
                        core_addr_in_range &&
                        (last_ifetch_addr_q <= 12'hffb) &&
                        (core_mem_addr_i[11:0] ==
                         last_ifetch_addr_q + 12'd4)) begin
                        if (sequential_confidence_q != 2'b11)
                            sequential_confidence_q <=
                                sequential_confidence_q + 2'd1;

                        // Requiring old confidence >= 2 suppresses prefetches
                        // from short basic blocks and branch-heavy loops.  It
                        // still recognizes sustained straight-line execution
                        // on the third consecutive sequential transition.
                        if (sequential_confidence_q >= 2'd2) begin
                            prefetch_candidate_addr_q <= sequential_next_addr;
                            if (!prefetch_active_q &&
                                !sequential_next_cached &&
                                sequential_next_in_range) begin
                                prefetch_active_q      <= 1'b1;
                                prefetch_active_addr_q <= sequential_next_addr;
                                prefetch_pending_q     <= 1'b0;
                                if (!counter_freeze_q)
                                    prefetch_issued_count_q <=
                                        prefetch_issued_count_q + 1'b1;
                            end else if (!sequential_next_cached &&
                                         sequential_next_in_range) begin
                                prefetch_pending_q <= 1'b1;
                            end else begin
                                prefetch_pending_q <= 1'b0;
                            end
                        end
                    end else begin
                        sequential_confidence_q <= 2'b0;
                        prefetch_pending_q      <= 1'b0;
                    end
                end
            end

            if (can_start_prefetch) begin
                prefetch_active_q         <= 1'b1;
                prefetch_active_addr_q    <= prefetch_candidate_addr_q;
                prefetch_pending_q        <= 1'b0;
                if (!counter_freeze_q)
                    prefetch_issued_count_q <=
                        prefetch_issued_count_q + 1'b1;
            end

            if (cache_flush_i) begin
                way0_valid_q      <= '0;
                way1_valid_q      <= '0;
                way0_prefetched_q <= '0;
                way1_prefetched_q <= '0;
                lru_victim_q      <= 1'b0;
            end else if (instruction_fill && cache_enable_i) begin
                if (fill_way0_match) begin
                    way0_valid_q[fill_index]      <= 1'b1;
                    way0_prefetched_q[fill_index] <= fill_is_prefetch;
                    if (!fill_is_prefetch)
                        lru_victim_q <= 1'b1;
                end else if (fill_way1_match) begin
                    way1_valid_q[fill_index]      <= 1'b1;
                    way1_prefetched_q[fill_index] <= fill_is_prefetch;
                    if (!fill_is_prefetch)
                        lru_victim_q <= 1'b0;
                end else if (!way0_occupied) begin
                    way0_tag_q              <= fill_line_tag;
                    way0_valid_q            <= fill_word_mask;
                    way0_prefetched_q       <=
                        fill_is_prefetch ? fill_word_mask : '0;
                    lru_victim_q <= fill_is_prefetch ? 1'b0 : 1'b1;
                end else if (!way1_occupied) begin
                    way1_tag_q              <= fill_line_tag;
                    way1_valid_q            <= fill_word_mask;
                    way1_prefetched_q       <=
                        fill_is_prefetch ? fill_word_mask : '0;
                    lru_victim_q <= fill_is_prefetch ? 1'b1 : 1'b0;
                end else if (lru_victim_q == 1'b0) begin
                    way0_tag_q              <= fill_line_tag;
                    way0_valid_q            <= fill_word_mask;
                    way0_prefetched_q       <=
                        fill_is_prefetch ? fill_word_mask : '0;
                    lru_victim_q <= fill_is_prefetch ? 1'b0 : 1'b1;
                end else begin
                    way1_tag_q              <= fill_line_tag;
                    way1_valid_q            <= fill_word_mask;
                    way1_prefetched_q       <=
                        fill_is_prefetch ? fill_word_mask : '0;
                    lru_victim_q <= fill_is_prefetch ? 1'b1 : 1'b0;
                end
            end
        end
    end

    // Cache data is protected by the per-word valid bits, so resetting all
    // data bits wastes a large number of resettable flip-flops.  Keep the data
    // bank in a separate non-reset process; reset/flush invalidates every word
    // in the control process above before the contents can be observed.
    always_ff @(posedge clk_i) begin
        if (rst_ni && !cache_flush_i && instruction_fill && cache_enable_i) begin
            if (fill_way0_match)
                way0_data_q[fill_index] <= ext_mem_rdata_i;
            else if (fill_way1_match)
                way1_data_q[fill_index] <= ext_mem_rdata_i;
            else if (!way0_occupied)
                way0_data_q[fill_index] <= ext_mem_rdata_i;
            else if (!way1_occupied)
                way1_data_q[fill_index] <= ext_mem_rdata_i;
            else if (lru_victim_q == 1'b0)
                way0_data_q[fill_index] <= ext_mem_rdata_i;
            else
                way1_data_q[fill_index] <= ext_mem_rdata_i;
        end
    end

endmodule

`default_nettype wire

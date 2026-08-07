// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

module loopcache_soc (
    input  wire        clk_i,
    input  wire        rst_ni,
    input  wire        cache_enable_i,
    input  wire        cache_flush_i,
    input  wire        prefetch_enable_i,

    output wire [15:0] link_tx_data_o,
    output wire        link_tx_valid_o,
    input  wire        link_tx_ready_i,
    input  wire [15:0] link_rx_data_i,
    input  wire        link_rx_valid_i,
    output wire        link_rx_ready_o,

    output wire        trap_o,
    output wire [31:0] cycle_count_o,
    output wire [31:0] external_ifetch_count_o,
    output wire [31:0] loop_hit_count_o,
    output wire [31:0] stall_count_o
);

    wire        cpu_mem_valid;
    wire        cpu_mem_instr;
    wire        cpu_mem_ready;
    wire [31:0] cpu_mem_addr;
    wire [31:0] cpu_mem_wdata;
    wire [ 3:0] cpu_mem_wstrb;
    wire [31:0] cpu_mem_rdata;

    wire        ext_mem_valid;
    wire        ext_mem_instr;
    wire        ext_mem_ready;
    wire [31:0] ext_mem_addr;
    wire [31:0] ext_mem_wdata;
    wire [ 3:0] ext_mem_wstrb;
    wire [31:0] ext_mem_rdata;

    wire        mem_la_read_unused;
    wire        mem_la_write_unused;
    wire [31:0] mem_la_addr_unused;
    wire [31:0] mem_la_wdata_unused;
    wire [ 3:0] mem_la_wstrb_unused;
    wire        pcpi_valid_unused;
    wire [31:0] pcpi_insn_unused;
    wire [31:0] pcpi_rs1_unused;
    wire [31:0] pcpi_rs2_unused;
    wire [31:0] eoi_unused;
    wire        trace_valid_unused;
    wire [35:0] trace_data_unused;

    picorv32 #(
        .ENABLE_COUNTERS      (1'b0),
        .ENABLE_COUNTERS64    (1'b0),
        .ENABLE_REGS_16_31   (1'b0),
        .ENABLE_REGS_DUALPORT(1'b0),
        .LATCHED_MEM_RDATA   (1'b0),
        .TWO_STAGE_SHIFT     (1'b0),
        .BARREL_SHIFTER      (1'b0),
        .TWO_CYCLE_COMPARE   (1'b1),
        .TWO_CYCLE_ALU       (1'b1),
        .COMPRESSED_ISA      (1'b0),
        .CATCH_MISALIGN      (1'b1),
        .CATCH_ILLINSN       (1'b1),
        .ENABLE_PCPI         (1'b0),
        .ENABLE_MUL          (1'b0),
        .ENABLE_FAST_MUL     (1'b0),
        .ENABLE_DIV          (1'b0),
        .ENABLE_IRQ          (1'b0),
        .ENABLE_IRQ_QREGS    (1'b0),
        .ENABLE_IRQ_TIMER    (1'b0),
        .ENABLE_TRACE        (1'b0),
        .REGS_INIT_ZERO      (1'b0),
        .PROGADDR_RESET      (32'h0000_0000),
        .STACKADDR           (32'h0000_0ff0)
    ) cpu_i (
        .clk           (clk_i),
        .resetn        (rst_ni),
        .trap          (trap_o),
        .mem_valid     (cpu_mem_valid),
        .mem_instr     (cpu_mem_instr),
        .mem_ready     (cpu_mem_ready),
        .mem_addr      (cpu_mem_addr),
        .mem_wdata     (cpu_mem_wdata),
        .mem_wstrb     (cpu_mem_wstrb),
        .mem_rdata     (cpu_mem_rdata),
        .mem_la_read   (mem_la_read_unused),
        .mem_la_write  (mem_la_write_unused),
        .mem_la_addr   (mem_la_addr_unused),
        .mem_la_wdata  (mem_la_wdata_unused),
        .mem_la_wstrb  (mem_la_wstrb_unused),
        .pcpi_valid    (pcpi_valid_unused),
        .pcpi_insn     (pcpi_insn_unused),
        .pcpi_rs1      (pcpi_rs1_unused),
        .pcpi_rs2      (pcpi_rs2_unused),
        .pcpi_wr       (1'b0),
        .pcpi_rd       (32'b0),
        .pcpi_wait     (1'b0),
        .pcpi_ready    (1'b0),
        .irq           (32'b0),
        .eoi           (eoi_unused),
        .trace_valid   (trace_valid_unused),
        .trace_data    (trace_data_unused)
    );

    loopcache_frontend #(
        // Keep the same eight-word data capacity as the V1 1x8 buffer while
        // splitting it across two independently tagged ways.  This makes the
        // architectural comparison capacity-neutral and keeps the macro
        // implementable in the fixed HeiChips Large slot.
        .LINE_WORDS(4)
    ) frontend_i (
        .clk_i                  (clk_i),
        .rst_ni                 (rst_ni),
        .cache_enable_i         (cache_enable_i),
        .cache_flush_i          (cache_flush_i),
        .prefetch_enable_i      (prefetch_enable_i),

        .core_mem_valid_i       (cpu_mem_valid),
        .core_mem_instr_i       (cpu_mem_instr),
        .core_mem_addr_i        (cpu_mem_addr),
        .core_mem_wdata_i       (cpu_mem_wdata),
        .core_mem_wstrb_i       (cpu_mem_wstrb),
        .core_mem_ready_o       (cpu_mem_ready),
        .core_mem_rdata_o       (cpu_mem_rdata),

        .ext_mem_valid_o        (ext_mem_valid),
        .ext_mem_instr_o        (ext_mem_instr),
        .ext_mem_addr_o         (ext_mem_addr),
        .ext_mem_wdata_o        (ext_mem_wdata),
        .ext_mem_wstrb_o        (ext_mem_wstrb),
        .ext_mem_ready_i        (ext_mem_ready),
        .ext_mem_rdata_i        (ext_mem_rdata),

        .cycle_count_o          (cycle_count_o),
        .external_ifetch_count_o(external_ifetch_count_o),
        .loop_hit_count_o       (loop_hit_count_o),
        .stall_count_o          (stall_count_o)
    );

    narrow_mem_bridge bridge_i (
        .clk_i          (clk_i),
        .rst_ni         (rst_ni),
        .mem_valid_i    (ext_mem_valid),
        .mem_instr_i    (ext_mem_instr),
        .mem_addr_i     (ext_mem_addr),
        .mem_wdata_i    (ext_mem_wdata),
        .mem_wstrb_i    (ext_mem_wstrb),
        .mem_ready_o    (ext_mem_ready),
        .mem_rdata_o    (ext_mem_rdata),
        .link_tx_data_o (link_tx_data_o),
        .link_tx_valid_o(link_tx_valid_o),
        .link_tx_ready_i(link_tx_ready_i),
        .link_rx_data_i (link_rx_data_i),
        .link_rx_valid_i(link_rx_valid_i),
        .link_rx_ready_o(link_rx_ready_o)
    );

    wire _unused = &{mem_la_read_unused, mem_la_write_unused,
                     mem_la_addr_unused, mem_la_wdata_unused,
                     mem_la_wstrb_unused, pcpi_valid_unused,
                     pcpi_insn_unused, pcpi_rs1_unused, pcpi_rs2_unused,
                     eoi_unused, trace_valid_unused, trace_data_unused};

endmodule

`default_nettype wire

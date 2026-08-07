// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

// Converts PicoRV32's 32-bit memory handshake into a 16-bit packet link.
//
// Request header:
//   [15]    write (0 = read, 1 = write)
//   [14]    instruction access
//   [13:4]  32-bit word address in the 4 KiB shared SRAM
//   [3:0]   byte write strobes
//
// A write header is followed by low and high 16-bit data beats. A read header
// is followed by low and high 16-bit response beats.
module narrow_mem_bridge (
    input  wire        clk_i,
    input  wire        rst_ni,

    input  wire        mem_valid_i,
    input  wire        mem_instr_i,
    input  wire [31:0] mem_addr_i,
    input  wire [31:0] mem_wdata_i,
    input  wire [ 3:0] mem_wstrb_i,
    output wire        mem_ready_o,
    output wire [31:0] mem_rdata_o,

    output logic [15:0] link_tx_data_o,
    output logic        link_tx_valid_o,
    input  wire         link_tx_ready_i,
    input  wire [15:0]  link_rx_data_i,
    input  wire         link_rx_valid_i,
    output logic        link_rx_ready_o
);

    typedef enum logic [2:0] {
        IDLE,
        SEND_HEADER,
        SEND_WRITE_LOW,
        SEND_WRITE_HIGH,
        RECEIVE_READ_LOW,
        RECEIVE_READ_HIGH,
        RESPOND
    } state_t;

    state_t state_q;
    logic        write_q;
    logic        instr_q;
    logic [31:0] addr_q;
    logic [31:0] wdata_q;
    logic [ 3:0] wstrb_q;
    logic [31:0] rdata_q;

    assign mem_ready_o = (state_q == RESPOND);
    assign mem_rdata_o = rdata_q;

    always_comb begin
        link_tx_data_o  = 16'b0;
        link_tx_valid_o = 1'b0;
        link_rx_ready_o = 1'b0;

        case (state_q)
            SEND_HEADER: begin
                link_tx_data_o  = {write_q, instr_q, addr_q[11:2], wstrb_q};
                link_tx_valid_o = 1'b1;
            end
            SEND_WRITE_LOW: begin
                link_tx_data_o  = wdata_q[15:0];
                link_tx_valid_o = 1'b1;
            end
            SEND_WRITE_HIGH: begin
                link_tx_data_o  = wdata_q[31:16];
                link_tx_valid_o = 1'b1;
            end
            RECEIVE_READ_LOW,
            RECEIVE_READ_HIGH: begin
                link_rx_ready_o = 1'b1;
            end
            default: begin
            end
        endcase
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            state_q <= IDLE;
            write_q <= 1'b0;
            instr_q <= 1'b0;
            addr_q  <= 32'b0;
            wdata_q <= 32'b0;
            wstrb_q <= 4'b0;
            rdata_q <= 32'b0;
        end else begin
            case (state_q)
                IDLE: begin
                    if (mem_valid_i) begin
                        write_q <= |mem_wstrb_i;
                        instr_q <= mem_instr_i;
                        addr_q  <= mem_addr_i;
                        wdata_q <= mem_wdata_i;
                        wstrb_q <= mem_wstrb_i;
                        state_q <= SEND_HEADER;
                    end
                end

                SEND_HEADER: begin
                    if (link_tx_valid_o && link_tx_ready_i) begin
                        if (write_q)
                            state_q <= SEND_WRITE_LOW;
                        else
                            state_q <= RECEIVE_READ_LOW;
                    end
                end

                SEND_WRITE_LOW: begin
                    if (link_tx_valid_o && link_tx_ready_i)
                        state_q <= SEND_WRITE_HIGH;
                end

                SEND_WRITE_HIGH: begin
                    if (link_tx_valid_o && link_tx_ready_i)
                        state_q <= RESPOND;
                end

                RECEIVE_READ_LOW: begin
                    if (link_rx_valid_i && link_rx_ready_o) begin
                        rdata_q[15:0] <= link_rx_data_i;
                        state_q       <= RECEIVE_READ_HIGH;
                    end
                end

                RECEIVE_READ_HIGH: begin
                    if (link_rx_valid_i && link_rx_ready_o) begin
                        rdata_q[31:16] <= link_rx_data_i;
                        state_q        <= RESPOND;
                    end
                end

                RESPOND: begin
                    state_q <= IDLE;
                end

                default: state_q <= IDLE;
            endcase
        end
    end

endmodule

`default_nettype wire

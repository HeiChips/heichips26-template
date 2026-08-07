// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

module link_bram_backend #(
    parameter string INIT_FILE = "firmware/loopcache_test.hex"
) (
    input  wire        clk_i,
    input  wire        rst_ni,

    input  wire [15:0] link_tx_data_i,
    input  wire        link_tx_valid_i,
    output logic       link_tx_ready_o,
    output logic [15:0] link_rx_data_o,
    output logic       link_rx_valid_o,
    input  wire        link_rx_ready_i
);

    typedef enum logic [2:0] {
        RX_HEADER,
        RX_WRITE_LOW,
        RX_WRITE_HIGH,
        SEND_READ_LOW,
        SEND_READ_HIGH
    } state_t;

    (* ram_style = "block" *) logic [31:0] memory [0:1023];

    state_t state_q;
    logic [9:0]  address_q;
    logic [3:0]  write_strobes_q;
    logic [15:0] write_low_q;
    logic [31:0] read_data_q;
    logic [31:0] merged_write;

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            memory[i] = 32'b0;
        $readmemh(INIT_FILE, memory);
    end

    always_comb begin
        link_tx_ready_o = (state_q == RX_HEADER) ||
                          (state_q == RX_WRITE_LOW) ||
                          (state_q == RX_WRITE_HIGH);
        link_rx_valid_o = (state_q == SEND_READ_LOW) ||
                          (state_q == SEND_READ_HIGH);
        link_rx_data_o  = (state_q == SEND_READ_HIGH) ? read_data_q[31:16]
                                                       : read_data_q[15:0];

        merged_write = memory[address_q];
        for (int byte_index = 0; byte_index < 4; byte_index = byte_index + 1) begin
            if (write_strobes_q[byte_index]) begin
                if (byte_index < 2)
                    merged_write[8*byte_index +: 8] =
                        write_low_q[8*byte_index +: 8];
                else
                    merged_write[8*byte_index +: 8] =
                        link_tx_data_i[8*(byte_index-2) +: 8];
            end
        end
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            state_q         <= RX_HEADER;
            address_q       <= 10'b0;
            write_strobes_q <= 4'b0;
            write_low_q     <= 16'b0;
            read_data_q     <= 32'b0;
        end else begin
            case (state_q)
                RX_HEADER: begin
                    if (link_tx_valid_i && link_tx_ready_o) begin
                        address_q       <= link_tx_data_i[13:4];
                        write_strobes_q <= link_tx_data_i[3:0];
                        if (link_tx_data_i[15]) begin
                            state_q <= RX_WRITE_LOW;
                        end else begin
                            read_data_q <= memory[link_tx_data_i[13:4]];
                            state_q     <= SEND_READ_LOW;
                        end
                    end
                end

                RX_WRITE_LOW: begin
                    if (link_tx_valid_i && link_tx_ready_o) begin
                        write_low_q <= link_tx_data_i;
                        state_q     <= RX_WRITE_HIGH;
                    end
                end

                RX_WRITE_HIGH: begin
                    if (link_tx_valid_i && link_tx_ready_o) begin
                        memory[address_q] <= merged_write;
                        state_q           <= RX_HEADER;
                    end
                end

                SEND_READ_LOW: begin
                    if (link_rx_valid_o && link_rx_ready_i)
                        state_q <= SEND_READ_HIGH;
                end

                SEND_READ_HIGH: begin
                    if (link_rx_valid_o && link_rx_ready_i)
                        state_q <= RX_HEADER;
                end

                default: state_q <= RX_HEADER;
            endcase
        end
    end

endmodule

`default_nettype wire

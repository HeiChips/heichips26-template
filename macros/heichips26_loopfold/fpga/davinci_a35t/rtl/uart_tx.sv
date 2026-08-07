// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

module uart_tx #(
    parameter integer CLOCK_HZ = 50_000_000,
    parameter integer BAUD     = 115_200
) (
    input  wire       clk_i,
    input  wire       rst_ni,
    input  wire [7:0] data_i,
    input  wire       valid_i,
    output logic      ready_o,
    output logic      tx_o,
    output logic      busy_o
);

    localparam integer CLKS_PER_BIT = CLOCK_HZ / BAUD;
    localparam integer BAUD_CNT_W   = $clog2(CLKS_PER_BIT);
    localparam logic [BAUD_CNT_W-1:0] BAUD_RELOAD = CLKS_PER_BIT - 1;

    logic [BAUD_CNT_W-1:0] baud_cnt_q;
    logic [3:0]            bit_cnt_q;
    logic [9:0]            shifter_q;

    assign busy_o  = (bit_cnt_q != 4'd0);
    assign ready_o = !busy_o;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            baud_cnt_q <= '0;
            bit_cnt_q  <= 4'd0;
            shifter_q  <= 10'h3ff;
            tx_o       <= 1'b1;
        end else begin
            if (!busy_o) begin
                tx_o <= 1'b1;
                if (valid_i) begin
                    shifter_q  <= {1'b1, data_i, 1'b0};
                    bit_cnt_q  <= 4'd10;
                    baud_cnt_q <= BAUD_RELOAD;
                    tx_o       <= 1'b0;
                end
            end else if (baud_cnt_q == '0) begin
                shifter_q  <= {1'b1, shifter_q[9:1]};
                tx_o       <= shifter_q[1];
                bit_cnt_q  <= bit_cnt_q - 1'b1;
                baud_cnt_q <= BAUD_RELOAD;
            end else begin
                baud_cnt_q <= baud_cnt_q - 1'b1;
            end
        end
    end

endmodule

`default_nettype wire

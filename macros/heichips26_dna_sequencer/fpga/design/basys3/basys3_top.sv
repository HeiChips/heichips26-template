// SPDX-FileCopyrightText: © 2026 The HeiChips Contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module basys3_top (
    input  logic clk,
    input  logic rst,
    input  logic uart_rxd,
    output logic uart_txd
);

fpga_top_module fpga_top_module_inst (
    .clk(clk),
    .rst(rst),
    .uart_rxd(uart_rxd),
    .uart_txd(uart_txd)
);


endmodule

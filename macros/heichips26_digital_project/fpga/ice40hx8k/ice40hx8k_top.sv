// SPDX-FileCopyrightText: © 2025 XXX Authors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module ice40hx8k_top (
	input  logic SYSCLK,    // 100 MHz
	input  logic BUT1,
	input  logic BUT2,
	output logic LED1,
	output logic LED2
);

    logic clk;
    logic rst_n;
    logic ena;
    logic [7:0] ui_in;
    logic [7:0] uio_in;
    logic [7:0] uo_out;
    logic [7:0] uio_out;
    logic [7:0] uio_oe;
    
    heichips25_template heichips25_template (
        .ui_in  (ui_in),    // Dedicated inputs
        .uo_out (uo_out),   // Dedicated outputs
        .uio_in (uio_in),   // IOs: Input path
        .uio_out(uio_out),  // IOs: Output path
        .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena    (ena),      // enable - goes high when design is selected
        .clk    (clk),      // clock
        .rst_n  (rst_n)     // not reset
    );
    
    // Assignments

    assign clk = SYSCLK;
    assign ena = 1'b1;
    assign rst_n = !BUT1;
    
    assign ui_in = {7'b0, BUT2};
    assign uio_in = {7'b0, BUT2};
    
    assign LED1 = uo_out[0];
    assign LED2 = uo_out[1];

endmodule

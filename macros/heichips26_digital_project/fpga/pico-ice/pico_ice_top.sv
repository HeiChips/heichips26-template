// SPDX-FileCopyrightText: © 2026 The HeiChips contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module pico_ice_top (
    input  logic       clk_i,
    input  logic       rst_ni, // active-low push button
    input  logic       enable_i,

    output logic [7:0] count_o
);

    logic rst_n;
    logic ena;
    logic [7:0] ui_in;
    logic [7:0] uio_in;
    logic [7:0] uo_out;
    logic [7:0] uio_out;
    logic [7:0] uio_oe;

    heichips26_digital_project heichips26_digital_project (
        .ui_in,        // Dedicated inputs
        .uo_out,       // Dedicated outputs
        .uio_in,       // IOs: Input path
        .uio_out,      // IOs: Output path
        .uio_oe,       // IOs: Enable path (active high: 0=input, 1=output)
        .ena,          // enable - goes high when design is selected
        .clk  (clk_i), // clock
        .rst_n         // not reset
    );

    // Assignments

    assign ena    = 1'b1;
    assign rst_n  = rst_ni;
    assign uio_in = '0;
    assign ui_in  = {7'b0, enable_i}; // enable_i drives ui_in[0] (design enable)

    assign count_o = uo_out;

endmodule

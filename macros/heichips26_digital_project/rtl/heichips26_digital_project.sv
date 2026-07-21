// SPDX-FileCopyrightText: © 2025 XXX Authors
// SPDX-License-Identifier: Apache-2.0

// Adapted from the Tiny Tapeout template

`default_nettype none

module heichips26_digital_project (
`ifdef USE_POWER_PINS
    inout  wire VPWR,
    inout  wire VGND,
`endif
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, ui_in[7:1], uio_in[7:1]};
    
    logic [7:0] count;
    
    counter counter_0 (
    `ifdef USE_POWER_PINS
        .VPWR  (VPWR),
        .VGND  (VGND),
    `endif
        .clk_i    (clk),
        .rst_ni   (rst_n),
        .enable_i (ui_in[0]),

        .count_o  (count)
    );
    
    assign uo_out  = count;
    assign uio_out = count;
    assign uio_oe  = '1;

endmodule

// SPDX-FileCopyrightText: © 2026 XXX Authors
// SPDX-License-Identifier: Apache-2.0

// Adapted from the Tiny Tapeout template

`default_nettype none
`include "macros.svh"

module heichips26_dna_sequencer (
`ifdef USE_POWER_PINS
    inout  wire VPWR,
    inout  wire VGND,
`endif
    input  wire [7:0] ui_in,    // Dedicated inputs - All used. 
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_in};

    logic signed [`REG_WIDTH-1:0] max_out_reg;
    logic s_in_ready_reg, t_in_ready_reg, max_valid_reg;

    systolic_array systolic_array_inst (
        .clk(clk), 
        .rstn(rst_n),
        .s_in(ui_in[2:0]), 
        .t_in(ui_in[5:3]),
        .s_in_valid(ui_in[6]), 
        .t_in_valid(ui_in[7]),
        .s_in_ready(s_in_ready_reg), 
        .t_in_ready(t_in_ready_reg),
        .max_valid(max_valid_reg),
        .max_out(max_out_reg)
    );
    
    assign uo_out  = {{(8-`REG_WIDTH){1'b0}}, max_out_reg};
    assign uio_out = {5'b0, max_valid_reg, t_in_ready_reg, s_in_ready_reg};
    assign uio_oe  = '1;
    
    /*logic [7:0] count;
    
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
    assign uio_oe  = '1;*/

endmodule

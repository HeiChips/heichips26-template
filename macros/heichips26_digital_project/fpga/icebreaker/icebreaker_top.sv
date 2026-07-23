// SPDX-FileCopyrightText: © 2026 The HeiChips contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

// Generic chip-IO breakout: full ui_in/uo_out/uio bus on Pmods, fixed bit
// order (pin 1 -> bit 0 ... pin 10 -> bit 7). uio is reconstructed into a real
// bidirectional pin here, standing in for the chip padframe. Design-agnostic.
//   PMOD1A -> ui_in[7:0]   (inputs)
//   PMOD2  -> uo_out[7:0]  (outputs)
//   PMOD1B -> uio[7:0]     (bidirectional, per-bit uio_oe)
// clk = raw 12 MHz, rst_n = BTN_N (active low).
module icebreaker_top (
    input logic CLK,  // 12 MHz

    // Built-in button and status LEDs
    input  logic BTN_N,
    output logic LEDR_N,
    output logic LEDG_N,

    // PMOD 1A -> ui_in[7:0]
    input logic P1A1,
    input logic P1A2,
    input logic P1A3,
    input logic P1A4,
    input logic P1A7,
    input logic P1A8,
    input logic P1A9,
    input logic P1A10,

    // PMOD 1B -> uio[7:0] (bidirectional)
    inout wire P1B1,
    inout wire P1B2,
    inout wire P1B3,
    inout wire P1B4,
    inout wire P1B7,
    inout wire P1B8,
    inout wire P1B9,
    inout wire P1B10,

    // PMOD 2 -> uo_out[7:0]
    output logic P2_1,
    output logic P2_2,
    output logic P2_3,
    output logic P2_4,
    output logic P2_7,
    output logic P2_8,
    output logic P2_9,
    output logic P2_10
);

    logic       clk;
    logic       rst_n;
    logic       ena;
    logic [7:0] ui_in;
    logic [7:0] uio_in;
    logic [7:0] uo_out;
    logic [7:0] uio_out;
    logic [7:0] uio_oe;

    heichips26_digital_project heichips26_digital_project (
        .ui_in,    // Dedicated inputs
        .uo_out,   // Dedicated outputs
        .uio_in,   // IOs: Input path
        .uio_out,  // IOs: Output path
        .uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
        .ena,      // enable - goes high when design is selected
        .clk,      // clock
        .rst_n     // not reset
    );

    // Clock and reset
    assign clk   = CLK;
    assign ena   = 1'b1;
    assign rst_n = BTN_N;

    // Inputs: PMOD1A -> ui_in (pin 1 -> bit 0 ... pin 10 -> bit 7)
    assign ui_in = {P1A10, P1A9, P1A8, P1A7, P1A4, P1A3, P1A2, P1A1};

    // Outputs: uo_out -> PMOD2
    assign {P2_10, P2_9, P2_8, P2_7, P2_4, P2_3, P2_2, P2_1} = uo_out;

    // Bidirectional: uio <-> PMOD1B (drive when uio_oe, else high-Z and read)
    assign P1B1  = uio_oe[0] ? uio_out[0] : 1'bz;
    assign P1B2  = uio_oe[1] ? uio_out[1] : 1'bz;
    assign P1B3  = uio_oe[2] ? uio_out[2] : 1'bz;
    assign P1B4  = uio_oe[3] ? uio_out[3] : 1'bz;
    assign P1B7  = uio_oe[4] ? uio_out[4] : 1'bz;
    assign P1B8  = uio_oe[5] ? uio_out[5] : 1'bz;
    assign P1B9  = uio_oe[6] ? uio_out[6] : 1'bz;
    assign P1B10 = uio_oe[7] ? uio_out[7] : 1'bz;
    assign uio_in = {P1B10, P1B9, P1B8, P1B7, P1B4, P1B3, P1B2, P1B1};

    // Status LEDs mirror the low output bits (active low)
    assign LEDR_N = ~uo_out[0];
    assign LEDG_N = ~uo_out[1];

endmodule

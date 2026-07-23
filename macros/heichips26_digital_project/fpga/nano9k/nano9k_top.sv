// SPDX-FileCopyrightText: © 2026 The HeiChips contributors
// SPDX-License-Identifier: Apache-2.0

// Partial chip-IO breakout; see fpga/icebreaker for the full reference.
// HDMI (TMDS_*) shares an I/O bank with PMOD1 and PMOD3 — using either as
// a live header conflicts with the HDMI pads at the gowin_pack stage
// (bank forces one shared IO standard). Kept HDMI, so no uio (needs a
// free 8-pin header) and ui_in only gets PMOD4's 4 pins:
//   PMOD2 (P2_1..P2_8) -> uo_out[7:0]  (outputs)
//   PMOD4 (P4_1..P4_4) -> ui_in[3:0]   (inputs; ui_in[7:4] tied 0)
// PMOD1/PMOD3 stay unused (would conflict with HDMI if driven).
// clk = raw 27 MHz, rst_n = RST_N (S1 button, active low).
// LEDS_N mirrors the low output bits (active low), convenience only.
module nano9k_top (
    input logic CLK,   // 27 MHz
    input logic RST_N, // S1 Button, active low

    // Onboard peripherals
    output logic [5:0] LEDS_N,
    input  logic       BTN_N,   // S2 Button, unused

    // HDMI, unused
    output logic [2:0] TMDS_D_P,
    output logic [2:0] TMDS_D_N,
    output logic TMDS_CLK_P,
    output logic TMDS_CLK_N,

    // Pascal Tang Nano 9K Baseboard mappings
    // https://github.com/gfcwfzkm/t9k-baseboard
    // PMOD 1, unused (shares HDMI's I/O bank)
    input logic P1_1,
    input logic P1_2,
    input logic P1_3,
    input logic P1_4,
    input logic P1_5,
    input logic P1_6,
    input logic P1_7,
    input logic P1_8,

    // PMOD 2 -> uo_out[7:0]
    output logic P2_1,
    output logic P2_2,
    output logic P2_3,
    output logic P2_4,
    output logic P2_5,
    output logic P2_6,
    output logic P2_7,
    output logic P2_8,

    // PMOD 3, unused (shares HDMI's I/O bank)
    input logic P3_1,
    input logic P3_2,
    input logic P3_3,
    input logic P3_4,
    input logic P3_5,
    input logic P3_6,
    input logic P3_7,
    input logic P3_8,

    // PMOD 4 -> ui_in[3:0]
    input logic P4_1,
    input logic P4_2,
    input logic P4_3,
    input logic P4_4
);

    logic clk;
    logic rst_n;
    logic ena;
    logic [7:0] ui_in;
    logic [7:0] uio_in;
    logic [7:0] uo_out;
    logic [7:0] uio_out;
    logic [7:0] uio_oe;

    heichips26_digital_project heichips26_digital_project (
        .ui_in,  // Dedicated inputs
        .uo_out,  // Dedicated outputs
        .uio_in,  // IOs: Input path
        .uio_out,  // IOs: Output path
        .uio_oe,  // IOs: Enable path (active high: 0=input, 1=output)
        .ena,  // enable - goes high when design is selected
        .clk,  // clock
        .rst_n  // not reset
    );

    // Clock and reset
    assign clk = CLK;
    assign ena = 1'b1;
    assign rst_n = RST_N;

    // Outputs: uo_out -> PMOD2
    assign {P2_8, P2_7, P2_6, P2_5, P2_4, P2_3, P2_2, P2_1} = uo_out;

    // Inputs: PMOD4 -> ui_in[3:0] (pin 1 -> bit 0 ... pin 4 -> bit 3)
    assign ui_in = {4'b0, P4_4, P4_3, P4_2, P4_1};
    assign uio_in = '0;

    // Status LEDs mirror the low output bits (active low), convenience only
    assign LEDS_N = ~uo_out[5:0];

endmodule


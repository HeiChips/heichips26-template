// SPDX-FileCopyrightText: © 2026 The HeiChips contributors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

// Generic chip-IO breakout; see fpga/icebreaker for the reference.
//   btn[1]   -> ui_in[0]      (FIRE1/F1 button, hold to enable counter)
//   gp[7:1]  -> ui_in[7:1]    (J1 header inputs, pulled up)
//   gn[7:0]  -> uio[7:0]      (J1 header, bidirectional)
//   led[7:0] -> uo_out[7:0]   (onboard LEDs)
// clk = raw 25 MHz, rst_n = btn[0] (active low).
module ulx3s_top (
    input logic clk_25mhz,

    input  logic [6:0] btn,
    output logic [7:0] led,

    input wire [7:0] gp,  // J1 header -> ui_in
    inout wire [7:0] gn   // J1 header -> uio (bidirectional)
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
    assign clk   = clk_25mhz;
    assign ena   = 1'b1;
    assign rst_n = btn[0];  // BTN_PWRn, active low

    // Inputs: FIRE1/F1 button -> ui_in[0] (counter enable), J1 gp[7:1] -> ui_in[7:1]
    assign ui_in = {gp[7:1], btn[1]};

    // Outputs: uo_out -> onboard LEDs
    assign led = uo_out;

    // Bidirectional: uio <-> J1 gn[7:0] (drive when uio_oe, else high-Z and read)
    for (genvar i = 0; i < 8; i++) begin : gen_uio
        assign gn[i] = uio_oe[i] ? uio_out[i] : 1'bz;
    end
    assign uio_in = gn;

endmodule

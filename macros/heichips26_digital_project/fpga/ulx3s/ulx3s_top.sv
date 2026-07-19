// SPDX-FileCopyrightText: © 2025 XXX Authors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module ulx3s_top (
    input clk_25mhz,

    input  [6:0] btn,
    output [7:0] led,

    output logic [27:0] gn,
    output logic [27:0] gp
);
    logic reset_n;
    assign reset_n = btn[0];

    logic video_clk;

    pll40m pll40m_i
    (
        .clkin      (clk_25mhz), // 25 MHz, 0 deg
        .clkout0    (video_clk), // 40 MHz, 0 deg
        .locked     ()
    );
    
    logic [24-1:0] counter;
    
    always_ff @(posedge video_clk, negedge reset_n) begin
        if (!reset_n) begin
            counter <= '0;
        end else begin
            counter <= counter + 1;
        end
    end
    
    assign led[0] = counter[24-1];
    assign led[1] = !counter[24-1];
    
    logic clk;
    logic rst_n;
    logic ena;
    logic [7:0] ui_in;
    logic [7:0] uio_in;
    logic [7:0] uo_out;
    logic [7:0] uio_out;
    logic [7:0] uio_oe;
    
    heichips25_template heichips25_template (
        .ui_in,
        .uo_out,
        .uio_in,
        .uio_out,
        .uio_oe,
        .ena,
        .clk,
        .rst_n
    );
    
    // Assignments
    
    assign ena = 1'b1;
    assign clk = video_clk;
    assign rst_n = reset_n;
    
    assign ui_in = 8'b0;
    assign uio_in = 8'b0;
    
    // Pinout for Tiny VGA
    
    wire [1:0] R;
    wire [1:0] G;
    wire [1:0] B;
    wire hsync, vsync;

    assign R[1] = uo_out[0];
    assign G[1] = uo_out[1];
    assign B[1] = uo_out[2];
    assign vsync = uo_out[3];
    assign R[0] = uo_out[4];
    assign G[0] = uo_out[5];
    assign B[0] = uo_out[6];
    assign hsync = uo_out[7];

    assign gn[21] = vsync; assign gp[21] = hsync;
    assign gn[22] = B[1]; assign gp[22] = B[0];
    assign gn[23] = G[1]; assign gp[23] = G[0];
    assign gn[24] = R[1]; assign gp[24] = R[0];

endmodule

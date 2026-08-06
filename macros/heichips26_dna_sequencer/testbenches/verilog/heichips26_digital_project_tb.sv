// SPDX-FileCopyrightText: 2026 XXX
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Description: SystemVerilog testbench for the heichips26_digital_project module.

`timescale 1ns / 1ps

module heichips26_digital_project_tb;
  // Parameters
  parameter  real CLK_FREQ      = 50.0e6;
  parameter  int  CTR_WIDTH     = 8;
  parameter  int  CTR_MAX       = 2**CTR_WIDTH-1;
  localparam real CLK_PERIOD_NS = 1e9 / CLK_FREQ;

  // Signals
  logic                 clk    = 1'b0;
  logic                 rst_n  = 1'b1; // active-low reset
  logic                 enable = 1'b0;
  logic [CTR_WIDTH-1:0] count;

  // DUT
  heichips26_digital_project dut_heichips26_digital_project (
    .clk      (clk),
    .rst_n    (rst_n),
    .ena      (1'b1),
    .ui_in    ({7'b0, enable}),
    .uo_out   (count),
    .uio_in   ({8'b0}),
    .uio_out  (),
    .uio_oe   ()
  );

  // Clock generation
  /* verilator lint_off STMTDLY */
  always #(CLK_PERIOD_NS / 2) clk = ~clk;
  /* verilator lint_on STMTDLY */

  // Self-checking stimulus
  initial begin
    $dumpfile("heichips26_digital_project_tb.fst");
    $dumpvars;

    // Reset pulse (2 clock cycles)
    rst_n = 1'b0;
    #(2 * CLK_PERIOD_NS);
    rst_n = 1'b1;
    #(CLK_PERIOD_NS);

    if (count !== '0)
      $fatal(1, "FAIL: heichips26_digital_project not zero after reset (got %0d)", count);

    // Hold disabled for a few cycles; value must not change
    #(5 * CLK_PERIOD_NS);
    if (count !== '0)
      $fatal(1, "FAIL: heichips26_digital_project changed while disabled (got %0d)", count);

    // Enable heichips26_digital_project, run for one full wrap and a few extra cycles
    enable = 1'b1;
    #((CTR_MAX + 5) * CLK_PERIOD_NS);
    enable = 1'b0;

    // Disabled hold check
    #(5 * CLK_PERIOD_NS);

    // Re-enable, run another batch
    enable = 1'b1;
    #(10 * CLK_PERIOD_NS);
    enable = 1'b0;
    #(2 * CLK_PERIOD_NS);

    $display("PASS: simulation complete.");
    $finish;
  end
endmodule // heichips26_digital_project_tb

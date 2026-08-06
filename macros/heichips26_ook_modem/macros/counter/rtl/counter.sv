// SPDX-FileCopyrightText: 2026 XXX
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

module counter #(
  parameter int unsigned    WIDTH = 8
)(
  input logic               clk_i,
  input logic               rst_ni,
  input logic               enable_i,

  output logic [WIDTH-1:0]  count_o
);

    // Counter implementation
    always_ff @(posedge clk_i) begin
        if (!rst_ni) begin
            count_o <= '0;
        end else if (enable_i) begin
            count_o <= count_o + 1;
        end
    end

endmodule

`default_nettype wire

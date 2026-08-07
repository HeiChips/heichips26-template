`include "macros.svh"

`timescale 1ns/10ps

module PE_tb();

localparam CLK_PERIOD = 10;

logic clk, rstn;
logic [2:0] s_in, t_in;
logic shift_s;
logic signed [`REG_WIDTH-1:0] max_in, f_in, v_in;
logic [2:0] s_out, t_out;
logic signed [`REG_WIDTH-1:0] max_out, f_out, v_out;

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


PE dut(
    .clk(clk),
    .rstn(rstn),
    .s_in(s_in),
    .t_in(t_in),
    .shift_s(shift_s),
    .max_in(max_in),
    .f_in(f_in),
    .v_in(v_in),
    .s_out(s_out),
    .t_out(t_out),
    .max_out(max_out),
    .f_out(f_out),
    .v_out(v_out)
);

initial begin 
    @(posedge clk);
    clk = 1'b0;
    rstn = 1'b0;
    s_in = '0;
    t_in = '0;
    shift_s = 1'b0;
    max_in = '0;
    f_in = '0;
    v_in = '0;

    @(posedge clk);
    rstn = 1'b1;

    test_match();

    @(posedge clk);
    rstn = 1'b0;
    s_in = '0;
    t_in = '0;
    max_in = '0;
    f_in = '0;
    v_in = '0;

    @(posedge clk);
    rstn = 1'b1;

    test_mismatch();

    @(posedge clk);

    $finish;


end

logic signed [`REG_WIDTH-1:0] expected_max_out, expected_f_out, expected_v_out;


task automatic test_match();
    @(negedge clk);
    s_in = `BASE_A;
    shift_s = 1'b1;
    @(negedge clk);
    t_in = `BASE_A;
    shift_s = 1'b0;
    max_in = 'd4;
    f_in = 0;
    v_in = 'd3;

    expected_max_out = 'd4; // max(4, 0, 0)
    expected_f_out = 1; // max(1, -1, 0)
    expected_v_out = 2; // max(2, 0, 1)

    @(negedge clk);

    if(max_out == expected_max_out && f_out == expected_f_out && v_out == expected_v_out) begin
        $display("Test Match Passed");
    end
    else begin
        $display("Test Match Failed");
    end

endtask

task automatic test_mismatch();
    @(negedge clk);
    s_in = `BASE_A;
    shift_s = 1'b1;
    @(negedge clk);
    t_in = `BASE_C;
    shift_s = 1'b0;
    max_in = 'd4;
    f_in = 0;
    v_in = 'd3;

    expected_max_out = 'd4; // max(4, 0, 0)
    expected_f_out = 1; // max(1, -1, 0)
    expected_v_out = 1; // max(-1, 0, 1)

    @(negedge clk);

    if(max_out == expected_max_out && f_out == expected_f_out && v_out == expected_v_out) begin
        $display("Test Mismatch Passed");
    end
    else begin
        $display("Test Mismatch Failed");
    end
endtask

endmodule
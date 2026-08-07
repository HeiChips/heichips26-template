`include "../macros.svh"
/* verilator lint_off DECLFILENAME */
module max_pos2 #(parameter REG_WIDTH = `REG_WIDTH) (
    input logic signed [REG_WIDTH-1:0] a,
    input logic signed [REG_WIDTH-1:0] b,
    output logic signed [REG_WIDTH-1:0] max_out
);

always_comb begin
    if (a >= b) begin
        max_out = (a > 0)? a : '0;
    end
    else begin
        max_out = (b > 0)? b : '0;
    end
end

endmodule

//module max_pos3 (
//    input logic signed [`REG_WIDTH-1:0] a,
//    input logic signed [`REG_WIDTH-1:0] b,
//    input logic signed [`REG_WIDTH-1:0] c,
//    output logic signed [`REG_WIDTH-1:0] max_out
//);

//always_comb begin
//    if ((a >= b) && (a >= c)) begin
//        max_out = (a > 0)? a : '0;
//    end
//    else if ((b >= a) && (b >= c)) begin
//        max_out = (b > 0)? b : '0;
//    end
//    else begin
//        max_out = (c > 0)? c : '0;
//    end
//end

//endmodule

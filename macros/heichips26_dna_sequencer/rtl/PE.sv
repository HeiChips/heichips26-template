`include "macros.svh"

module PE #(parameter REG_WIDTH = `REG_WIDTH)(
    input logic clk, rstn,
    input logic [2:0]s_in,
    input logic [2:0]t_in,
    input logic shift_s,
    input logic signed [REG_WIDTH-1:0] max_in,
    input logic signed [REG_WIDTH-1:0] f_in,
    input logic signed [REG_WIDTH-1:0] v_in,
    input logic result_valid_in,
    output logic [2:0] s_out,
    output logic [2:0] t_out,
    output logic signed [REG_WIDTH-1:0] max_out,
    output logic signed [REG_WIDTH-1:0] f_out,
    output logic signed [REG_WIDTH-1:0] v_out,
    output logic result_valid_out
);

logic signed [REG_WIDTH-1:0] v_diag;
logic signed [REG_WIDTH-1:0] e_out;
logic signed [REG_WIDTH-1:0] m1_out;
logic signed [REG_WIDTH-1:0] m2_out;
logic signed [REG_WIDTH-1:0] m3_out;
logic signed [REG_WIDTH-1:0] m4_out;
logic signed [REG_WIDTH-1:0] m5_out;
logic signed [REG_WIDTH-1:0] m6_out;


// registering values
always_ff @(posedge clk) begin
    if(rstn == 1'b0) begin
        s_out <= '0;
        t_out <= '0;
        max_out <= '0;
        v_out <= '0;
        f_out <= '0;
        v_diag <= '0;
        e_out <= '0;
        result_valid_out <= 1'b0;
    end
    else begin
        if(shift_s) begin // s is only shifted when shift_s is high
            s_out <= s_in;
        end
        t_out <= t_in; // t is always shifted
        result_valid_out <= result_valid_in; // used to find the final result location

        if(result_valid_out == 1'b1) begin // clean the registers after the calculation is done
            max_out <= '0;
            v_out <= '0;
            f_out <= '0;
            v_diag <= '0;
            e_out <= '0;
        end
        else begin
            max_out <= m2_out;
            v_out <= m6_out;
            f_out <= m5_out;
            v_diag <= v_in;
            e_out <= m3_out;
        end
    end
end


logic signed [REG_WIDTH-1:0] s_t_comp;
logic signed [REG_WIDTH-1:0] m6_in1;

st_lut #(.REG_WIDTH(REG_WIDTH)) st_lut1(
    .s(s_out),
    .t(t_in),
    .score(s_t_comp)
);

assign m6_in1 = (v_diag + s_t_comp) > 0 ? (v_diag + s_t_comp) : '0;

max_pos2 #(.REG_WIDTH(REG_WIDTH)) max1(
    .a(max_in),
    .b(v_out),
    .max_out(m1_out)
);

max_pos2 #(.REG_WIDTH(REG_WIDTH)) max2(
    .a(m1_out),
    .b(max_out),
    .max_out(m2_out)
);

max_pos2 #(.REG_WIDTH(REG_WIDTH)) max3(
    .a(e_out - BETA),
    .b(v_out - ALPHA),
    .max_out(m3_out)
);

max_pos2 #(.REG_WIDTH(REG_WIDTH)) max4(
    .a(m3_out),
    .b(m5_out),
    .max_out(m4_out)
);

max_pos2 #(.REG_WIDTH(REG_WIDTH)) max5(
    .a(v_in - ALPHA),
    .b(f_in - BETA),
    .max_out(m5_out)
);

max_pos2 #(.REG_WIDTH(REG_WIDTH)) max6(
    .a(m6_in1),
    .b(m4_out),
    .max_out(m6_out)
);


endmodule

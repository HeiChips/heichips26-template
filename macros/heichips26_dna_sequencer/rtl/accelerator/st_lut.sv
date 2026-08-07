`include "../macros.svh"

module st_lut #(parameter REG_WIDTH = `REG_WIDTH) (
    input logic [2:0] s,
    input logic [2:0] t,
    output logic signed [REG_WIDTH-1:0] score
);

always_comb begin
    if((s[2] == '0) || (t[2] == '0))begin // 2nd bit is 0: reset/idle (not one of the valid characters)
        score = '0;
    end
    else if (s == t) begin
        score = `MATCH;
    end
    else begin
        score = `MISMATCH;
    end
end

endmodule

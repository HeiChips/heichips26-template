`include "macros.svh"

module systolic_array(
    input logic clk, rstn,
    input logic [2:0] s_in, t_in,
    input logic s_in_valid, t_in_valid,
    output logic s_in_ready, t_in_ready,
    output logic max_valid,
    output logic [`REG_WIDTH-1:0] max_out
);

logic [$clog2(`N)-1:0] s_counter, s_counter_next;
logic [$clog2(`M)-1:0] t_counter, t_counter_next;

typedef enum logic [2:0] {
    RESET_STATE = 3'b000,
    IDLE_STATE  = 3'b001,
    SEND_S_STATE  = 3'b010,
    SEND_T_STATE  = 3'b011,
    DONE_STATE  = 3'b100,
    CLEAR_STATE = 3'b101
} state_t;

state_t state, state_next;

// control path
always_ff @(posedge clk) begin
    if(rstn == 1'b0) begin
        state     <= RESET_STATE;
        s_counter <= '0;
        t_counter <= '0;
    end
    else begin
        state     <= state_next;
        s_counter <= s_counter_next;
        t_counter <= t_counter_next;
    end

end

always_comb begin
    state_next = state;
    s_counter_next = s_counter;
    t_counter_next = t_counter;

    case(state)
        RESET_STATE: begin
            state_next = IDLE_STATE;
            s_counter_next = '0;
            t_counter_next = '0;
        end

        IDLE_STATE: begin
            if (s_in_valid && t_in_valid) begin
                state_next = RESET_STATE;
                // $error("Error: Both s_in and t_in are valid at the same time. Only one should be valid.");
            end
            else if(s_in_valid == 1'b1) begin
                state_next = SEND_S_STATE;
                s_counter_next = `N - 1;
            end
            else if(t_in_valid == 1'b1) begin
                state_next = SEND_T_STATE;
                t_counter_next = `M - 1;
            end
        end

        SEND_S_STATE: begin
            if (s_counter > 0) begin
                s_counter_next = s_counter - 1;
            end
            else begin
                if(t_in_valid == 1'b1) begin
                    state_next = SEND_T_STATE;
                    t_counter_next = `M - 1;
                end
                else begin
                    state_next = IDLE_STATE;
                end
            end
        end

        SEND_T_STATE: begin
            if (t_counter > 0) begin
                t_counter_next = t_counter - 1;
            end
            else begin
                state_next = DONE_STATE;
            end
        end

        DONE_STATE: begin
            state_next = CLEAR_STATE;
        end

        CLEAR_STATE: begin // need this state to reset the systolic array after processing all inputs
            if (s_in_valid == 1'b1 && t_in_valid == 1'b1) begin
                state_next = RESET_STATE;
                // $error("Error: Both s_in and t_in are valid at the same time. Only one should be valid.");
            end
            else if(s_in_valid == 1'b1) begin
                state_next = SEND_S_STATE;
                s_counter_next = `N - 1;
            end
            else if(t_in_valid == 1'b1) begin
                state_next = SEND_T_STATE;
                t_counter_next = `M - 1;
            end
            else begin
                state_next = IDLE_STATE;
            end
        end

        default: begin
            // $error("Error: Invalid state encountered in systolic_array.");
            state_next = RESET_STATE;
        end            

    endcase
end

// data path

genvar i;
logic [`N-1:0][2:0] s_in_bus, t_in_bus, s_out_bus, t_out_bus;
logic [`N-1:0][`REG_WIDTH-1:0] max_in_bus, f_in_bus, v_in_bus, max_out_bus, f_out_bus, v_out_bus;
logic shift_s;
logic [2:0] s_in_bus_0, t_in_bus_0;
logic [`N-1:0]result_valid_in_bus, result_valid_out_bus;
logic result_valid_in_bus_0;

generate
    for(i=0; i<`N; i++) begin : PE_CHAIN

        assign s_in_bus[i]   = (i == 0) ? s_in_bus_0 : s_out_bus[i-1];
        assign t_in_bus[i]   = (i == 0) ? t_in_bus_0 : t_out_bus[i-1];
        assign max_in_bus[i] = (i == 0) ? '0         : max_out_bus[i-1];
        assign f_in_bus[i]   = (i == 0) ? '0         : f_out_bus[i-1];
        assign v_in_bus[i]   = (i == 0) ? '0         : v_out_bus[i-1];
        assign result_valid_in_bus[i] = (i == 0)? result_valid_in_bus_0 : result_valid_out_bus[i-1];
    end
endgenerate

generate
    for(i=0; i<`N; i++) begin : PE_ARRAY
        PE pe_inst(
            .clk(clk),
            .rstn(rstn),
            .s_in(s_in_bus[i]),
            .t_in(t_in_bus[i]),
            .shift_s(shift_s),
            .max_in(max_in_bus[i]),
            .f_in(f_in_bus[i]),
            .v_in(v_in_bus[i]),
            .result_valid_in(result_valid_in_bus[i]),
            .s_out(s_out_bus[i]),
            .t_out(t_out_bus[i]),
            .max_out(max_out_bus[i]),
            .f_out(f_out_bus[i]),
            .v_out(v_out_bus[i]),
            .result_valid_out(result_valid_out_bus[i])

        );
    end
endgenerate

assign shift_s    = (state_next == SEND_S_STATE) ? 1'b1 : 1'b0;
assign s_in_bus_0 = (state_next == SEND_S_STATE) ? s_in : `BASE_IDLE;
assign t_in_bus_0 = (state_next == SEND_T_STATE) ? t_in : `BASE_IDLE;
assign result_valid_in_bus_0 = ((state_next == DONE_STATE) && (t_counter == 0))? 1'b1 : 1'b0;                    

assign max_valid = (result_valid_out_bus[`N-1]) ? 1'b1 : 1'b0;
assign max_out   = max_out_bus[`N-1];

logic processing;
assign processing = (state_next == SEND_T_STATE) || (|result_valid_in_bus);

assign s_in_ready = ~processing;
assign t_in_ready = (state == IDLE_STATE) || (state == SEND_T_STATE) || (state == CLEAR_STATE);

// assert property (@(posedge clk) disable iff (!rstn) 
//     state inside {
//         RESET_STATE,
//         IDLE_STATE,
//         SEND_S_STATE,
//         SEND_T_STATE,
//         DONE_STATE,
//         CLEAR_STATE
//     })
//     else $error("Invalid state: %s", state);

// assert property (@(posedge clk) disable iff (!rstn) !(s_in_valid && t_in_valid)) else $error("Both S and T sequences can not be valid at once");

// assert property (@(posedge clk) disable iff (!rstn) shift_s |-> (state == SEND_S_STATE || state == IDLE_STATE)) else $error("shift_s = 1 at wrong state");

// assert property (@(posedge clk) disable iff (!rstn) max_valid |-> (max_out <= `MAX_SCORE)) else $error("Max_out exceeded possible maximum value");

endmodule
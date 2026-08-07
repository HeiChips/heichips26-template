`include "../macros.svh"

module accelerator_driver (
    input  logic                  clk,
    input  logic                  rstn,       // active-low, synchronous

    //  FIFO_S 
    input  logic [`S_LEN-1:0]     S_dout,
    input  logic                  empty_s,
    output logic                  S_re,

    // FIFO_T 
    input  logic [`T_LEN-1:0]     T_dout,
    input  logic                  empty_t,
    output logic                  T_re,

    //  FIFO_result 
    input  logic                  full_re,
    output logic [`REG_WIDTH-1:0] Result_din,
    output logic                  Result_we,

    //accelerator 
    input  logic                  ready_s,      // accelerator can accept a chunk
    input  logic                  ready_t,      // accelerator can accept a chunk
    input  logic                  valid,      // accelerator result is valid
    input  logic [`REG_WIDTH-1:0] max,        // accelerator result value
    output logic [`SYMBOL_BITS-1:0]   S_data,
    output logic [`SYMBOL_BITS-1:0]   T_data,
    output logic                  valid_s,
    output logic                  valid_t
);

    logic [$clog2(`N)-1:0] b_cnt1;   // S chunk counter 
    logic [$clog2(`M)-1:0] b_cnt2;   // T chunk counter
    logic [`S_LEN-1:0]     acc_s;    // S shift register
    logic [`T_LEN-1:0]     acc_T;    // T shift register
    logic [`REG_WIDTH-1:0] acc_max;  // latch  accelerator result

    typedef enum logic [2:0] {START, GET_S, SEND_S, GET_T, SEND_T} st_t;
    st_t state;

    
    assign S_data     = acc_s[`SYMBOL_BITS-1 -: `SYMBOL_BITS];   // low chunk first (LSB-first)
    assign T_data     = acc_T[`SYMBOL_BITS-1 -: `SYMBOL_BITS];
    assign valid_s    = (state == SEND_S);
    assign valid_t    = (state == SEND_T);
    assign Result_din = acc_max;

    always_ff @(posedge clk) begin
        if (!rstn) begin
            b_cnt1 <= '0; b_cnt2 <= '0;
            acc_s  <= '0; acc_T  <= '0;
            S_re   <= 1'b0; T_re <= 1'b0;
            state  <= START;
        end else begin
            S_re <= 1'b0;                          
            T_re <= 1'b0;
            case (state)
                START: if (ready_s || ready_t) begin
                    b_cnt1 <= '0; b_cnt2 <= '0;
                    state  <= GET_S;
                end

                GET_S: if (!empty_s && ready_s) begin
                    acc_s  <= S_dout;             
                    S_re   <= 1'b1;               
                    b_cnt1 <= '0;
                    state  <= SEND_S;
                end else if((ready_t && !empty_t) && empty_s) begin
                        state <= GET_T;  // if empty, skip to SEND_S (send zeros)     
                end

                SEND_S: if (ready_s) begin           
                    if (b_cnt1 == (`N-1)) begin    
                        state <= GET_T;
                    end else begin
                        acc_s  <= acc_s >> `SYMBOL_BITS;  // shift out the low chunk
                        b_cnt1 <= b_cnt1 + 1'b1;
                    end
                end

                GET_T: if (!empty_t && ready_t) begin
                    acc_T  <= T_dout;
                    T_re   <= 1'b1;
                    b_cnt2 <= '0;
                    state  <= SEND_T;
                end

                SEND_T: if (ready_t) begin
                    if (b_cnt2 == (`M-1)) begin
                        state <= START;
                    end else begin
                        acc_T  <= acc_T >> `SYMBOL_BITS;
                        b_cnt2 <= b_cnt2 + 1'b1;
                    end
                end

                default: state <= START;
            endcase
        end
    end

    // result path 
    always_ff @(posedge clk) begin
        if (!rstn) begin
            Result_we <= 1'b0;
            acc_max   <= '0;
        end else if (valid && !full_re) begin
            acc_max   <= max;                     
            Result_we <= 1'b1;                   
        end else begin
            Result_we <= 1'b0;
        end
    end

endmodule

//  byte_router
//  bits [7:6] = dir(00 = S, 01 = T)
//  bits [5:0] = 6 payload bits

module byte_router (
    input  logic       byte_valid,
    input  logic [7:0] byte_in,
    output logic       take_s,
    output logic       take_t,
    output logic [5:0] data_bits
);
    wire [1:0] dir = byte_in[7:6];
    assign take_s    = byte_valid & (dir == 2'b00);
    assign take_t    = byte_valid & (dir == 2'b01);
    assign data_bits = byte_in[5:0];
endmodule

//  assembler
//      accumulates 6-bit payloads into a 192-bit (S) or 96-bit (T) word, and pushed to FIFO
//      signla is marked by take
module assembler #(
    parameter int WORD_BITS = 192,        // 192 (S)/96 (T)
    parameter int DATA_BITS = 6           
)(
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 take,     
    input  logic [DATA_BITS-1:0] data_bits,
    output logic                 fifo_wen, 
    output logic [WORD_BITS-1:0] fifo_data
);
    localparam int NUM_CHUNKS = WORD_BITS / DATA_BITS;   // 32 (S), 16 (T)
    localparam int CNT_W      = $clog2(NUM_CHUNKS);

    logic [CNT_W-1:0]     chunk_count;
    logic [WORD_BITS-1:0] shift_reg;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            chunk_count <= '0;
            shift_reg   <= '0;
            fifo_wen    <= 1'b0;
            fifo_data   <= '0;
        end else begin
            fifo_wen <= 1'b0;                          // default: no push

            if (take) begin
                // shift the new payload into the low bits (first chunk -> MSB)
                shift_reg <= {shift_reg[WORD_BITS-DATA_BITS-1:0], data_bits};

                if (chunk_count == NUM_CHUNKS-1) begin // this payload completes a word
                    fifo_wen    <= 1'b1;
                    fifo_data   <= {shift_reg[WORD_BITS-DATA_BITS-1:0], data_bits};
                    chunk_count <= '0;
                end else begin
                    chunk_count <= chunk_count + 1'b1;
                end
            end
        end
    end
endmodule

//  result_sender

module result_sender (
    input  logic [`REG_WIDTH-1:0] data_in,           // result FIFO head byte
    input  logic                   empty,
    output logic                   r_en,              // 1-cycle pop

    input  logic       tx_ready,          // TX can accept a byte
    output logic [`REG_WIDTH-1:0] tx_data,
    output logic       tx_valid
);
    assign tx_data  = data_in;
    assign tx_valid = ~empty;
    assign r_en     = tx_valid & tx_ready;   // pop when the byte is taken
endmodule

//  UART RX  ->  byte_router  ->  assembler (S / T)  ->  S / T FIFOs  -> wrapper
//  wrapper  ->  result FIFO  ->  result_sender  ->  UART TX

module uart_assembler #(
    parameter  int N           = 64,              // S length in symbols
    parameter  int M           = 32,              // T length in symbols
    parameter  int SYMBOL_BITS = 3,               // bits per symbol
    parameter  int FIFO_DEPTH  = 5,
    localparam int DATA_BITS   = 6,               // payload bits/byte (fixed by framing)
    localparam int S_LEN       = N * SYMBOL_BITS, // 192
    localparam int T_LEN       = M * SYMBOL_BITS  //  96
)(
    //  board pins
    input  logic             clk,        
    input  logic             rst_n,      
    input  logic             uart_rxd,   
    output logic             uart_txd,   

    //S FIFO (read to wrapper)
    output logic [S_LEN-1:0] S_dout,
    output logic             empty_s,
    input  logic             S_re,
    // T FIFO (read to wrapper)
    output logic [T_LEN-1:0] T_dout,
    output logic             empty_t,
    input  logic             T_re,
    //result FIFO (write side from wrapper)
    input  logic [`REG_WIDTH-1:0] Result_din,
    input  logic             Result_we,
    output logic             full_re
);

    localparam UART_DATA_WIDTH = 8;
    // ---------------- UART RX ----------------
    logic [UART_DATA_WIDTH-1:0] rx_bus_data;
    logic rx_bus_valid, rx_bus_ready, rx_bus_sig;

    assign rx_bus_sig = uart_rxd;
    assign rx_bus_ready = 1'b1;                       // always accept a byte

    uart_rx #(.DATA_WIDTH(UART_DATA_WIDTH), .BAUD_RATE(115200), .CLK_FREQ(100_000_000))
        u_rx (.clk(clk), .rstn(rst_n), 
            .rx_bus_sig(rx_bus_sig),
            .rx_bus_data(rx_bus_data),
            .rx_bus_valid(rx_bus_valid),
            .rx_bus_ready(rx_bus_ready));

    wire       byte_valid = rx_bus_valid & rx_bus_ready;
    wire [7:0] byte_in    = rx_bus_data;

    // ---------------- router + assemblers ----------------
    wire       take_s, take_t;
    wire [5:0] data_bits;
    byte_router u_router (.byte_valid, .byte_in, .take_s, .take_t, .data_bits);

    wire             s_wen, t_wen, s_full, t_full;
    wire [S_LEN-1:0] s_wdata;
    wire [T_LEN-1:0] t_wdata;

    assembler #(.WORD_BITS(S_LEN), .DATA_BITS(DATA_BITS)) u_asm_s (
        .clk, .rst_n, .take(take_s), .data_bits,
        .fifo_wen(s_wen), .fifo_data(s_wdata));

    assembler #(.WORD_BITS(T_LEN), .DATA_BITS(DATA_BITS)) u_asm_t (
        .clk, .rst_n, .take(take_t), .data_bits,
        .fifo_wen(t_wen), .fifo_data(t_wdata));

    // ---------------- S / T FIFOs ----------------
    synchronous_fifo #(.DEPTH(FIFO_DEPTH), .DATA_WIDTH(S_LEN)) fifo_s (
        .clk, .rst_n,
        .w_en(s_wen & ~s_full), .data_in(s_wdata), .full(s_full),
        .r_en(S_re),            .data_out(S_dout),  .empty(empty_s));

    synchronous_fifo #(.DEPTH(FIFO_DEPTH), .DATA_WIDTH(T_LEN)) fifo_t (
        .clk, .rst_n,
        .w_en(t_wen & ~t_full), .data_in(t_wdata), .full(t_full),
        .r_en(T_re),            .data_out(T_dout),  .empty(empty_t));

    // ---------------- result FIFO -> sender -> UART TX ----------------
    wire [`REG_WIDTH-1:0] res_data;
    wire       res_empty, res_ren;

    synchronous_fifo #(.DEPTH(FIFO_DEPTH), .DATA_WIDTH(`REG_WIDTH)) fifo_result (
        .clk, .rst_n,
        .w_en(Result_we & ~full_re), .data_in(Result_din), .full(full_re),
        .r_en(res_ren),              .data_out(res_data),   .empty(res_empty));

    // TX bundle: medalotte tx modport -> we drive data/valid, read ready, sig->pin
    logic tx_bus_ready, tx_bus_valid, tx_bus_sig;
    logic [UART_DATA_WIDTH-1:0] tx_bus_data;

    assign uart_txd = tx_bus_sig;

    result_sender u_sender (
        .data_in (res_data),     .empty(res_empty),    .r_en(res_ren),
        .tx_ready(tx_bus_ready), .tx_data(tx_bus_data), .tx_valid(tx_bus_valid));

    uart_tx #(.DATA_WIDTH(UART_DATA_WIDTH), .BAUD_RATE(115200), .CLK_FREQ(100_000_000))
        u_tx (.clk(clk), .rstn(rst_n),
            .tx_bus_data(tx_bus_data), 
            .tx_bus_valid(tx_bus_valid),
            .tx_bus_ready(tx_bus_ready), 
            .tx_bus_sig(tx_bus_sig)
        );

endmodule
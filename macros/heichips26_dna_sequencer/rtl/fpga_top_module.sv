`include "macros.svh"

//  top_module
//      fully self-contained: wires genome_top (UART <-> S/T/result FIFOs) to
//      wrapper (FIFOs <-> accelerator streaming protocol) to the real
//      accelerator (systolic_array). Only board pins are exposed - there is
//      no open accelerator interface at this level anymore.
//
//  UART RX -> byte_router -> assembler (S/T) -> S/T FIFOs -> wrapper -> systolic_array
//  systolic_array -> wrapper -> result FIFO -> result_sender -> UART TX

module fpga_top_module (
    // board pins
    input  logic clk,
    input  logic rst,
    input  logic uart_rxd,
    output logic uart_txd
//    output logic [3:0] LED
);

    logic rst_n;
    assign rst_n = ~rst;
//    assign LED = {'0, rst_n};

    // S FIFO (genome_top <-> wrapper)
    logic [`S_LEN-1:0] S_dout;
    logic              empty_s;
    logic              S_re;

    // T FIFO (genome_top <-> wrapper)
    logic [`T_LEN-1:0] T_dout;
    logic              empty_t;
    logic              T_re;

    // result FIFO (wrapper <-> genome_top)
    logic [`REG_WIDTH-1:0] Result_din;
    logic                  Result_we;
    logic                  full_re;

    // accelerator interface (wrapper <-> systolic_array)
    logic                        ready_s, ready_t;
    logic                        accel_valid;
    logic signed [`REG_WIDTH-1:0] accel_max;
    logic [`SYMBOL_BITS-1:0]         S_data;
    logic [`SYMBOL_BITS-1:0]         T_data;
    logic                        valid_s, valid_t;

    uart_assembler #(
        .N          (`N),
        .M          (`M),
        .SYMBOL_BITS(`SYMBOL_BITS)
    ) u_uart_assembler (
        .clk       (clk),
        .rst_n     (rst_n),
        .uart_rxd  (uart_rxd),
        .uart_txd  (uart_txd),

        .S_dout    (S_dout),
        .empty_s   (empty_s),
        .S_re      (S_re),

        .T_dout    (T_dout),
        .empty_t   (empty_t),
        .T_re      (T_re),

        .Result_din(Result_din[`REG_WIDTH-1:0]),
        .Result_we (Result_we),
        .full_re   (full_re)
    );

    accelerator_driver u_accelerator_driver (
        .clk       (clk),
        .rstn      (rst_n),

        .S_dout    (S_dout),
        .empty_s   (empty_s),
        .S_re      (S_re),

        .T_dout    (T_dout),
        .empty_t   (empty_t),
        .T_re      (T_re),

        .full_re   (full_re),
        .Result_din(Result_din),
        .Result_we (Result_we),

        .ready_s   (ready_s),
        .ready_t   (ready_t),
        .valid     (accel_valid),
        .max       (accel_max),
        .S_data    (S_data),
        .T_data    (T_data),
        .valid_s   (valid_s),
        .valid_t   (valid_t)
    );

    systolic_array u_accelerator (
        .clk       (clk),
        .rstn      (rst_n),

        .s_in      (S_data),
        .t_in      (T_data),
        .s_in_valid(valid_s),
        .t_in_valid(valid_t),

        .s_in_ready(ready_s),
        .t_in_ready(ready_t),
        .max_valid (accel_valid),
        .max_out   (accel_max)
    );



endmodule

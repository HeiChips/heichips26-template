`ifndef MACROS_SVH
`define MACROS_SVH

`define N 14 // Length of S (= # of PEs)
`define M 10 // Length of T

`define MATCH 2
`define MISMATCH -1

`define MAX_SCORE (`N * `MATCH)
`define REG_WIDTH ($clog2(`MAX_SCORE + 1) + 1)
`define SYMBOL_BITS 3
`define S_LEN (`N * `SYMBOL_BITS)
`define T_LEN (`M * `SYMBOL_BITS)

parameter signed [`REG_WIDTH-1:0] ALPHA = 2; // Gap open penalty
parameter signed [`REG_WIDTH-1:0] BETA  = 1; // Gap extension penalty

`define BASE_IDLE  3'b000
`define BASE_CLEAR 3'b001
`define BASE_A     3'b100
`define BASE_C     3'b101
`define BASE_G     3'b110
`define BASE_T     3'b111

`endif

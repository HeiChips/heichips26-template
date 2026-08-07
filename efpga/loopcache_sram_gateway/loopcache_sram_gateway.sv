// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

// Protocol engine placed in the central FABulous eFPGA. It terminates the
// LoopCache-RV 16-bit packet link and drives the shared 1024 x 32-bit SRAM.
module loopcache_sram_gateway_core (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        cache_enable_i,
    input  wire        cache_flush_i,

    input  wire [15:0] project_uo_out_i,
    input  wire [15:0] project_uio_out_i,
    output logic [15:0] project_ui_in_o,
    output logic [15:0] project_uio_in_o,

    output logic [ 9:0] sram_addr_o,
    output logic [31:0] sram_bm_o,
    output logic [31:0] sram_din_o,
    output logic        sram_wen_o,
    output logic        sram_men_o,
    output logic        sram_ren_o,
    input  wire [31:0] sram_dout_i
);

    typedef enum logic [2:0] {
        WAIT_HEADER,
        RECEIVE_WRITE_LOW,
        RECEIVE_WRITE_HIGH,
        SEND_READ_LOW,
        SEND_READ_HIGH
    } state_t;

    state_t state_q;
    logic [ 9:0] address_q;
    logic [ 3:0] write_strobes_q;
    logic [15:0] write_low_q;

    wire request_valid = project_uio_out_i[0];
    wire response_ready = project_uio_out_i[1];
    wire request_ready = (state_q == WAIT_HEADER) ||
                         (state_q == RECEIVE_WRITE_LOW) ||
                         (state_q == RECEIVE_WRITE_HIGH);
    wire request_fire = request_valid && request_ready;

    always_comb begin
        project_ui_in_o  = 16'b0;
        project_uio_in_o = 16'b0;
        project_uio_in_o[0] = request_ready;
        project_uio_in_o[1] = (state_q == SEND_READ_LOW) ||
                              (state_q == SEND_READ_HIGH);
        project_uio_in_o[2] = cache_enable_i;
        project_uio_in_o[3] = cache_flush_i;

        if (state_q == SEND_READ_LOW)
            project_ui_in_o = sram_dout_i[15:0];
        else if (state_q == SEND_READ_HIGH)
            project_ui_in_o = sram_dout_i[31:16];

        sram_addr_o = address_q;
        if (state_q == WAIT_HEADER)
            sram_addr_o = project_uo_out_i[13:4];

        sram_bm_o = {{8{write_strobes_q[3]}},
                     {8{write_strobes_q[2]}},
                     {8{write_strobes_q[1]}},
                     {8{write_strobes_q[0]}}};
        sram_din_o = {project_uo_out_i, write_low_q};
        sram_wen_o = (state_q == RECEIVE_WRITE_HIGH) && request_fire;
        sram_ren_o = (state_q == WAIT_HEADER) && request_fire &&
                     !project_uo_out_i[15];
        sram_men_o = sram_wen_o || sram_ren_o;
    end

    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state_q         <= WAIT_HEADER;
            address_q       <= 10'b0;
            write_strobes_q <= 4'b0;
            write_low_q     <= 16'b0;
        end else begin
            case (state_q)
                WAIT_HEADER: begin
                    if (request_fire) begin
                        address_q       <= project_uo_out_i[13:4];
                        write_strobes_q <= project_uo_out_i[3:0];
                        if (project_uo_out_i[15])
                            state_q <= RECEIVE_WRITE_LOW;
                        else
                            state_q <= SEND_READ_LOW;
                    end
                end

                RECEIVE_WRITE_LOW: begin
                    if (request_fire) begin
                        write_low_q <= project_uo_out_i;
                        state_q     <= RECEIVE_WRITE_HIGH;
                    end
                end

                RECEIVE_WRITE_HIGH: begin
                    if (request_fire)
                        state_q <= WAIT_HEADER;
                end

                SEND_READ_LOW: begin
                    if (response_ready)
                        state_q <= SEND_READ_HIGH;
                end

                SEND_READ_HIGH: begin
                    if (response_ready)
                        state_q <= WAIT_HEADER;
                end

                default: state_q <= WAIT_HEADER;
            endcase
        end
    end

endmodule

`ifndef LOOPCACHE_GATEWAY_CORE_ONLY

// Bitstream top-level for the HeiChips26 classic FABulous fabric. This wrapper
// uses the official Large-project and 1024x32 SRAM primitives.
module loopcache_sram_gateway (
    input wire clk1,
    input wire rst
);

    wire fabric_clk;
    GBUF clock_buffer_i (
        .IN (clk1),
        .OUT(fabric_clk)
    );

    wire [15:0] project_ui_in;
    wire [15:0] project_uo_out;
    wire [15:0] project_uio_in;
    wire [15:0] project_uio_out;
    wire [15:0] project_uio_oe;

    wire [ 9:0] sram_addr;
    wire [31:0] sram_bm;
    wire [31:0] sram_din;
    wire [31:0] sram_dout;
    wire        sram_wen;
    wire        sram_men;
    wire        sram_ren;

    loopcache_sram_gateway_core gateway_i (
        .clk_i              (fabric_clk),
        .rst_i              (rst),
        .cache_enable_i     (1'b1),
        .cache_flush_i      (rst),
        .project_uo_out_i   (project_uo_out),
        .project_uio_out_i  (project_uio_out),
        .project_ui_in_o    (project_ui_in),
        .project_uio_in_o   (project_uio_in),
        .sram_addr_o        (sram_addr),
        .sram_bm_o          (sram_bm),
        .sram_din_o         (sram_din),
        .sram_wen_o         (sram_wen),
        .sram_men_o         (sram_men),
        .sram_ren_o         (sram_ren),
        .sram_dout_i        (sram_dout)
    );

`define TT_PROJECT_BIT(N) \
        .UI_IN``N(project_ui_in[N]), \
        .UO_OUT``N(project_uo_out[N]), \
        .UIO_IN``N(project_uio_in[N]), \
        .UIO_OUT``N(project_uio_out[N]), \
        .UIO_OE``N(project_uio_oe[N])

    TT_PROJECT_LARGE #(
        .ENABLE_POWER(1)
    ) project_i (
        `TT_PROJECT_BIT(0),
        `TT_PROJECT_BIT(1),
        `TT_PROJECT_BIT(2),
        `TT_PROJECT_BIT(3),
        `TT_PROJECT_BIT(4),
        `TT_PROJECT_BIT(5),
        `TT_PROJECT_BIT(6),
        `TT_PROJECT_BIT(7),
        `TT_PROJECT_BIT(8),
        `TT_PROJECT_BIT(9),
        `TT_PROJECT_BIT(10),
        `TT_PROJECT_BIT(11),
        `TT_PROJECT_BIT(12),
        `TT_PROJECT_BIT(13),
        `TT_PROJECT_BIT(14),
        `TT_PROJECT_BIT(15),
        .ENA  (1'b1),
        .CLK  (fabric_clk),
        .RST_N(!rst)
    );

`undef TT_PROJECT_BIT

`define SRAM_ADDR_BIT(N) .ADDR``N(sram_addr[N])
`define SRAM_DATA_BIT(N) \
        .DIN``N(sram_din[N]), .BM``N(sram_bm[N]), .DOUT``N(sram_dout[N])

    IHP_SRAM_1024x32_1RW sram_i (
        .CLK(fabric_clk),
        `SRAM_ADDR_BIT(0),
        `SRAM_ADDR_BIT(1),
        `SRAM_ADDR_BIT(2),
        `SRAM_ADDR_BIT(3),
        `SRAM_ADDR_BIT(4),
        `SRAM_ADDR_BIT(5),
        `SRAM_ADDR_BIT(6),
        `SRAM_ADDR_BIT(7),
        `SRAM_ADDR_BIT(8),
        `SRAM_ADDR_BIT(9),
        `SRAM_DATA_BIT(0),
        `SRAM_DATA_BIT(1),
        `SRAM_DATA_BIT(2),
        `SRAM_DATA_BIT(3),
        `SRAM_DATA_BIT(4),
        `SRAM_DATA_BIT(5),
        `SRAM_DATA_BIT(6),
        `SRAM_DATA_BIT(7),
        `SRAM_DATA_BIT(8),
        `SRAM_DATA_BIT(9),
        `SRAM_DATA_BIT(10),
        `SRAM_DATA_BIT(11),
        `SRAM_DATA_BIT(12),
        `SRAM_DATA_BIT(13),
        `SRAM_DATA_BIT(14),
        `SRAM_DATA_BIT(15),
        `SRAM_DATA_BIT(16),
        `SRAM_DATA_BIT(17),
        `SRAM_DATA_BIT(18),
        `SRAM_DATA_BIT(19),
        `SRAM_DATA_BIT(20),
        `SRAM_DATA_BIT(21),
        `SRAM_DATA_BIT(22),
        `SRAM_DATA_BIT(23),
        `SRAM_DATA_BIT(24),
        `SRAM_DATA_BIT(25),
        `SRAM_DATA_BIT(26),
        `SRAM_DATA_BIT(27),
        `SRAM_DATA_BIT(28),
        `SRAM_DATA_BIT(29),
        `SRAM_DATA_BIT(30),
        `SRAM_DATA_BIT(31),
        .WEN(sram_wen),
        .MEN(sram_men),
        .REN(sram_ren)
    );

`undef SRAM_ADDR_BIT
`undef SRAM_DATA_BIT

    wire _unused = &project_uio_oe;

endmodule

`endif

`default_nettype wire

`default_nettype wire

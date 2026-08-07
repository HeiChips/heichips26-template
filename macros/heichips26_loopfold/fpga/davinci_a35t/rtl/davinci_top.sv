// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

module davinci_top (
    input  wire       sys_clk,
    input  wire       sys_rst_n,
    input  wire       uart_rxd,
    output wire       uart_txd,
    input  wire [3:0] key,
    output wire [3:0] led
);

    logic [2:0] rst_sync_q;
    always_ff @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            rst_sync_q <= 3'b000;
        else
            rst_sync_q <= {rst_sync_q[1:0], 1'b1};
    end

    wire rst_ni = rst_sync_q[2];

    wire [15:0] link_tx_data;
    wire        link_tx_valid;
    wire        link_tx_ready;
    wire [15:0] link_rx_data;
    wire        link_rx_valid;
    wire        link_rx_ready;
    wire        trap;
    wire [31:0] cycle_count;
    wire [31:0] external_ifetch_count;
    wire [31:0] loop_hit_count;
    wire [31:0] stall_count;

    wire cache_enable = key[1];
    wire cache_flush  = ~key[0];

    loopcache_soc soc_i (
        .clk_i                  (sys_clk),
        .rst_ni                 (rst_ni),
        .cache_enable_i         (cache_enable),
        .cache_flush_i          (cache_flush),
        .link_tx_data_o         (link_tx_data),
        .link_tx_valid_o        (link_tx_valid),
        .link_tx_ready_i        (link_tx_ready),
        .link_rx_data_i         (link_rx_data),
        .link_rx_valid_i        (link_rx_valid),
        .link_rx_ready_o        (link_rx_ready),
        .trap_o                 (trap),
        .cycle_count_o          (cycle_count),
        .external_ifetch_count_o(external_ifetch_count),
        .loop_hit_count_o       (loop_hit_count),
        .stall_count_o          (stall_count)
    );

    link_bram_backend bram_i (
        .clk_i          (sys_clk),
        .rst_ni         (rst_ni),
        .link_tx_data_i (link_tx_data),
        .link_tx_valid_i(link_tx_valid),
        .link_tx_ready_o(link_tx_ready),
        .link_rx_data_o (link_rx_data),
        .link_rx_valid_o(link_rx_valid),
        .link_rx_ready_i(link_rx_ready)
    );

    logic trap_q;
    always_ff @(posedge sys_clk or negedge rst_ni) begin
        if (!rst_ni)
            trap_q <= 1'b0;
        else
            trap_q <= trap;
    end

    wire report_start = trap && !trap_q;
    wire reporter_busy;

    uart_reporter reporter_i (
        .clk_i                  (sys_clk),
        .rst_ni                 (rst_ni),
        .start_i                (report_start),
        .cycle_count_i          (cycle_count),
        .external_ifetch_count_i(external_ifetch_count),
        .loop_hit_count_i       (loop_hit_count),
        .stall_count_i          (stall_count),
        .uart_tx_o              (uart_txd),
        .busy_o                 (reporter_busy)
    );

    assign led[0] = rst_ni;
    assign led[1] = trap;
    assign led[2] = reporter_busy;
    assign led[3] = |loop_hit_count[15:0];

    wire _unused = &{uart_rxd, key[3:2], cycle_count[31],
                     external_ifetch_count[31], stall_count[31]};

endmodule

`default_nettype wire

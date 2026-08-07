// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

// HeiChips26 Large-slot wrapper.
//
// Memory-link pin assignment:
//   uo_out[15:0]  request header/data from the ASIC to the eFPGA
//   ui_in[15:0]   read-response data from the eFPGA to the ASIC
//   uio_in[0]     request ready
//   uio_out[0]    request valid
//   uio_in[1]     read-response valid
//   uio_out[1]    read-response ready
//   uio_in[2]     loop buffer enable
//   uio_in[3]     synchronous loop buffer flush
//   uio_in[4]     sequential prefetch enable
//   uio_out[2]    PicoRV32 trap
//   uio_out[3]    loop buffer enabled
//   uio_out[15:4] low twelve bits of the hit counter
module heichips26_loopcache_rv (
`ifdef USE_POWER_PINS
    inout  wire        VPWR,
    inout  wire        VGND,
`endif
    input  wire [15:0] ui_in,
    output wire [15:0] uo_out,
    input  wire [15:0] uio_in,
    output wire [15:0] uio_out,
    output wire [15:0] uio_oe,
    input  wire        ena,
    input  wire        clk,
    input  wire        rst_n
);

    wire        request_valid;
    wire        response_ready;
    wire        trap;
    wire [31:0] cycle_count;
    wire [31:0] external_ifetch_count;
    wire [31:0] loop_hit_count;
    wire [31:0] stall_count;

    loopcache_soc soc_i (
        .clk_i                  (clk),
        .rst_ni                 (rst_n),
        .cache_enable_i         (uio_in[2]),
        .cache_flush_i          (uio_in[3]),
        .prefetch_enable_i      (uio_in[4]),

        .link_tx_data_o         (uo_out),
        .link_tx_valid_o        (request_valid),
        .link_tx_ready_i        (uio_in[0]),
        .link_rx_data_i         (ui_in),
        .link_rx_valid_i        (uio_in[1]),
        .link_rx_ready_o        (response_ready),

        .trap_o                 (trap),
        .cycle_count_o          (cycle_count),
        .external_ifetch_count_o(external_ifetch_count),
        .loop_hit_count_o       (loop_hit_count),
        .stall_count_o          (stall_count)
    );

    assign uio_out[0]    = request_valid;
    assign uio_out[1]    = response_ready;
    assign uio_out[2]    = trap;
    assign uio_out[3]    = uio_in[2];
    assign uio_out[15:4] = loop_hit_count[11:0];
    assign uio_oe         = 16'hffff;

    // ena is asserted whenever the project is powered. Keep it in the design
    // so linting does not report an unused top-level input.
    wire _unused = &{ena, uio_in[15:5], cycle_count[31],
                     external_ifetch_count[31], stall_count[31]};

endmodule

`default_nettype wire

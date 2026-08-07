// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`timescale 1ns/1ps
`default_nettype none

module loopcache_sram_gateway_tb;

    logic        clk;
    logic        rst;
    logic        cache_enable;
    logic        cache_flush;
    logic [15:0] project_uo_out;
    logic [15:0] project_uio_out;
    wire  [15:0] project_ui_in;
    wire  [15:0] project_uio_in;
    wire  [ 9:0] sram_addr;
    wire  [31:0] sram_bm;
    wire  [31:0] sram_din;
    wire         sram_wen;
    wire         sram_men;
    wire         sram_ren;
    logic [31:0] sram_dout;

    loopcache_sram_gateway_core dut (
        .clk_i             (clk),
        .rst_i             (rst),
        .cache_enable_i    (cache_enable),
        .cache_flush_i     (cache_flush),
        .project_uo_out_i  (project_uo_out),
        .project_uio_out_i (project_uio_out),
        .project_ui_in_o   (project_ui_in),
        .project_uio_in_o  (project_uio_in),
        .sram_addr_o       (sram_addr),
        .sram_bm_o         (sram_bm),
        .sram_din_o        (sram_din),
        .sram_wen_o        (sram_wen),
        .sram_men_o        (sram_men),
        .sram_ren_o        (sram_ren),
        .sram_dout_i       (sram_dout)
    );

    always #5 clk = !clk;

    task automatic fail(input string message);
        begin
            $display("FAIL: %s", message);
            $fatal(1);
        end
    endtask

    task automatic send_word(input logic [15:0] word);
        begin
            @(negedge clk);
            project_uo_out    = word;
            project_uio_out[0] = 1'b1;
            #1;
            if (!project_uio_in[0])
                fail("request endpoint was not ready");
            @(posedge clk);
            @(negedge clk);
            project_uio_out[0] = 1'b0;
        end
    endtask

    initial begin
        clk             = 1'b0;
        rst             = 1'b1;
        cache_enable    = 1'b1;
        cache_flush     = 1'b0;
        project_uo_out  = 16'b0;
        project_uio_out = 16'b0;
        sram_dout       = 32'hdead_beef;

        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;
        #1;

        if (!project_uio_in[0])
            fail("gateway not ready after reset");
        if (!project_uio_in[2] || project_uio_in[3])
            fail("cache control pins are mapped incorrectly");

        // Read word 0x155. The header itself must pulse the synchronous SRAM
        // read controls, then the gateway returns low and high halfwords.
        project_uo_out     = {1'b0, 1'b1, 10'h155, 4'h0};
        project_uio_out[0] = 1'b1;
        #1;
        if (!sram_men || !sram_ren || sram_wen)
            fail("read header did not issue an SRAM read");
        if (sram_addr != 10'h155)
            fail("read address mismatch");
        @(posedge clk);
        @(negedge clk);
        project_uio_out[0] = 1'b0;
        #1;
        if (!project_uio_in[1] || project_ui_in != 16'hbeef)
            fail("read low halfword mismatch");

        project_uio_out[1] = 1'b1;
        @(posedge clk);
        #1;
        if (!project_uio_in[1] || project_ui_in != 16'hdead)
            fail("read high halfword mismatch");
        @(posedge clk);
        #1;
        if (project_uio_in[1])
            fail("read response valid stayed high too long");
        @(negedge clk);
        project_uio_out[1] = 1'b0;

        // Write word 0x89abcdef to address 0x2aa. Strobes 1010 select bytes
        // 3 and 1, which must become the bit mask 0xff00ff00.
        send_word({1'b1, 1'b0, 10'h2aa, 4'ha});
        send_word(16'hcdef);

        @(negedge clk);
        project_uo_out     = 16'h89ab;
        project_uio_out[0] = 1'b1;
        #1;
        if (!sram_men || !sram_wen || sram_ren)
            fail("write high beat did not issue an SRAM write");
        if (sram_addr != 10'h2aa)
            fail("write address mismatch");
        if (sram_din != 32'h89ab_cdef)
            fail("write data mismatch");
        if (sram_bm != 32'hff00_ff00)
            fail("write byte mask mismatch");
        @(posedge clk);
        @(negedge clk);
        project_uio_out[0] = 1'b0;
        #1;
        if (!project_uio_in[0])
            fail("gateway did not return to idle after write");

        cache_flush = 1'b1;
        #1;
        if (!project_uio_in[3])
            fail("cache flush pin is not forwarded");

        $display("PASS: LoopCache-RV eFPGA gateway read/write protocol");
        $finish;
    end

endmodule

`default_nettype wire

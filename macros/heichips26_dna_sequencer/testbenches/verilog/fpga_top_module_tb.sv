`timescale 1ns/1ps

`include "macros.svh"

// Testbench for top_module.
// Sends the S and T sequences from tv/vectors.hex into the UART and checks the
// score that comes back against tv/expected.txt. Regenerate the tv files with
// scripts/gen_vectors.py whenever N or M changes.

module top_module_tb;

    localparam CLK_PERIOD  = 10;
    localparam CYC_PER_BIT = 100_000_000 / 115200; // UART bit time in clocks

    // 6 payload bits per byte, the rest is the S/T tag
    localparam S_BYTES  = `S_LEN / 6;
    localparam T_BYTES  = `T_LEN / 6;
    localparam CASE_LEN = S_BYTES + T_BYTES;

    localparam MAX_CASES = 64;   // upper bound for the vector arrays
    localparam TIMEOUT   = 200_000;

    reg clk = 0;
    reg rst = 1;
    always #(CLK_PERIOD/2) clk = ~clk;

    reg  uart_rxd = 1;  // idles high
    wire uart_txd;

    top_module dut (
        .clk     (clk),
        .rst     (rst),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd)
    );

    reg [7:0] vectors  [0:MAX_CASES*CASE_LEN-1];
    integer   expected [0:MAX_CASES-1];
    integer   num_cases;

    task load_vectors;
        integer fd, i, r;
        begin
            fd = $fopen("tv/num_cases.txt", "r");
            if (fd == 0) begin
                $display("[top_module_tb] tv/num_cases.txt not found, run make gen-vectors");
                $finish;
            end
            r = $fscanf(fd, "%d", num_cases);
            $fclose(fd);

            if (num_cases > MAX_CASES) begin
                $display("[top_module_tb] only running the first %0d of %0d cases", MAX_CASES, num_cases);
                num_cases = MAX_CASES;
            end

            // bounded read, the arrays are sized for MAX_CASES
            $readmemh("tv/vectors.hex", vectors, 0, num_cases*CASE_LEN - 1);

            fd = $fopen("tv/expected.txt", "r");
            if (fd == 0) begin
                $display("[top_module_tb] tv/expected.txt not found");
                $finish;
            end
            for (i = 0; i < num_cases; i = i + 1)
                r = $fscanf(fd, "%d", expected[i]);
            $fclose(fd);
        end
    endtask

    // one UART byte, LSB first
    task send_byte(input [7:0] data);
        integer i;
        begin
            uart_rxd = 0;
            repeat (CYC_PER_BIT) @(posedge clk);
            for (i = 0; i < 8; i = i + 1) begin
                uart_rxd = data[i];
                repeat (CYC_PER_BIT) @(posedge clk);
            end
            uart_rxd = 1;
            repeat (CYC_PER_BIT) @(posedge clk);
        end
    endtask

    // catches every byte the DUT sends back, sampled in the middle of the bit
    reg [7:0] result;
    integer   result_count = 0;
    integer   b;

    initial begin
        forever begin
            @(negedge uart_txd);
            repeat (CYC_PER_BIT + CYC_PER_BIT/2) @(posedge clk);
            for (b = 0; b < 8; b = b + 1) begin
                result[b] = uart_txd;
                repeat (CYC_PER_BIT) @(posedge clk);
            end
            result_count = result_count + 1;
        end
    end

    integer c, i, waited;
    integer errors = 0;

    initial begin
`ifdef DUMP
        $dumpfile("top_module_tb.fst");
        $dumpvars(0, top_module_tb);
`endif
        load_vectors;
        $display("[top_module_tb] N=%0d M=%0d, %0d bytes per case, %0d case(s)",
                 `N, `M, CASE_LEN, num_cases);

        repeat (50) @(posedge clk);
        rst = 0;
        repeat (20) @(posedge clk);

        for (c = 0; c < num_cases; c = c + 1) begin
            for (i = 0; i < CASE_LEN; i = i + 1)
                send_byte(vectors[c*CASE_LEN + i]);

            waited = 0;
            while (result_count < c+1 && waited < TIMEOUT) begin
                @(posedge clk);
                waited = waited + 1;
            end

            if (result_count < c+1) begin
                $display("[top_module_tb] case %0d: TIMEOUT, no result byte", c);
                errors = errors + 1;
            end
            else if (result != expected[c]) begin
                $display("[top_module_tb] case %0d: FAIL, got %0d expected %0d",
                         c, result, expected[c]);
                errors = errors + 1;
            end
            else begin
                $display("[top_module_tb] case %0d: PASS, score %0d", c, result);
            end

            // next case starts without a reset in between
            repeat (100) @(posedge clk);
        end

        if (errors == 0) $display("[top_module_tb] all %0d cases passed", num_cases);
        else             $display("[top_module_tb] %0d of %0d cases failed", errors, num_cases);

        $finish;
    end

endmodule

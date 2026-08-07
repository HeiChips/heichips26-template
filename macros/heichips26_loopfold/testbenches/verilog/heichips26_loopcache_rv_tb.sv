// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`timescale 1ns/1ps

module heichips26_loopcache_rv_tb;

    logic        clk = 1'b0;
    logic        rst_n = 1'b0;
    logic        ena = 1'b1;
    logic [15:0] ui_in;
    wire  [15:0] uo_out;
    logic [15:0] uio_in;
    wire  [15:0] uio_out;
    wire  [15:0] uio_oe;

    logic [31:0] memory [0:1023];
    logic [1:0]  request_state;
    logic [9:0]  write_address;
    logic [3:0]  write_strobes;
    logic [15:0] write_low;
    logic [31:0] pending_read_data;
    logic [1:0]  pending_read_beats;
    integer      cycles;
    integer      byte_index;
    logic [31:0] merged_write;

    localparam REQ_HEADER = 2'd0;
    localparam REQ_WLOW   = 2'd1;
    localparam REQ_WHIGH  = 2'd2;

    always #5 clk = ~clk;

    always_comb begin
        uio_in = 16'b0;
        uio_in[0] = 1'b1;
        uio_in[1] = (pending_read_beats != 0);
        uio_in[2] = 1'b1;
        ui_in = pending_read_data[15:0];
    end

    heichips26_loopcache_rv dut (
        .ui_in  (ui_in),
        .uo_out (uo_out),
        .uio_in (uio_in),
        .uio_out(uio_out),
        .uio_oe (uio_oe),
        .ena    (ena),
        .clk    (clk),
        .rst_n  (rst_n)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            request_state     <= REQ_HEADER;
            write_address     <= 10'b0;
            write_strobes     <= 4'b0;
            write_low         <= 16'b0;
            pending_read_data <= 32'b0;
            pending_read_beats <= 2'b0;
        end else begin
            if (uio_out[0] && uio_in[0]) begin
                case (request_state)
                    REQ_HEADER: begin
                        if (uo_out[15]) begin
                            write_address <= uo_out[13:4];
                            write_strobes <= uo_out[3:0];
                            request_state <= REQ_WLOW;
                        end else begin
                            pending_read_data  <= memory[uo_out[13:4]];
                            pending_read_beats <= 2;
                        end
                    end
                    REQ_WLOW: begin
                        write_low     <= uo_out;
                        request_state <= REQ_WHIGH;
                    end
                    REQ_WHIGH: begin
                        merged_write = memory[write_address];
                        for (byte_index = 0; byte_index < 4; byte_index = byte_index + 1) begin
                            if (write_strobes[byte_index]) begin
                                if (byte_index < 2)
                                    merged_write[8*byte_index +: 8] =
                                        write_low[8*byte_index +: 8];
                                else
                                    merged_write[8*byte_index +: 8] =
                                        uo_out[8*(byte_index-2) +: 8];
                            end
                        end
                        memory[write_address] <= merged_write;
                        request_state <= REQ_HEADER;
                    end
                    default: request_state <= REQ_HEADER;
                endcase
            end

            if (uio_in[1] && uio_out[1]) begin
                pending_read_data  <= {16'b0, pending_read_data[31:16]};
                pending_read_beats <= pending_read_beats - 1'b1;
            end
        end
    end

    initial begin
        $dumpfile("heichips26_loopcache_rv_tb.fst");
        $dumpvars(0, heichips26_loopcache_rv_tb);
        for (cycles = 0; cycles < 1024; cycles = cycles + 1)
            memory[cycles] = 32'b0;
        $readmemh("../../../../firmware/loopcache_test.hex", memory);

        repeat (5) @(posedge clk);
        @(negedge clk);
        rst_n = 1'b1;

        cycles = 0;
        while (!uio_out[2] && cycles < 20000) begin
            @(posedge clk);
            cycles = cycles + 1;
        end

        if (!uio_out[2])
            $fatal(1, "CPU did not trap");
        if (memory[10'h0c0] !== 32'd20)
            $fatal(1, "wrong result: %0d", memory[10'h0c0]);
        if (memory[10'h0c3] == 0)
            $fatal(1, "loop buffer produced no hits");

        $display("PASS result=%0d cycles=%0d fetches=%0d hits=%0d stalls=%0d",
                 memory[10'h0c0], memory[10'h0c1], memory[10'h0c2],
                 memory[10'h0c3], memory[10'h0c4]);
        $finish;
    end

endmodule

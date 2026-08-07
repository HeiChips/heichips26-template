`include "macros.svh"

`timescale 1ns/10ps

module systolic_array_tb();

localparam CLK_PERIOD = 10;
localparam int test_count = 5; // number of sequences in the file
localparam int test_type = 2; // 1: 1 S seq, 2: different S seqs

logic clk, rstn;
logic [2:0] s_in, t_in;
logic s_in_valid, t_in_valid;
logic s_in_ready, t_in_ready;
logic max_valid;
logic signed [`REG_WIDTH-1:0] max_out;

logic [`N-1:0][2:0] s_array;
logic [`M-1:0][2:0] t_array;
int max_val;

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end

systolic_array dut(
    .clk(clk),
    .rstn(rstn),
    .s_in(s_in),
    .t_in(t_in),
    .s_in_valid(s_in_valid),
    .t_in_valid(t_in_valid),
    .s_in_ready(s_in_ready),
    .t_in_ready(t_in_ready),
    .max_valid(max_valid),
    .max_out(max_out)
);

int expected_max_val_queue[$];

initial begin
    int fd_s, fd_t, fd_max;
    string pwd;
    int trace;
    $value$plusargs("CWD=%s", pwd);
    $value$plusargs("trace=%s", trace);
    if(trace=="1") begin
        $dumpfile({pwd,"/output/dump.vcd"});
        $dumpvars ();
    end

    fd_s = $fopen({pwd,"/output/seq1.txt"}, "r");
    fd_t = $fopen({pwd,"/output/seq2.txt"}, "r");
    fd_max = $fopen({pwd,"/output/final_op.txt"}, "r");
    // fd_s = $fopen("/home/samare/Documents/heiChip/SW_DNA_allignment/scripts/output/seq1.txt", "r");
    // fd_t = $fopen("/home/samare/Documents/heiChip/SW_DNA_allignment/scripts/output/seq2.txt", "r");
    // fd_max = $fopen("/home/samare/Documents/heiChip/SW_DNA_allignment/scripts/output/final_op.txt", "r");

    if((fd_s == 0) || (fd_t == 0) || (fd_max == 0)) begin
        $error("some data files are missing");
    end

    reset_task();

    for(int i=0; i<test_count; i++) begin
        s_array = read_s_array_from_file(fd_s);
        t_array = read_t_array_from_file(fd_t);
        max_val = read_max_val_from_file(fd_max);

        expected_max_val_queue.push_back(max_val);

        if(!((test_type == 1) && (i > 0))) begin
            @(negedge clk);
            wait(s_in_ready);
            send_s_task(s_array);
        end
        @(negedge clk);
        wait(t_in_ready);
        send_t_task(t_array);

    end


end

// check results
initial begin
    int expected_max_val;
    int run_count = 0;

    forever begin
        @(negedge clk);

        if(max_valid) begin
            expected_max_val = expected_max_val_queue.pop_front();
            run_count ++;

            if(max_out == expected_max_val) begin
                $display("[INFO] Correct result %d", max_out);
            end
            else begin
                $display("[ERROR] Wrong result: %d, expected %d", max_out, expected_max_val);
            end

            if(run_count == test_count) begin
                $finish;
            end
        end
    end
end

task automatic reset_task();
    @(negedge clk);
    rstn = 1'b0;
    s_in = `BASE_IDLE;
    t_in = `BASE_IDLE;
    s_in_valid = 1'b0;
    t_in_valid = 1'b0;
    @(negedge clk);
    rstn = 1'b1;
endtask

task automatic send_s_task(input logic [`N-1:0][2:0]s_array);
    for(int i = `N-1; i >= 0; i--) begin
        @(negedge clk);
        s_in_valid = 1'b1;
        s_in = s_array[i];
        t_in = `BASE_IDLE;
    end
    @(negedge clk);
    s_in_valid = 1'b0;
endtask

task automatic send_t_task(input logic [`M-1:0][2:0] t_array);
    for(int i = 0; i < `M; i++) begin
        @(negedge clk);
        t_in_valid = 1'b1;
        s_in = `BASE_IDLE;
        t_in = t_array[i];
    end
    @(negedge clk);
    t_in_valid = 1'b0;
endtask

function automatic logic [`N-1:0][2:0] read_s_array_from_file(input int fd);

    int ret;
    logic [`N-1:0][2:0] s_array;
    byte ch;

    ret = $fscanf(fd, "%c", ch);   // reads '['

    for(int i=0; i< `N; i++) begin
        logic [2:0] tmp;
        ret = $fscanf(fd, "%b", tmp);
        s_array[i] = tmp;

        if(i !=`N-1) begin
            ret = $fscanf(fd, "%c", ch);   // reads ','
        end
    end

    ret = $fscanf(fd, "%c", ch);   // reads ']'

    return s_array;

endfunction

function automatic logic [`M-1:0][2:0] read_t_array_from_file(input int fd);

    int ret;
    logic [`M-1:0][2:0] t_array;
    byte ch;

    ret = $fscanf(fd, "%c", ch);   // reads '['

    for(int i=0; i< `M; i++) begin
        logic [2:0] tmp;
        ret = $fscanf(fd, "%b", tmp);
        t_array[i] = tmp;

        if(i !=`M-1) begin
            ret = $fscanf(fd, "%c", ch);   // reads ','
        end
    end

    ret = $fscanf(fd, "%c", ch);   // reads ']'

    return t_array;

endfunction

function automatic int read_max_val_from_file(input int fd);

    int max_val, ret;

    ret = $fscanf(fd, "%d", max_val);

    return max_val;

endfunction

// assert property (@(posedge clk) disable iff (!rstn) !(s_in_valid && t_in_valid)) else $error("Both S and T sequences can not be valid at once");

// assert property (@(posedge clk) disable iff (!rstn) max_valid |-> (max_out <= `MAX_SCORE)) else $error("Max_out exceeded possible maximum value");

// assert property (@(posedge clk) disable iff(!rstn) (s_in_valid && s_in_ready && !t_in_ready && !t_in_valid) |-> s_in_ready[*`N-1]) else $error("s_in ready is not dropped after valid s");

// assert property (@(posedge clk) disable iff(!rstn) (t_in_valid && t_in_ready && !s_in_ready && !s_in_valid) |-> !t_in_ready) else $error("t_in_ready is not dropped after valid t");

endmodule

module synchronous_fifo #(
    parameter DEPTH      = 5,
    parameter DATA_WIDTH = 192
) (
    input                        clk,
    input                        rst_n,
    input                        w_en,
    input                        r_en,
    input      [DATA_WIDTH-1:0]  data_in,
    output     [DATA_WIDTH-1:0]  data_out,   // now a wire (FWFT)
    output                       full,
    output                       empty
);
    localparam PTR_W = $clog2(DEPTH);        // pointer width
    localparam CNT_W = $clog2(DEPTH+1);      // count needs 0..DEPTH inclusive

    reg [DATA_WIDTH-1:0] FIFO [0:DEPTH-1];
    reg [PTR_W-1:0]      w_ptr, r_ptr;
    reg [CNT_W-1:0]      count;

    // count: +1 write-only, -1 read-only, unchanged on both/neither
    always @(posedge clk) begin
        if (!rst_n) count <= 'b0;
        else case ({r_en & ~empty, w_en & ~full})
            2'b01:        count <= count + 1'b1;   // write only
            2'b10:        count <= count - 1'b1;   // read only
            default:      count <= count;          // 00 or 11
        endcase
    end

    // write
    always @(posedge clk) begin
        if (!rst_n) w_ptr <= 'b0;
        else if (w_en & ~full) begin
            FIFO[w_ptr] <= data_in;
            w_ptr <= (w_ptr + 1 == DEPTH) ? 0 : w_ptr + 1;
        end
    end

    // read pointer only; data is presented combinationally (FWFT)
    always @(posedge clk) begin
        if (!rst_n) r_ptr <= 'b0;
        else if (r_en & ~empty)
            r_ptr <= (r_ptr + 1 == DEPTH) ? 0 : r_ptr + 1;
    end

    assign data_out = FIFO[r_ptr];
    assign full     = (count == DEPTH);
    assign empty    = (count == 0);

endmodule
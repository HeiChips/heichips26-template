// SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

`default_nettype none

module uart_reporter (
    input  wire        clk_i,
    input  wire        rst_ni,
    input  wire        start_i,
    input  wire [31:0] cycle_count_i,
    input  wire [31:0] external_ifetch_count_i,
    input  wire [31:0] loop_hit_count_i,
    input  wire [31:0] stall_count_i,
    output wire        uart_tx_o,
    output wire        busy_o
);

    typedef enum logic [3:0] {
        IDLE,
        SEND_BANNER,
        SEND_CYCLES_LABEL,
        SEND_CYCLES_HEX,
        SEND_FETCHES_LABEL,
        SEND_FETCHES_HEX,
        SEND_HITS_LABEL,
        SEND_HITS_HEX,
        SEND_STALLS_LABEL,
        SEND_STALLS_HEX,
        SEND_DONE_EOL,
        DONE
    } state_t;

    state_t state_q;
    logic [5:0] index_q;
    logic [31:0] cycles_q;
    logic [31:0] fetches_q;
    logic [31:0] hits_q;
    logic [31:0] stalls_q;
    logic [7:0] tx_data;
    logic       tx_valid;
    wire        tx_ready;
    wire        tx_busy;
    logic [31:0] hex_value;
    logic [4:0]  hex_msb;
    logic [5:0]  label_last_index;

    assign busy_o = (state_q != IDLE) || tx_busy;

    uart_tx uart_tx_i (
        .clk_i  (clk_i),
        .rst_ni (rst_ni),
        .data_i (tx_data),
        .valid_i(tx_valid),
        .ready_o(tx_ready),
        .tx_o   (uart_tx_o),
        .busy_o (tx_busy)
    );

    function automatic [7:0] hex_char(input logic [3:0] value);
        begin
            hex_char = (value < 4'd10) ? (8'h30 + {4'b0, value})
                                       : (8'h41 + {4'b0, value - 4'd10});
        end
    endfunction

    function automatic [7:0] banner_char(input logic [5:0] index);
        begin
            case (index)
                6'd0:  banner_char = 8'h0d;
                6'd1:  banner_char = 8'h0a;
                6'd2:  banner_char = "L";
                6'd3:  banner_char = "o";
                6'd4:  banner_char = "o";
                6'd5:  banner_char = "p";
                6'd6:  banner_char = "C";
                6'd7:  banner_char = "a";
                6'd8:  banner_char = "c";
                6'd9:  banner_char = "h";
                6'd10: banner_char = "e";
                6'd11: banner_char = "-";
                6'd12: banner_char = "R";
                6'd13: banner_char = "V";
                6'd14: banner_char = " ";
                6'd15: banner_char = "F";
                6'd16: banner_char = "P";
                6'd17: banner_char = "G";
                6'd18: banner_char = "A";
                6'd19: banner_char = " ";
                6'd20: banner_char = "d";
                6'd21: banner_char = "e";
                6'd22: banner_char = "m";
                6'd23: banner_char = "o";
                6'd24: banner_char = 8'h0d;
                default: banner_char = 8'h0a;
            endcase
        end
    endfunction

    function automatic [7:0] label_char(
        input logic [1:0] label,
        input logic [5:0] index
    );
        begin
            label_char = " ";
            unique case (label)
                2'd0: begin
                    case (index)
                        6'd0: label_char = "c";
                        6'd1: label_char = "y";
                        6'd2: label_char = "c";
                        6'd3: label_char = "l";
                        6'd4: label_char = "e";
                        6'd5: label_char = "s";
                        6'd6: label_char = "=";
                        6'd7: label_char = "0";
                        default: label_char = "x";
                    endcase
                end
                2'd1: begin
                    case (index)
                        6'd0: label_char = 8'h0d;
                        6'd1: label_char = 8'h0a;
                        6'd2: label_char = "f";
                        6'd3: label_char = "e";
                        6'd4: label_char = "t";
                        6'd5: label_char = "c";
                        6'd6: label_char = "h";
                        6'd7: label_char = "e";
                        6'd8: label_char = "s";
                        6'd9: label_char = "=";
                        6'd10: label_char = "0";
                        default: label_char = "x";
                    endcase
                end
                2'd2: begin
                    case (index)
                        6'd0: label_char = 8'h0d;
                        6'd1: label_char = 8'h0a;
                        6'd2: label_char = "h";
                        6'd3: label_char = "i";
                        6'd4: label_char = "t";
                        6'd5: label_char = "s";
                        6'd6: label_char = "=";
                        6'd7: label_char = "0";
                        default: label_char = "x";
                    endcase
                end
                default: begin
                    case (index)
                        6'd0: label_char = 8'h0d;
                        6'd1: label_char = 8'h0a;
                        6'd2: label_char = "s";
                        6'd3: label_char = "t";
                        6'd4: label_char = "a";
                        6'd5: label_char = "l";
                        6'd6: label_char = "l";
                        6'd7: label_char = "s";
                        6'd8: label_char = "=";
                        6'd9: label_char = "0";
                        default: label_char = "x";
                    endcase
                end
            endcase
        end
    endfunction

    function automatic logic [5:0] label_last(input logic [1:0] label);
        begin
            case (label)
                2'd0: label_last = 6'd8;
                2'd1: label_last = 6'd11;
                2'd2: label_last = 6'd8;
                default: label_last = 6'd10;
            endcase
        end
    endfunction

    function automatic [31:0] selected_value(input state_t state);
        begin
            case (state)
                SEND_CYCLES_HEX:  selected_value = cycles_q;
                SEND_FETCHES_HEX: selected_value = fetches_q;
                SEND_HITS_HEX:    selected_value = hits_q;
                default:          selected_value = stalls_q;
            endcase
        end
    endfunction

    always_comb begin
        hex_value = selected_value(state_q);
        hex_msb   = 5'd31 - {index_q[2:0], 2'b00};
        label_last_index = (state_q == SEND_CYCLES_LABEL)  ? label_last(2'd0) :
                           (state_q == SEND_FETCHES_LABEL) ? label_last(2'd1) :
                           (state_q == SEND_HITS_LABEL)    ? label_last(2'd2) :
                                                            label_last(2'd3);
    end

    always_comb begin
        tx_data  = 8'h00;
        tx_valid = 1'b0;

        unique case (state_q)
            SEND_BANNER: begin
                tx_data  = banner_char(index_q);
                tx_valid = 1'b1;
            end
            SEND_CYCLES_LABEL: begin
                tx_data  = label_char(2'd0, index_q);
                tx_valid = 1'b1;
            end
            SEND_FETCHES_LABEL: begin
                tx_data  = label_char(2'd1, index_q);
                tx_valid = 1'b1;
            end
            SEND_HITS_LABEL: begin
                tx_data  = label_char(2'd2, index_q);
                tx_valid = 1'b1;
            end
            SEND_STALLS_LABEL: begin
                tx_data  = label_char(2'd3, index_q);
                tx_valid = 1'b1;
            end
            SEND_CYCLES_HEX,
            SEND_FETCHES_HEX,
            SEND_HITS_HEX,
            SEND_STALLS_HEX: begin
                tx_data  = hex_char(hex_value[hex_msb -: 4]);
                tx_valid = 1'b1;
            end
            SEND_DONE_EOL: begin
                tx_data  = (index_q == 6'd0) ? 8'h0d : 8'h0a;
                tx_valid = 1'b1;
            end
            default: begin
            end
        endcase
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            state_q   <= IDLE;
            index_q   <= 6'd0;
            cycles_q  <= 32'b0;
            fetches_q <= 32'b0;
            hits_q    <= 32'b0;
            stalls_q  <= 32'b0;
        end else begin
            case (state_q)
                IDLE: begin
                    index_q <= 6'd0;
                    if (start_i) begin
                        cycles_q  <= cycle_count_i;
                        fetches_q <= external_ifetch_count_i;
                        hits_q    <= loop_hit_count_i;
                        stalls_q  <= stall_count_i;
                        state_q   <= SEND_BANNER;
                    end
                end

                SEND_BANNER: begin
                    if (tx_valid && tx_ready) begin
                        if (index_q == 6'd25) begin
                            index_q <= 6'd0;
                            state_q <= SEND_CYCLES_LABEL;
                        end else begin
                            index_q <= index_q + 1'b1;
                        end
                    end
                end

                SEND_CYCLES_LABEL,
                SEND_FETCHES_LABEL,
                SEND_HITS_LABEL,
                SEND_STALLS_LABEL: begin
                    if (tx_valid && tx_ready) begin
                        if (index_q == label_last_index) begin
                            index_q <= 6'd0;
                            case (state_q)
                                SEND_CYCLES_LABEL:  state_q <= SEND_CYCLES_HEX;
                                SEND_FETCHES_LABEL: state_q <= SEND_FETCHES_HEX;
                                SEND_HITS_LABEL:    state_q <= SEND_HITS_HEX;
                                default:            state_q <= SEND_STALLS_HEX;
                            endcase
                        end else begin
                            index_q <= index_q + 1'b1;
                        end
                    end
                end

                SEND_CYCLES_HEX,
                SEND_FETCHES_HEX,
                SEND_HITS_HEX,
                SEND_STALLS_HEX: begin
                    if (tx_valid && tx_ready) begin
                        if (index_q == 6'd7) begin
                            index_q <= 6'd0;
                            case (state_q)
                                SEND_CYCLES_HEX:  state_q <= SEND_FETCHES_LABEL;
                                SEND_FETCHES_HEX: state_q <= SEND_HITS_LABEL;
                                SEND_HITS_HEX:    state_q <= SEND_STALLS_LABEL;
                                default:          state_q <= SEND_DONE_EOL;
                            endcase
                        end else begin
                            index_q <= index_q + 1'b1;
                        end
                    end
                end

                SEND_DONE_EOL: begin
                    if (tx_valid && tx_ready) begin
                        if (index_q == 6'd1)
                            state_q <= DONE;
                        else
                            index_q <= index_q + 1'b1;
                    end
                end

                DONE: begin
                    state_q <= DONE;
                end

                default: state_q <= IDLE;
            endcase
        end
    end

endmodule

`default_nettype wire

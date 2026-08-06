// TX Framer

`timescale 1ns / 1ps
`default_nettype none

module tx_framer #(
    parameter int unsigned CLKS_PER_BIT = 1000  // 1シンボルのクロック数
) (
    input  logic       clk,       // クロック
    input  logic       rst_n,     // 非同期リセット

    // 6bit + pre + start + end
    input  logic [5:0] tx_data,   // 6bitデータ
    input  logic       tx_valid,  // 送信要求
    input  logic       tx_sop,    // パケット開始フラグ
    input  logic       tx_eop,    // パケット終了フラグ
    output logic       tx_ready,  // 受付可能

    // アナログ AFE インターフェース
    output logic       ro_en,     // 送るシンボル
    output logic       tx_busy    // パケット占有中フラグ
);

    // FSM

    typedef enum logic [2:0] {
        IDLE,   // パケット外
        PRE1,   // プリアンブル1シンボル目(ON)
        PRE2,   // プリアンブル2シンボル目(ON)
        START,  // スタートシンボル(OFF)。下降エッジがRXの語同期点
        DATA,   // データ6bitを1ビットずつ送信中
        STOP,   // ストップシンボル(ON)
        GAP     // 語間待機(ONを保持)。次の語かEOP後のOFFを待つ
    } state_t;
    state_t state;

    logic [5:0] sh;         
    logic [2:0] bit_cnt;     
    logic       last_word;  

    localparam int unsigned TICKW = (CLKS_PER_BIT <= 1) ? 1 : $clog2(CLKS_PER_BIT);
    logic [TICKW-1:0] tick;
    wire symbol_end = (tick == TICKW'(CLKS_PER_BIT - 1));

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= IDLE;
            tick      <= '0;
            sh        <= '0;
            bit_cnt   <= '0;
            last_word <= 1'b0;
        end else begin
            tick <= (state == IDLE || state == GAP || symbol_end) ? '0 : tick + 1'b1;

            unique case (state)
                IDLE, GAP: begin
                    if (tx_valid) begin  // tx_readyは1なので、このクロックで受け渡し成立
                        sh        <= tx_data;
                        bit_cnt   <= 3'd5;
                        last_word <= tx_eop;
                        if (tx_sop) state <= PRE1;
                        else        state <= START;
                    end
                end

                PRE1:  if (symbol_end) state <= PRE2;
                PRE2:  if (symbol_end) state <= START;
                START: if (symbol_end) state <= DATA;

                DATA: if (symbol_end) begin
                    sh <= {sh[4:0], 1'b0}; // 左シフト (MSBファースト)
                    if (bit_cnt == '0) state <= STOP;
                    else               bit_cnt <= bit_cnt - 1'b1;
                end

                // EOP語ならパケット終了(OFFへ)、続きがあるなら語間ON保持へ
                STOP: if (symbol_end) begin
                    if (last_word) state <= IDLE;
                    else           state <= GAP;
                end

                default: state <= IDLE;  // 万一の不正状態からの復帰用の保険
            endcase
        end
    end

    wire data_bit = sh[5];
    always_comb begin
        case (state)
            PRE1, PRE2: ro_en = 1'b1;      // プリアンブル = ON
            START:      ro_en = 1'b0;      // スタート = OFF(下降エッジを作る)
            DATA:       ro_en = data_bit;  // データビットそのもの
            STOP:       ro_en = 1'b1;      // ストップ = ON
            GAP:        ro_en = 1'b1;      // 語間もON保持(この方式の要。冒頭コメント参照)
            default:    ro_en = 1'b0;      // IDLE = OFF
        endcase
    end

    assign tx_ready = (state == IDLE) || (state == GAP);
    assign tx_busy  = (state != IDLE);

endmodule

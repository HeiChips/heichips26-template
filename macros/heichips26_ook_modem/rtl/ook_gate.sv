// On-Off Keying用のゲート
// 役割:
//  tx_framer からの ro_en 信号を受け取り、
//  ・ベースバンドモード (mode_carrier = 0): ro_en をそのまま出力
//  ・キャリアモード    (mode_carrier = 1): キャリアクロック(carrier_clk)と ro_en の AND を出力
//  送信中以外 (tx_busy = 0) の保護・ミュート処理を行う。

`timescale 1ns / 1ps
`default_nettype none

module ook_gate (
    input logic mode_carrier,  // 0 = ベースバンド, 1 = キャリアOOK変調
    input logic ro_en,
    input logic carrier_clk,
    input logic tx_busy,
    output logic ook_out,
    output logic tx_drive_en
);

    wire modulated_sig = mode_carrier ? (ro_en & carrier_clk) : ro_en;
    assign ook_out     = tx_busy ? modulated_sig : 1'b0;
    assign tx_drive_en = tx_busy;
endmodule

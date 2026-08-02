module heichips26_analog_project (
`ifdef USE_POWER_PINS
    inout VAPWR,
    inout VGND,
    inout VPWR,
`endif
    inout analog_0,
    inout analog_1,
    inout analog_2,
    inout clk,
    inout ena,
    inout rst_n,
    inout [7:0] ui_in,
    inout [7:0] uio_in,
    inout [7:0] uio_oe,
    inout [7:0] uio_out,
    inout [7:0] uo_out
);
endmodule

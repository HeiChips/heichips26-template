module inverter (
`ifdef USE_POWER_PINS
    inout VDD,
    inout VSS,
`endif
    inout vin,
    inout vout
);
endmodule

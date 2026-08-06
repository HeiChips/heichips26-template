set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk_i]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_i]

# sw[0] toggle: 0 = held in reset, 1 = run
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports rst_ni]
# sw[1] toggle: enable
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports enable_i]

set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports {count_o[0]}]
set_property -dict { PACKAGE_PIN E19 IOSTANDARD LVCMOS33 } [get_ports {count_o[1]}]
set_property -dict { PACKAGE_PIN U19 IOSTANDARD LVCMOS33 } [get_ports {count_o[2]}]
set_property -dict { PACKAGE_PIN V19 IOSTANDARD LVCMOS33 } [get_ports {count_o[3]}]
set_property -dict { PACKAGE_PIN W18 IOSTANDARD LVCMOS33 } [get_ports {count_o[4]}]
set_property -dict { PACKAGE_PIN U15 IOSTANDARD LVCMOS33 } [get_ports {count_o[5]}]
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports {count_o[6]}]
set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports {count_o[7]}]

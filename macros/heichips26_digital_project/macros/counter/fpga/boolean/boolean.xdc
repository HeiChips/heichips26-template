set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {clk_i}]

# sw[0] toggle: 0 = held in reset, 1 = run
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {rst_ni}]
# sw[1] toggle: enable
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {enable_i}]

set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {count_o[0]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {count_o[1]}]
set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports {count_o[2]}]
set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS33} [get_ports {count_o[3]}]
set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports {count_o[4]}]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {count_o[5]}]
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {count_o[6]}]
set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {count_o[7]}]

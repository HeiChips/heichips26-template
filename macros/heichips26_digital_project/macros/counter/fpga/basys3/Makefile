# SPDX-FileCopyrightText: 2026 The HeiChips contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: Basys 3 (Xilinx Artix-7 xc7a35tcpg236-1). Native counter ports
# mapped directly, no board-top wrapper. rst_ni/enable_i are sw[0]/
# sw[1] toggles, not momentary buttons (basys3's buttons are active-high,
# which would hold rst_ni asserted at idle). See ../README.md.

TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := basys3.xdc

include ../../../../fpga/boards/basys3.mk
include ../../../../fpga/fpga.mk

# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: RealDigital Boolean (Xilinx Spartan-7 xc7s50csga324-1). Native
# counter ports mapped directly, no board-top wrapper. rst_ni/enable_i
# are sw[0]/sw[1] toggles, not momentary buttons (boolean's buttons are
# active-high, which would hold rst_ni asserted at idle). See
# ../README.md.

TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := boolean.xdc

include ../../../../fpga/boards/boolean.mk
include ../../../../fpga/fpga.mk

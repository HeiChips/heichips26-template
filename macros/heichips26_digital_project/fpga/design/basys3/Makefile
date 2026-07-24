# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: Basys 3 (Xilinx Artix-7 xc7a35tcpg236-1).
# See ../../README.md and ../../arch/xilinx7.mk.

TOP := basys3_top

include ../../dut.mk
MODULES_SYNTH := $(DUT_SRCS) basys3_top.sv

PCF_FILE := Basys-3-Master.xdc

include ../../boards/basys3.mk
include ../../fpga.mk

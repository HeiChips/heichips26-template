# SPDX-FileCopyrightText: 2026 The HeiChips contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: RealDigital Boolean (Xilinx Spartan-7 xc7s50csga324-1). Prepared,
# untested — see ../README.md and ../arch/xilinx7.mk.

TOP := boolean_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS) boolean_top.sv

PCF_FILE := boolean.xdc

include ../boards/boolean.mk
include ../fpga.mk

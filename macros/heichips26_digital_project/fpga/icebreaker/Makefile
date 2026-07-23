# SPDX-FileCopyrightText: 2026 The HeiChips contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# iCEBreaker (iCE40UP5K, SG48). Yosys -> nextpnr-ice40 ->
# icepack, flashed with iceprog. See ../README.md.

TOP := icebreaker_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS) icebreaker_top.sv

PCF_FILE := icebreaker.pcf

include ../boards/icebreaker.mk
include ../fpga.mk

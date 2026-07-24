# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: ULX3S (Lattice ECP5-85F, CABGA381). See ../../README.md.

TOP := ulx3s_top

include ../../dut.mk
MODULES_SYNTH := $(DUT_SRCS) ulx3s_top.sv

PCF_FILE := ulx3s_v20.lpf

include ../../boards/ulx3s.mk
include ../../fpga.mk

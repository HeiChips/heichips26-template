# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: ULX3S (Lattice ECP5-85F). Native counter ports mapped directly,
# no board-top wrapper. See ../../../../fpga/README.md.

TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := ulx3s.lpf

include ../../../../fpga/boards/ulx3s.mk
include ../../../../fpga/fpga.mk

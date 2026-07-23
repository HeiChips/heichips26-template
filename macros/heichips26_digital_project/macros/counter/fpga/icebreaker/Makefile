# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: iCEBreaker (iCE40UP5K, SG48). Native counter ports mapped
# directly, no board-top wrapper. See ../../../../fpga/README.md.

TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := icebreaker.pcf

include ../../../../fpga/boards/icebreaker.mk
include ../../../../fpga/fpga.mk

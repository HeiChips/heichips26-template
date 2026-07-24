# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: pico-ice (iCE40UP5K, SG48). Native counter ports (clk_i,
# rst_ni, enable_i, count_o) mapped directly, no board-top
# wrapper needed. PCF is shared with (not copied from) the top-level FPGA
# flow. See ../../../../fpga/README.md.

TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := $(TOP_FPGA_DIR)/design/pico-ice/pico-ice.pcf

include $(TOP_FPGA_DIR)/boards/pico-ice.mk
include $(TOP_FPGA_DIR)/fpga.mk

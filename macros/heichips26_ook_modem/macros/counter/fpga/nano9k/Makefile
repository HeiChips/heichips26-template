# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: Tang Nano 9K (Gowin GW1NR-9C). Native counter ports mapped
# directly, no board-top wrapper. See ../../../../fpga/README.md.

TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := nano9k.cst

include $(TOP_FPGA_DIR)/boards/nano9k.mk
include $(TOP_FPGA_DIR)/fpga.mk

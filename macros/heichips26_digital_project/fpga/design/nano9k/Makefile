# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: Tang Nano 9K (Gowin GW1NR-9C). See ../../README.md.

TOP := nano9k_top

include ../../dut.mk
MODULES_SYNTH := $(DUT_SRCS) nano9k_top.sv

PCF_FILE := nano9k.cst

include ../../boards/nano9k.mk
include ../../fpga.mk

# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# RTL of the design under test, shared by all boards.

SRC_DIR := ../../../rtl

DUT_SRCS := \
	$(SRC_DIR)/fpga_top_module.sv \
	$(SRC_DIR)/accelerator/*.sv \
	$(SRC_DIR)/UART/*.sv \
	$(SRC_DIR)/UART/*.v

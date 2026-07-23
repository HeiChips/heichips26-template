# SPDX-FileCopyrightText: 2026 The HeiChips contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# RTL of the design under test, shared by all boards.

SRC_DIR := ../../rtl

DUT_SRCS := \
	../../macros/counter/rtl/counter.sv \
	$(SRC_DIR)/heichips26_digital_project.sv

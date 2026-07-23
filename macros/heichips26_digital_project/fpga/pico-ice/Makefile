# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Board: pico-ice (iCE40UP5K, SG48). No PLL — clk_i drives the design
# clock directly. Flashed via fpga.mk's dfu-util default. See ../README.md.

TOP := pico_ice_top

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS) pico_ice_top.sv

PCF_FILE := pico-ice.pcf

include ../boards/pico-ice.mk
include ../fpga.mk

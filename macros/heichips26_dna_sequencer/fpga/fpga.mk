# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Shared FPGA emulation flow (synthesis, place-and-route, bitstream).
#
# Included by thin per-board Makefiles, which set the sources and pin mapping
# and include their boards/<board>.mk first. That fragment names the board's
# ARCH, whose toolchain comes from arch/<arch>.mk, included below.

FPGA_MK_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

BUILD_DIR ?= build

include $(FPGA_MK_DIR)arch/$(ARCH).mk

# Variables to be set by the including Makefile:
#   TOP           - synthesis top module / instance name (required)
#   MODULES_SYNTH - explicit ordered source file list for TOP (required)
#   PCF_FILE      - board pin constraint file (required)
#   ARCH          - FPGA architecture, set by boards/<board>.mk (required)

# Full synthesis command. Only override this wholesale (instead of TARGET/
# SYNTH_OPTS) for a toolchain whose synth_* pass doesn't fit the
# "$(TARGET) $(SYNTH_OPTS) -top $(TOP)" shape (e.g. Xilinx's synth_xilinx).
SYNTH_CMD ?= yosys -DFPGA -p '$(TARGET) $(SYNTH_OPTS) -top $(TOP); write_json $(BUILD_DIR)/$(TOP).json;' $(MODULES_SYNTH)

# Extra prerequisites for the place-and-route step beyond $(TOP).json and
# $(PCF_FILE) (e.g. a one-time-generated chip database for a toolchain
# like nextpnr-xilinx that needs one).
PNR_DEPS  ?=

.DEFAULT_GOAL := help


# Help Target
help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -hE '^[a-zA-Z0-9_.-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help
# ================================================================================================


# Clean Target
clean: ## Remove generated files
	rm -rf $(BUILD_DIR)
.PHONY: clean
# ================================================================================================


# Synthesis Targets
synthesis: $(BUILD_DIR)/$(TOP).json ## Run technology-mapped synthesis
.PHONY: synthesis

$(BUILD_DIR)/$(TOP).json: $(MODULES_SYNTH) | $(BUILD_DIR)
	$(SYNTH_CMD)

synthesis_generic: $(BUILD_DIR)/$(TOP)_generic.json ## Run generic synthesis and generate Yosys graph
.PHONY: synthesis_generic

$(BUILD_DIR)/$(TOP)_generic.json: $(MODULES_SYNTH) | $(BUILD_DIR)
	yosys -p 'hierarchy -top $(TOP); proc; write_json $(BUILD_DIR)/$(TOP)_generic.json; show -format svg -prefix $(BUILD_DIR)/$(TOP)_generic_yosys $(TOP);' $(MODULES_SYNTH)
# ================================================================================================


# Place-and-Route Targets
pr: $(PNR_OUT) ## Run place-and-route
.PHONY: pr

$(PNR_OUT): $(BUILD_DIR)/$(TOP).json $(PCF_FILE) $(PNR_DEPS) | $(BUILD_DIR)
	$(PNR_CMD)

gen_bitstream: $(BITSTREAM) ## Generate FPGA bitstream
.PHONY: gen_bitstream

$(BITSTREAM): $(PNR_OUT) | $(BUILD_DIR)
	$(PACK_CMD)

load_bitstream: $(BITSTREAM) ## Load FPGA bitstream into SRAM (lost on power cycle)
	$(LOAD_CMD)
.PHONY: load_bitstream

flash_bitstream: $(BITSTREAM) ## Write FPGA bitstream to flash (persistent)
	$(FLASH_CMD)
.PHONY: flash_bitstream
# ================================================================================================


# Conversion Target
convert: $(BUILD_DIR)/$(TOP).v ## Convert SystemVerilog top to Verilog
.PHONY: convert

$(BUILD_DIR)/$(TOP).v: $(MODULES_SYNTH) | $(BUILD_DIR)
	yosys -DFPGA -p 'hierarchy -top $(TOP); proc; write_verilog $(BUILD_DIR)/$(TOP).v;' $(MODULES_SYNTH)
# ================================================================================================

$(BUILD_DIR):
	mkdir -p $@


# All Target
all: ## Run full FPGA flow (synthesis, place-and-route, bitstream)
	$(MAKE) clean
	$(MAKE) synthesis
	$(MAKE) pr
	$(MAKE) gen_bitstream
.PHONY: all
# ================================================================================================

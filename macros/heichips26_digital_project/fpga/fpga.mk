# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Shared FPGA emulation flow (lint, synthesis, place-and-route, bitstream).
#
# Included by thin per-board Makefiles, which set the sources and pin mapping
# and include their boards/<board>.mk first. That fragment names the board's
# ARCH, whose toolchain comes from arch/<arch>.mk, included below.

FPGA_MK_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

include $(FPGA_MK_DIR)arch/$(ARCH).mk

# Variables to be set by the including Makefile:
#   TOP           - synthesis top module / instance name (required)
#   SRC_DIR       - RTL source directory for lint -I (required)
#   MODULES_SYNTH - explicit ordered source file list for TOP (required)
#   PCF_FILE      - board pin constraint file (required)
#   ARCH          - FPGA architecture, set by boards/<board>.mk (required)

# Full synthesis command. Only override this wholesale (instead of TARGET/
# SYNTH_OPTS) for a toolchain whose synth_* pass doesn't fit the
# "$(TARGET) $(SYNTH_OPTS) -top $(TOP)" shape (e.g. Xilinx's synth_xilinx).
SYNTH_CMD ?= yosys -DFPGA -p '$(TARGET) $(SYNTH_OPTS) -top $(TOP); write_json $(TOP).json;' $(MODULES_SYNTH)

# Extra prerequisites for the place-and-route step beyond $(TOP).json and
# $(PCF_FILE) (e.g. a one-time-generated chip database for a toolchain
# like nextpnr-xilinx that needs one).
PNR_DEPS  ?=

# Extra generated files a board's non-default toolchain leaves behind
# (e.g. Xilinx .fasm/.frames), removed by `clean` alongside the common set.
EXTRA_CLEAN ?=

# Source list for the full-hierarchy lint-verilog check. Defaults to
# MODULES_SYNTH, but a project can override this to exclude files Verilator
# can't lint
MODULES_LINT ?= $(MODULES_SYNTH)

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
	rm -f test_pre *.vcd $(TOP).json* $(TOP).v $(PNR_OUT) $(BITSTREAM)
	rm -f $(TOP)_generic.json*
	rm -f $(TOP)_yosys.svg $(TOP)_yosys.dot $(TOP)_generic_yosys.svg $(TOP)_generic_yosys.dot
	rm -f $(EXTRA_CLEAN)
.PHONY: clean
# ================================================================================================


# Linter Target
lint-verilog: ## Lint the full design hierarchy with Verilator
	verilator --lint-only -I"$(SRC_DIR)" $(MODULES_LINT)
.PHONY: lint-verilog
# ================================================================================================


# Synthesis Targets
synthesis: $(TOP).json ## Run technology-mapped synthesis
.PHONY: synthesis

$(TOP).json: $(MODULES_SYNTH)
	$(SYNTH_CMD)

synthesis_generic: $(TOP)_generic.json ## Run generic synthesis and generate Yosys graph
.PHONY: synthesis_generic

$(TOP)_generic.json: $(MODULES_SYNTH)
	yosys -p 'hierarchy -top $(TOP); proc; write_json $(TOP)_generic.json; show -format svg -prefix $(TOP)_generic_yosys $(TOP);' $(MODULES_SYNTH)
# ================================================================================================


# Place-and-Route Targets
pr: $(PNR_OUT) ## Run place-and-route
.PHONY: pr

$(PNR_OUT): $(TOP).json $(PCF_FILE) $(PNR_DEPS)
	$(PNR_CMD)

pr-gui: $(TOP).json ## Run place-and-route in GUI mode
	$(PNR_GUI_CMD)
.PHONY: pr-gui

gen_bitstream: $(BITSTREAM) ## Generate FPGA bitstream
.PHONY: gen_bitstream

$(BITSTREAM): $(PNR_OUT)
	$(PACK_CMD)

flash_bitstream: $(BITSTREAM) ## Flash FPGA bitstream
	$(FLASH_CMD)
.PHONY: flash_bitstream
# ================================================================================================


# Conversion Target
convert: $(TOP).v ## Convert SystemVerilog top to Verilog
.PHONY: convert

$(TOP).v: $(MODULES_SYNTH)
	yosys -DFPGA -p 'hierarchy -top $(TOP); proc; write_verilog $(TOP).v;' $(MODULES_SYNTH)
# ================================================================================================


# All Target
all: ## Run full FPGA flow (lint, synthesis, place-and-route, bitstream)
	$(MAKE) clean
	$(MAKE) lint-verilog
	$(MAKE) synthesis
	$(MAKE) pr
	$(MAKE) gen_bitstream
.PHONY: all
# ================================================================================================

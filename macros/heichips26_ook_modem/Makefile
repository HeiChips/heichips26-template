# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

RUN_TAG = $(shell ls -1 $(LIBRELANE_DIR)/runs 2>/dev/null | tail -n 1)

# Variables
TOP = heichips26_digital_project

.DEFAULT_GOAL := help

# Cell name for verification targets (default: top-level cell)
# Override with: make <target> CELL=<cellname>
CELL ?= $(TOP)

# Set the waveform viewer GTKWave or Surfer (default: gtkwave)
# Override with: make <target> WAVEFORM_VIEWER=<gtkwave|surfer>
WAVEFORM_VIEWER ?= gtkwave

# Folder structure
MACROS_DIR      := macros
COCOTB_DIR      := testbenches/cocotb
VERILOG_TB_DIR 	:= testbenches/verilog
REPORT_DIR     	:= verification
SRC_DIR 		:= rtl
NET_NL_DIR    	:= netlist/nl
NET_PNL_DIR  	:= netlist/pnl
NET_SPICE_DIR 	:= netlist/spice
LIBRELANE_DIR 	:= flow/librelane
FLOW_FINAL_DIR 	:= flow/final
FINAL_DIR      	:= final

# Variables for simulation and linting targets
# The counter sub-macro is hardened separately (see macros/counter/), but its RTL
# is needed for linting and RTL simulation of the whole design.
MODULES_SYNTH := \
	$(SRC_DIR)/heichips26_digital_project.sv \
	$(MACROS_DIR)/counter/rtl/counter.sv

MODULES_SIM := \
	$(MODULES_SYNTH)

# Source files for sim-rtl-verilog: auto-selects MODULES_SIM when CELL == TOP, single-file otherwise (prefers .sv, falls back to .v)
_SIM_SRCS = $(if $(filter $(CELL),$(TOP)),$(MODULES_SIM),$(or $(wildcard $(SRC_DIR)/$(CELL).sv),$(SRC_DIR)/$(CELL).v))

# Source files for lint-verilog: all synthesis sources for TOP, single-file otherwise (prefers .sv, falls back to .v)
_LINT_SRCS = $(if $(filter $(CELL),$(TOP)),$(MODULES_SYNTH),$(or $(wildcard $(SRC_DIR)/$(CELL).sv),$(SRC_DIR)/$(CELL).v))

# Testbench extension: prefers <CELL>_tb.sv, falls back to <CELL>_tb.v (dot is added at use site)
_TB_EXT = $(if $(wildcard $(VERILOG_TB_DIR)/$(CELL)_tb.sv),sv,v)


# Help Target
help: ## Show this help message
	@echo 'Usage: make <target> [CELL=<cellname>] [WAVEFORM_VIEWER=<gtkwave|surfer>]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z0-9_.-]+:.*## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*## "}; {printf "  %-20s %s\n", $$1, $$2}'
	@echo ''
	@echo 'CELL defaults to $(TOP). Override to lint or simulate subcells.'
	@echo 'WAVEFORM_VIEWER defaults to gtkwave. Use surfer to launch Surfer instead.'
.PHONY: help
# ================================================================================================


# Linter Targets
lint-verilog: ## Lint Verilog source files with Verilator (usage: make lint-verilog [CELL=<cellname>])
	verilator --lint-only -I"$(SRC_DIR)" $(_LINT_SRCS)
.PHONY: lint-verilog

lint-verilog-all: ## Lint all Verilog source files (counter sub-macro + heichips26_digital_project)
	$(MAKE) -C $(MACROS_DIR)/counter lint-verilog-all
	$(MAKE) lint-verilog
.PHONY: lint-verilog-all
# ================================================================================================


# Simulation Targets
sim-rtl-verilog: ## Run RTL simulation of CELL cell with Icarus Verilog (usage: make sim-rtl-verilog [CELL=<cellname>])
	iverilog -g2012 -DSIM -o $(VERILOG_TB_DIR)/test_$(CELL) $(_SIM_SRCS) $(VERILOG_TB_DIR)/$(CELL)_tb.$(_TB_EXT)
	cd $(VERILOG_TB_DIR) && vvp test_$(CELL) -fst
	rm -f $(VERILOG_TB_DIR)/test_$(CELL)
.PHONY: sim-rtl-verilog

sim-view-verilog: ## View CELL cell Verilog simulation waveforms (usage: make sim-view-verilog [CELL=<cellname>] [WAVEFORM_VIEWER=<gtkwave|surfer>])
	@if [ "$(WAVEFORM_VIEWER)" = "gtkwave" ]; then \
		$(WAVEFORM_VIEWER) $(VERILOG_TB_DIR)/$(CELL)_tb.fst $(VERILOG_TB_DIR)/$(CELL)_tb.gtkw; \
	elif [ "$(WAVEFORM_VIEWER)" = "surfer" ]; then \
		$(WAVEFORM_VIEWER) -s $(VERILOG_TB_DIR)/$(CELL)_tb.surf.ron $(VERILOG_TB_DIR)/$(CELL)_tb.fst; \
	else \
		$(WAVEFORM_VIEWER) $(VERILOG_TB_DIR)/$(CELL)_tb.fst; \
	fi
.PHONY: sim-view-verilog

sim-rtl-cocotb: ## Run RTL simulation of CELL cell with cocotb (usage: make sim-rtl-cocotb [CELL=<cellname>])
	cd $(COCOTB_DIR) && python3 $(CELL)_tb.py
.PHONY: sim-rtl-cocotb

sim-gl-cocotb: ## Run gate-level simulation of CELL cell with cocotb (usage: make sim-gl-cocotb [CELL=<cellname>])
	cd $(COCOTB_DIR) && GL=1 python3 $(CELL)_tb.py
.PHONY: sim-gl-cocotb

sim-view-cocotb: ## View CELL cell cocotb simulation waveforms (usage: make sim-view-cocotb [CELL=<cellname>] [WAVEFORM_VIEWER=<gtkwave|surfer>])
	@if [ "$(WAVEFORM_VIEWER)" = "gtkwave" ]; then \
		$(WAVEFORM_VIEWER) $(COCOTB_DIR)/sim_build/$(CELL).fst $(COCOTB_DIR)/$(CELL)_tb.gtkw; \
	elif [ "$(WAVEFORM_VIEWER)" = "surfer" ]; then \
		$(WAVEFORM_VIEWER) -s $(COCOTB_DIR)/$(CELL)_tb.surf.ron $(COCOTB_DIR)/sim_build/$(CELL).fst; \
	else \
		$(WAVEFORM_VIEWER) $(COCOTB_DIR)/sim_build/$(CELL).fst; \
	fi
.PHONY: sim-view-cocotb

sim-all: ## Simulate the macro (RTL Verilog + RTL/GL cocotb for heichips26_digital_project)
	$(MAKE) sim-rtl-verilog
	$(MAKE) sim-rtl-cocotb
	$(MAKE) sim-gl-cocotb
.PHONY: sim-all
# ================================================================================================


# LibreLane Targets
librelane: ## Run LibreLane with Magic and KLayout DRC checks.
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to $(FLOW_FINAL_DIR)/
.PHONY: librelane

librelane-nodrc: ## Run LibreLane without DRC checks
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to $(FLOW_FINAL_DIR)/ --skip KLayout.DRC --skip Magic.DRC
.PHONY: librelane-nodrc

librelane-magicdrc: ## Run LibreLane with only Magic DRC checks
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to $(FLOW_FINAL_DIR)/ --skip KLayout.DRC
.PHONY: librelane-magicdrc

librelane-klayoutdrc: ## Run LibreLane with only KLayout DRC checks
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --save-views-to $(FLOW_FINAL_DIR)/ --skip Magic.DRC
.PHONY: librelane-klayoutdrc

librelane-openroad: ## Open the last LibreLane run in OpenROAD GUI
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --last-run --flow OpenInOpenROAD
.PHONY: librelane-openroad

librelane-klayout: ## Open the last LibreLane run in KLayout
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} --manual-pdk --last-run --flow OpenInKLayout
.PHONY: librelane-klayout
# ================================================================================================


# Copy Targets
# Using * wildcard to ignore step numbers
copy-reports: ## Copy yosys, antenna, STA, power, IR-drop, DRC, LVS and manufacturability reports from the last LibreLane run to verification/
	rm -rf $(REPORT_DIR)/
	mkdir -p $(REPORT_DIR)/
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-yosys-synthesis/reports/pre_synth_chk.rpt $(REPORT_DIR)/yosys_synth_check.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-yosys-synthesis/reports/pre_techmap.rpt $(REPORT_DIR)/yosys_pre_techmap.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-yosys-synthesis/reports/post_dff.rpt $(REPORT_DIR)/yosys_post_dff.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-yosys-synthesis/reports/stat.rpt $(REPORT_DIR)/stat.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-checkantennas-1/reports/antenna.rpt $(REPORT_DIR)/antenna_violations.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-checkantennas-1/reports/antenna_summary.rpt $(REPORT_DIR)/antenna_summary.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-stapostpnr/summary.rpt $(REPORT_DIR)/stapostpnr_summary.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-stapostpnr/nom_fast_1p32V_m40C/power.rpt $(REPORT_DIR)/stapostpnr_nom_fast_1p32V_m40C_power.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-stapostpnr/nom_slow_1p08V_125C/power.rpt $(REPORT_DIR)/stapostpnr_nom_slow_1p08V_125C_power.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-stapostpnr/nom_typ_1p20V_25C/power.rpt $(REPORT_DIR)/stapostpnr_nom_typ_1p20V_25C_power.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-openroad-irdropreport/irdrop.rpt $(REPORT_DIR)/irdrop.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-magic-drc/reports/drc.magic.rpt $(REPORT_DIR)/drc.magic.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-klayout-drc/reports/drc.klayout.json $(REPORT_DIR)/drc.klayout.json
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-netgen-lvs/reports/lvs.netgen.rpt $(REPORT_DIR)/lvs.netgen.rpt
	cp $(LIBRELANE_DIR)/runs/${RUN_TAG}/*-misc-reportmanufacturability/manufacturability.rpt $(REPORT_DIR)/manufacturability.rpt
.PHONY: copy-reports

copy-final: ## Copy final output gds, lef, lib, nl, pnl, spef, vh and render folders from the last LibreLane run to final/
	rm -rf $(FINAL_DIR)/
	mkdir -p $(FINAL_DIR)/
	cp -r $(FLOW_FINAL_DIR)/gds    $(FINAL_DIR)/gds
	cp -r $(FLOW_FINAL_DIR)/lef    $(FINAL_DIR)/lef
	cp -r $(FLOW_FINAL_DIR)/lib    $(FINAL_DIR)/lib
	cp -r $(FLOW_FINAL_DIR)/nl     $(FINAL_DIR)/nl
	cp -r $(FLOW_FINAL_DIR)/pnl    $(FINAL_DIR)/pnl
	cp -r $(FLOW_FINAL_DIR)/spef   $(FINAL_DIR)/spef
	cp -r $(FLOW_FINAL_DIR)/vh     $(FINAL_DIR)/vh
	cp -r $(FLOW_FINAL_DIR)/render $(FINAL_DIR)/render
.PHONY: copy-final

copy-netlist: ## Copy final output spice, pnl and nl netlists from the last LibreLane run to netlist/
	rm -rf $(NET_SPICE_DIR)/
	mkdir -p $(NET_SPICE_DIR)/
	cp -r $(FLOW_FINAL_DIR)/spice/${TOP}.spice $(NET_SPICE_DIR)/${TOP}.spice

	rm -rf $(NET_PNL_DIR)/
	mkdir -p $(NET_PNL_DIR)/
	cp -r $(FLOW_FINAL_DIR)/pnl/${TOP}.pnl.v $(NET_PNL_DIR)/${TOP}.pnl.v

	rm -rf $(NET_NL_DIR)/
	mkdir -p $(NET_NL_DIR)/
	cp -r $(FLOW_FINAL_DIR)/nl/${TOP}.nl.v $(NET_NL_DIR)/${TOP}.nl.v
.PHONY: copy-netlist
# ================================================================================================


# Build Targets
build-counter: ## Lint, build, verify and simulate the counter macro
	@$(MAKE) -C $(MACROS_DIR)/counter all
.PHONY: build-counter

build-macros: ## Lint, build, verify and simulate all macros
	$(MAKE) build-counter
#	ToDo: further macros
.PHONY: build-macros

build-fpga: ## Build FPGA bitstream (usage: make build-fpga [BOARD=ulx3s])
	@$(MAKE) -C fpga all
.PHONY: build-fpga

load-fpga: ## Load FPGA bitstream into SRAM (usage: make load-fpga [BOARD=ulx3s])
	@$(MAKE) -C fpga load_bitstream
.PHONY: load-fpga

flash-fpga: ## Write FPGA bitstream to flash (usage: make flash-fpga [BOARD=ulx3s])
	@$(MAKE) -C fpga flash_bitstream
.PHONY: flash-fpga

build-top: ## Build macro (run LibreLane with KLayout & Magic DRC checks, copy reports, copy final files, and copy netlists)
	$(MAKE) librelane
	$(MAKE) copy-reports
	$(MAKE) copy-final
	$(MAKE) copy-netlist
#	$(MAKE) librelane-openroad
.PHONY: build-top
# ================================================================================================


# DRC & LVS Verification Targets
# The LibreLane flow already includes DRC and LVS checks with Magic and KLayout, and they are saved in the verification/ folder.
# ================================================================================================


# Lint, Build, Verify and Simulate All Target
all: ## Lint, build, verify and simulate the macros and the TOP cell
	$(MAKE) lint-verilog-all
	$(MAKE) build-macros
	$(MAKE) build-fpga
	$(MAKE) build-top
	$(MAKE) sim-all
.PHONY: all
# ================================================================================================


# Clean Targets
clean: ## Delete all generated files and folders of the TOP cell (LibreLane outputs, final, netlist, reports, simulation and FPGA outputs)
	rm -rf $(LIBRELANE_DIR)/runs $(FLOW_FINAL_DIR)
	rm -rf final netlist
	rm -rf $(REPORT_DIR)
	rm -rf $(COCOTB_DIR)/sim_build $(VERILOG_TB_DIR)/*.fst
	@$(MAKE) -C fpga clean
.PHONY: clean

clean-counter: ## Delete all generated files and folders of the counter macro
	@$(MAKE) -C $(MACROS_DIR)/counter clean
.PHONY: clean-counter

clean-macros: ## Delete all generated files and folders of all macros
	$(MAKE) clean-counter
#	ToDo: further macros
.PHONY: clean-macros

clean-all: ## Delete all generated files and folders of the macros and the TOP cell
	$(MAKE) clean-macros
	$(MAKE) clean
.PHONY: clean-all
# ================================================================================================

# SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

TOP := heichips26_loopcache_rv
REPO_ROOT := ../..
SRC_DIR := rtl
COCOTB_DIR := testbenches/cocotb
VERILOG_TB_DIR := testbenches/verilog
LIBRELANE_DIR := flow/librelane
FLOW_FINAL_DIR := flow/final
FINAL_DIR := final
REPORT_DIR := verification
NETLIST_DIR := netlist

PICORV32 := $(REPO_ROOT)/third_party/picorv32/picorv32.v
RTL_SOURCES := \
	$(PICORV32) \
	$(SRC_DIR)/loopcache_frontend.sv \
	$(SRC_DIR)/narrow_mem_bridge.sv \
	$(SRC_DIR)/loopcache_soc.sv \
	$(SRC_DIR)/$(TOP).sv

RUN_TAG = $(shell ls -1 $(LIBRELANE_DIR)/runs 2>/dev/null | tail -n 1)
.DEFAULT_GOAL := help

help: ## Show available targets
	@echo 'Usage: make <target>'
	@grep -E '^[a-zA-Z0-9_.-]+:.*## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  %-22s %s\n", $$1, $$2}'
.PHONY: help

firmware: ## Assemble the dependency-free RV32E benchmark image
	python3 $(REPO_ROOT)/firmware/assemble_loopcache_test.py
.PHONY: firmware

lint-verilog: ## Lint all synthesizable RTL with Verilator
	verilator --lint-only --timing -Wall -Wno-fatal -Wno-PINMISSING $(RTL_SOURCES)
.PHONY: lint-verilog

synth-check: ## Run a technology-independent Yosys synthesis check
	yosys -p 'read_verilog -sv $(RTL_SOURCES); hierarchy -check -top $(TOP); synth -top $(TOP); check; stat'
.PHONY: synth-check

sim-rtl-verilog: firmware ## Run the self-checking SystemVerilog testbench
	iverilog -g2012 -DSIM -o $(VERILOG_TB_DIR)/test_$(TOP) \
		$(RTL_SOURCES) $(VERILOG_TB_DIR)/$(TOP)_tb.sv
	cd $(VERILOG_TB_DIR) && vvp test_$(TOP) -fst
	rm -f $(VERILOG_TB_DIR)/test_$(TOP)
.PHONY: sim-rtl-verilog

sim-rtl-cocotb: firmware ## Compare cache OFF and ON using the Cocotb benchmark
	cd $(COCOTB_DIR) && python3 $(TOP)_tb.py
.PHONY: sim-rtl-cocotb

sim-gl-cocotb: firmware ## Run the benchmark against the generated gate-level netlist
	cd $(COCOTB_DIR) && GL=1 python3 $(TOP)_tb.py
.PHONY: sim-gl-cocotb

sim-all: sim-rtl-verilog sim-rtl-cocotb ## Run all pre-layout functional tests
.PHONY: sim-all

librelane: ## Harden the Large-slot macro and run sign-off checks
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} \
		--manual-pdk --save-views-to $(FLOW_FINAL_DIR)/
.PHONY: librelane

librelane-nodrc: ## Harden without Magic/KLayout DRC (iteration only)
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} \
		--manual-pdk --save-views-to $(FLOW_FINAL_DIR)/ \
		--skip KLayout.DRC --skip Magic.DRC
.PHONY: librelane-nodrc

librelane-openroad: ## Open the last run in OpenROAD
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} \
		--manual-pdk --last-run --flow OpenInOpenROAD
.PHONY: librelane-openroad

librelane-klayout: ## Open the last run in KLayout
	librelane $(LIBRELANE_DIR)/config.yaml --pdk ${PDK} --pdk-root ${PDK_ROOT} \
		--manual-pdk --last-run --flow OpenInKLayout
.PHONY: librelane-klayout

copy-results: ## Copy final views, netlists and key reports from the last run
	mkdir -p $(FINAL_DIR) $(REPORT_DIR) $(NETLIST_DIR)/nl $(NETLIST_DIR)/pnl $(NETLIST_DIR)/spice
	cp -r $(FLOW_FINAL_DIR)/gds $(FLOW_FINAL_DIR)/lef $(FLOW_FINAL_DIR)/lib \
		$(FLOW_FINAL_DIR)/nl $(FLOW_FINAL_DIR)/pnl $(FLOW_FINAL_DIR)/spef \
		$(FLOW_FINAL_DIR)/vh $(FLOW_FINAL_DIR)/render $(FINAL_DIR)/
	cp $(FLOW_FINAL_DIR)/nl/$(TOP).nl.v $(NETLIST_DIR)/nl/
	cp $(FLOW_FINAL_DIR)/pnl/$(TOP).pnl.v $(NETLIST_DIR)/pnl/
	cp $(FLOW_FINAL_DIR)/spice/$(TOP).spice $(NETLIST_DIR)/spice/
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-yosys-synthesis/reports/pre_synth_chk.rpt $(REPORT_DIR)/yosys_synth_check.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-yosys-synthesis/reports/pre_techmap.rpt $(REPORT_DIR)/yosys_pre_techmap.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-yosys-synthesis/reports/post_dff.rpt $(REPORT_DIR)/yosys_post_dff.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-yosys-synthesis/reports/stat.rpt $(REPORT_DIR)/stat.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-checkantennas-1/reports/antenna.rpt $(REPORT_DIR)/antenna_violations.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-checkantennas-1/reports/antenna_summary.rpt $(REPORT_DIR)/antenna_summary.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-stapostpnr/summary.rpt $(REPORT_DIR)/stapostpnr_summary.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-stapostpnr/nom_fast_1p32V_m40C/power.rpt $(REPORT_DIR)/stapostpnr_nom_fast_1p32V_m40C_power.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-stapostpnr/nom_slow_1p08V_125C/power.rpt $(REPORT_DIR)/stapostpnr_nom_slow_1p08V_125C_power.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-stapostpnr/nom_typ_1p20V_25C/power.rpt $(REPORT_DIR)/stapostpnr_nom_typ_1p20V_25C_power.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-openroad-irdropreport/irdrop.rpt $(REPORT_DIR)/irdrop.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-magic-drc/reports/drc.magic.rpt $(REPORT_DIR)/drc.magic.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-klayout-drc/reports/drc.klayout.json $(REPORT_DIR)/drc.klayout.json
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-netgen-lvs/reports/lvs.netgen.rpt $(REPORT_DIR)/lvs.netgen.rpt
	cp $(LIBRELANE_DIR)/runs/$(RUN_TAG)/*-misc-reportmanufacturability/manufacturability.rpt $(REPORT_DIR)/manufacturability.rpt
.PHONY: copy-results

build-top: ## Harden and collect submission artifacts
	$(MAKE) librelane
	$(MAKE) copy-results
.PHONY: build-top

all: firmware lint-verilog sim-all build-top ## Full pre-submit flow
.PHONY: all

clean: ## Remove only generated LoopCache-RV outputs
	rm -rf $(LIBRELANE_DIR)/runs $(FLOW_FINAL_DIR) $(FINAL_DIR) $(REPORT_DIR) $(NETLIST_DIR)
	rm -rf $(COCOTB_DIR)/sim_build $(VERILOG_TB_DIR)/*.fst $(VERILOG_TB_DIR)/test_$(TOP)
.PHONY: clean

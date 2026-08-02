# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PDK_ROOT ?= $(MAKEFILE_DIR)/IHP-Open-PDK
PDK ?= ihp-sg13cmos5l

PDK_REPO_IHP_OPEN_PDK ?= https://github.com/iic-jku/IHP-Open-PDK.git
PDK_COMMIT_IHP_OPEN_PDK ?= db70c13aa5dfe1dec1d286581fd1b9a2807ca331

PDK_REPO_IHP_CMOS5L ?= https://github.com/iic-jku/ihp-sg13cmos5l.git
PDK_COMMIT_IHP_CMOS5L ?= 11d3fee24f00d9117fe5e36aaf60c2ff141c70b3

KLAYOUT_PLUGINS = KLayoutPluginUtils \
                  AlignToolPlugin \
                  MoveQuicklyToolPlugin \
                  LayerShortcutsPlugin \
                  AutoBackupPlugin \
                  PinToolPlugin \
                  LibraryManagerPlugin \
                  VectorFileExportPlugin \
                  NetlistImportPlugin \
                  xsection

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
.PHONY: help

$(PDK_ROOT)/$(PDK):
	mkdir -p $(PDK_ROOT)
	# Clone repositories
	@echo "Cloning repositories…"
	git clone $(PDK_REPO_IHP_OPEN_PDK) --recurse-submodules --depth=1 --revision $(PDK_COMMIT_IHP_OPEN_PDK) $(PDK_ROOT)
	git clone $(PDK_REPO_IHP_CMOS5L) --recurse-submodules --depth=1 --revision $(PDK_COMMIT_IHP_CMOS5L) $(PDK_ROOT)/$(PDK)
	# Create missing symlinks
	@echo "Creating missing symlinks…"
	ln -s $(PDK_ROOT)/ihp-sg13g2/libs.tech/klayout/python/sg13g2_pycell_lib/ihp/device_base_code.py $(PDK_ROOT)/$(PDK)/libs.tech/klayout/python/sg13cmos5l_pycell_lib/ihp/device_base_code.py
	ln -s $(PDK_ROOT)/ihp-sg13g2/libs.tech/klayout/python/sg13g2_pycell_lib/ihp/guard_ring_code.py $(PDK_ROOT)/$(PDK)/libs.tech/klayout/python/sg13cmos5l_pycell_lib/ihp/guard_ring_code.py
	ln -s $(PDK_ROOT)/ihp-sg13g2/libs.tech/xschem/sg13g2_pr/ntap1_ring.sym $(PDK_ROOT)/$(PDK)/libs.tech/xschem/sg13g2_pr/ntap1_ring.sym
	ln -s $(PDK_ROOT)/ihp-sg13g2/libs.tech/xschem/sg13g2_pr/ptap1_ring.sym $(PDK_ROOT)/$(PDK)/libs.tech/xschem/sg13g2_pr/ptap1_ring.sym
	# Compile Verilog-A using OpenVAF-reloaded
	@echo "Compiling Verilog-A models using OpenVAF-reloaded…"
	cd $(PDK_ROOT)/ihp-sg13g2/libs.tech/verilog-a/; ./openvaf-compile-va.sh
	@echo "Congratulations, the PDK has been set up!"

clone-pdk: $(PDK_ROOT)/$(PDK) ## Clone the IHP-Open-PDK repository
.PHONY: clone-pdk

klayout-setup: ## Install the KLayout plugins in your user directory
	# Install KLayout Plugins
	@echo "Installing KLayout Plugins…"
	@for plugin in ${KLAYOUT_PLUGINS} ; do \
		echo "- $$plugin…" ; \
		KLAYOUT_PATH=$(PDK_ROOT)/$(PDK)/libs.tech/klayout/ klayout -t -ne -rr -b -y $$plugin ; \
		sleep 1; \
	done
	@echo "All plugins have been installed!"
.PHONY: klayout-setup

precheck: $(PDK_ROOT)/$(PDK) ## Run the precheck on the design specified in submission.yaml
	PDK_ROOT=$(PDK_ROOT) PDK=$(PDK) python3 .github/precheck/heichips_precheck.py --config submission.yaml
.PHONY: precheck

precheck-demo: $(PDK_ROOT)/$(PDK) ## Run the demo precheck (don't use for submission)
	PDK_ROOT=$(PDK_ROOT) PDK=$(PDK) python3 .github/precheck/heichips_precheck.py --config submission.yaml --demo
.PHONY: precheck-demo

klayout: $(PDK_ROOT)/$(PDK) ## Open KLayout (edit mode)
	KLAYOUT_PATH=$(PDK_ROOT)/$(PDK)/libs.tech/klayout/ klayout -e -n sg13cmos5l -c $(MAKEFILE_DIR)/config/klayoutrc
.PHONY: klayout

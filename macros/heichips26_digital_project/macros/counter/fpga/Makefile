# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Dispatcher: forwards every target to the chosen board's own Makefile
# (default: ulx3s). See ./README.md and ../../../fpga/README.md.

BOARD ?= ulx3s

.DEFAULT_GOAL := help

%:
	$(MAKE) -C $(BOARD) $@

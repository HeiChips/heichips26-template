# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Lattice iCE40: Yosys (synth_ice40) -> nextpnr-ice40 -> icepack.
# FLASH_CMD is per-board: iCE40 boards differ in programmer (iceprog, dfu-util).

TARGET     ?= synth_ice40
SYNTH_OPTS ?= -dsp -spram

ICE40_DEVICE ?= --up5k --package sg48

PNR_ARGS    ?= $(ICE40_DEVICE) --pcf-allow-unconstrained
PNR_OUT     ?= $(TOP).asc
PNR_CMD     ?= nextpnr-ice40 $(PNR_ARGS) --json $(TOP).json --pcf $(PCF_FILE) --asc $(PNR_OUT)
PNR_GUI_CMD ?= nextpnr-ice40 $(PNR_ARGS) --json $(TOP).json --asc $(PNR_OUT) --gui

BITSTREAM ?= $(TOP).bin
PACK_CMD  ?= icepack $(PNR_OUT) $(BITSTREAM)

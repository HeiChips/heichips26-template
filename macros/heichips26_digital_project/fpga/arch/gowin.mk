# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Gowin: Yosys (synth_gowin) -> nextpnr-himbaechel -> gowin_pack.

TARGET     ?= synth_gowin
SYNTH_OPTS ?=

GOWIN_DEVICE ?= GW1NR-LV9QN88PC6/I5
GOWIN_FAMILY ?= GW1N-9C

PNR_OUT     ?= $(TOP)_pnr.json
PNR_CMD     ?= nextpnr-himbaechel --json $(TOP).json --write $(PNR_OUT) --device $(GOWIN_DEVICE) --vopt family=$(GOWIN_FAMILY) --vopt cst=$(PCF_FILE)

BITSTREAM ?= $(TOP).fs
PACK_CMD  ?= gowin_pack -d $(GOWIN_FAMILY) -o $(BITSTREAM) $(PNR_OUT)
LOAD_CMD  ?= openFPGALoader --board=$(OPENFPGALOADER_BOARD) $(BITSTREAM)
FLASH_CMD ?= openFPGALoader --board=$(OPENFPGALOADER_BOARD) --write-flash $(BITSTREAM)

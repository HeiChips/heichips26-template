# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

# Xilinx 7-series: Yosys (synth_xilinx) -> nextpnr-xilinx -> fasm2frames -> xc7frames2bit.
#
# Needs the nix-openxc7 toolchain (nextpnr-xilinx + prjxray), a separate nix
# setup from the one this repo's other boards use. Enter that shell (it
# provides NEXTPNR_XILINX_PYTHON_DIR and PRJXRAY_DB_DIR), then `make pr`.

# synth_xilinx's flags don't fit fpga.mk's "$(TARGET) $(SYNTH_OPTS) -top $(TOP)" shape.
SYNTH_CMD ?= yosys -DFPGA -p "synth_xilinx -flatten -abc9 -arch xc7 -top $(TOP); write_json $(TOP).json;" $(MODULES_SYNTH)

# Generated once per package, then kept — not removed by `clean`.
$(CHIPDB):
	pypy3 $${NEXTPNR_XILINX_PYTHON_DIR}/bbaexport.py --device $(PART) --bba $(TOP).bba
	bbasm -l $(TOP).bba $(CHIPDB)
	rm -f $(TOP).bba

# PnR emits FASM, not a bitstream config; two more steps turn it into one.
PNR_DEPS ?= $(CHIPDB)
PNR_OUT  ?= $(TOP).frames
PNR_CMD  ?= nextpnr-xilinx --chipdb $(CHIPDB) --xdc $(PCF_FILE) --json $(TOP).json --fasm $(TOP).fasm; \
	fasm2frames --part $(PART) --db-root $${PRJXRAY_DB_DIR}/$(XRAY_FAMILY) $(TOP).fasm > $(PNR_OUT)

BITSTREAM ?= $(TOP).bit
PACK_CMD  ?= xc7frames2bit --part_file $${PRJXRAY_DB_DIR}/$(XRAY_FAMILY)/$(PART)/part.yaml --part_name $(PART) --frm_file $(PNR_OUT) --output_file $(BITSTREAM)
LOAD_CMD  ?= openFPGALoader --board=$(OPENFPGALOADER_BOARD) $(OPENFPGALOADER_FLAGS) $(BITSTREAM)
FLASH_CMD ?= openFPGALoader --board=$(OPENFPGALOADER_BOARD) $(OPENFPGALOADER_FLAGS) --write-flash $(BITSTREAM)

EXTRA_CLEAN ?= $(TOP).fasm

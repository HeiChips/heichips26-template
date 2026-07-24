# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

ARCH         := ice40
ICE40_DEVICE := --up5k --package sg48

# DFU alt 0 is the SPI flash, alt 1 the FPGA's volatile configuration memory.
# Must be `=`, not `:=`, since BITSTREAM is only defined later, by fpga.mk.
LOAD_CMD  = dfu-util --alt 1 --download $(BITSTREAM)
FLASH_CMD = dfu-util --alt 0 --download $(BITSTREAM) --reset

# SPDX-FileCopyrightText: 2026 The HeiChips contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

ARCH         := ice40
ICE40_DEVICE := --up5k --package sg48

# Must be `=`, not `:=`, since BITSTREAM is only defined later, by fpga.mk.
FLASH_CMD = dfu-util --alt 0 --download $(BITSTREAM)

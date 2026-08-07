#!/usr/bin/env python3
"""Generate small RV32E benchmark images without requiring a cross compiler.

The four programs deliberately exercise different instruction working sets:

* ``same_line`` keeps its hot loop inside one 16-byte line;
* ``cross_line`` places one sequential loop across a line boundary;
* ``split_loop`` alternates between two non-adjacent hot instruction lines.
* ``straight_line`` executes an unrolled sequence with no instruction reuse.

All programs compute the value 20 and write the same performance counters to
SRAM, which lets the Cocotb regression compare cache configurations directly.
"""

from pathlib import Path


def _check_signed(value: int, bits: int) -> int:
    minimum = -(1 << (bits - 1))
    maximum = (1 << (bits - 1)) - 1
    if not minimum <= value <= maximum:
        raise ValueError(f"{value} does not fit in signed {bits} bits")
    return value & ((1 << bits) - 1)


def addi(rd: int, rs1: int, imm: int) -> int:
    return (_check_signed(imm, 12) << 20) | (rs1 << 15) | (rd << 7) | 0x13


def lui(rd: int, upper20: int) -> int:
    return ((upper20 & 0xFFFFF) << 12) | (rd << 7) | 0x37


def lw(rd: int, rs1: int, imm: int) -> int:
    return (
        (_check_signed(imm, 12) << 20)
        | (rs1 << 15)
        | (0b010 << 12)
        | (rd << 7)
        | 0x03
    )


def sw(rs2: int, rs1: int, imm: int) -> int:
    encoded = _check_signed(imm, 12)
    return (
        ((encoded >> 5) << 25)
        | (rs2 << 20)
        | (rs1 << 15)
        | (0b010 << 12)
        | ((encoded & 0x1F) << 7)
        | 0x23
    )


def bne(rs1: int, rs2: int, offset: int) -> int:
    if offset & 1:
        raise ValueError("branch offset must be two-byte aligned")
    encoded = _check_signed(offset, 13)
    return (
        (((encoded >> 12) & 1) << 31)
        | (((encoded >> 5) & 0x3F) << 25)
        | (rs2 << 20)
        | (rs1 << 15)
        | (0b001 << 12)
        | (((encoded >> 1) & 0xF) << 8)
        | (((encoded >> 11) & 1) << 7)
        | 0x63
    )


def jal(rd: int, offset: int) -> int:
    if offset & 1:
        raise ValueError("jump offset must be two-byte aligned")
    encoded = _check_signed(offset, 21)
    return (
        (((encoded >> 20) & 1) << 31)
        | (((encoded >> 1) & 0x3FF) << 21)
        | (((encoded >> 11) & 1) << 20)
        | (((encoded >> 12) & 0xFF) << 12)
        | (rd << 7)
        | 0x6F
    )


NOP = addi(0, 0, 0)
EBREAK = 0x0010_0073


def pad_to(words: list[int], byte_address: int) -> None:
    """Append NOPs until the next instruction has ``byte_address``."""

    if byte_address % 4:
        raise ValueError("padding target must be word aligned")
    if len(words) * 4 > byte_address:
        raise ValueError("padding target precedes the current program counter")
    while len(words) * 4 < byte_address:
        words.append(NOP)


def branch_to(words: list[int], rs1: int, rs2: int, target: int) -> int:
    """Encode a BNE at the current PC that branches to ``target``."""

    return bne(rs1, rs2, target - len(words) * 4)


def jump_to(words: list[int], target: int) -> int:
    """Encode an unconditional JAL at the current PC to ``target``."""

    return jal(0, target - len(words) * 4)


def append_report(words: list[int]) -> None:
    """Store the result and hardware counters, then stop the processor."""

    words.extend(
        [
            sw(1, 0, 0x300),     # result
            lui(5, 0x10000),     # MMIO base 0x1000_0000
            addi(10, 0, 1),      # freeze all counters before sampling
            sw(10, 5, 0x1C),
            lw(6, 5, 0x04),      # cycle count
            sw(6, 0, 0x304),
            lw(7, 5, 0x08),      # external instruction fetches
            sw(7, 0, 0x308),
            lw(8, 5, 0x0C),      # buffer hits
            sw(8, 0, 0x30C),
            lw(9, 5, 0x10),      # stall cycles
            sw(9, 0, 0x310),
            lw(10, 5, 0x14),     # issued prefetches
            sw(10, 0, 0x314),
            lw(11, 5, 0x18),     # useful prefetches
            sw(11, 0, 0x318),
            EBREAK,
        ]
    )


def build_same_line() -> list[int]:
    """Reference workload whose loop fits in one aligned cache line."""

    words = [
        addi(1, 0, 0),       # 0x00: result = 0
        addi(2, 0, 20),      # 0x04: 20 loop iterations
        jal(0, 0x08),        # 0x08: jump to aligned loop at 0x10
        NOP,                 # 0x0c
        addi(1, 1, 1),       # 0x10: loop begins
        addi(2, 2, -1),      # 0x14
        bne(2, 0, -0x08),    # 0x18: branch to 0x10
    ]
    append_report(words)
    return words


def build_cross_line() -> list[int]:
    """Loop from 0x0c through 0x14, crossing the 0x10 line boundary."""

    words = [
        addi(1, 0, 0),       # result = 0
        addi(2, 0, 20),      # 20 loop iterations
        NOP,
    ]
    loop_start = len(words) * 4
    words.extend(
        [
            addi(1, 1, 1),
            addi(2, 2, -1),
        ]
    )
    words.append(branch_to(words, 2, 0, loop_start))
    append_report(words)
    return words


def build_split_loop() -> list[int]:
    """Alternate between hot blocks at 0x20 and 0x40."""

    words = [
        addi(1, 0, 0),       # result = 0
        addi(2, 0, 20),      # 20 loop iterations
        addi(3, 0, 0),
    ]
    words.append(jump_to(words, 0x20))

    pad_to(words, 0x20)
    block_a = len(words) * 4
    words.append(addi(1, 1, 1))
    words.append(jump_to(words, 0x40))

    pad_to(words, 0x40)
    words.extend(
        [
            addi(3, 3, 2),
            addi(2, 2, -1),
        ]
    )
    words.append(branch_to(words, 2, 0, block_a))
    append_report(words)
    return words


def build_straight_line() -> list[int]:
    """Unrolled work with no repeated PC, used to evaluate prefetching."""

    words = [addi(1, 0, 0)]
    for _ in range(20):
        words.append(addi(1, 1, 1))
    append_report(words)
    return words


BENCHMARKS = {
    "same_line": build_same_line,
    "cross_line": build_cross_line,
    "split_loop": build_split_loop,
    "straight_line": build_straight_line,
}


def write_image(destination: Path, words: list[int]) -> None:
    lines = [f"{word:08x}" for word in words]
    destination.write_text("\n".join(lines) + "\n", encoding="ascii")
    print(f"Wrote {len(lines)} words to {destination}")


def main() -> None:
    firmware_dir = Path(__file__).resolve().parent
    images = {name: builder() for name, builder in BENCHMARKS.items()}

    for name, words in images.items():
        write_image(firmware_dir / f"loopcache_{name}.hex", words)

    # Preserve the original filename used by the SystemVerilog testbench.
    write_image(firmware_dir / "loopcache_test.hex", images["same_line"])


if __name__ == "__main__":
    main()

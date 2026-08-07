# LoopCache-RV architecture

LoopCache-RV is a minimal RV32E-class SoC for the HeiChips26 Large slot. It
studies how a small instruction loop buffer reduces traffic and stalls when a
RISC-V core fetches code through a narrow eFPGA-to-SRAM link.

## Data path

```mermaid
flowchart LR
    CPU["PicoRV32"] --> FE["Loop buffer + MMIO"]
    FE --> BR["32-to-16-bit bridge"]
    BR --> FPGA["eFPGA endpoint"]
    FPGA --> SRAM["4 KiB SRAM"]
```

The processor and loop buffer are hardened in the user macro. The eFPGA
terminates the packet link and accesses the shared 1024 x 32-bit SRAM. The
synthesizable gateway is provided under `efpga/` and uses the official
`TT_PROJECT_LARGE` and `IHP_SRAM_1024x32_1RW` FABulous primitives.

## Processor configuration

- PicoRV32, reset address `0x0000_0000`
- RV32E-sized register file (`x0`-`x15`)
- no M extension, PCPI, interrupts, trace, or compressed instructions
- two-cycle comparison and ALU options enabled to reduce the critical path
- stack pointer reset address `0x0000_0ff0`

## Loop buffer

The first implementation uses one aligned line containing eight 32-bit
instructions. Each successfully fetched instruction fills one word in the
line. A later instruction request with the same line base and a valid word is
served locally in one cycle.

This deliberately avoids branch prediction and architectural state changes:
the buffer is transparent to software. For immutable code, a hit must return
exactly the word that external SRAM would have returned. An external flush pin
invalidates the complete line.

The benchmark loop is aligned to a 32-byte boundary and fits inside one line.

## Local MMIO registers

| Address | Access | Description |
|---|---|---|
| `0x1000_0000` | R | bit 0 enable, bit 1 flush input |
| `0x1000_0004` | R | cycle counter |
| `0x1000_0008` | R | external instruction fetches |
| `0x1000_000c` | R | loop-buffer hits |
| `0x1000_0010` | R | memory-stall cycles |

MMIO accesses are completed inside the macro and are never sent to the shared
SRAM.

## Evaluation

Run exactly the same firmware twice, once with the buffer bypassed and once
with it enabled. Both runs must produce the same result in SRAM. The enabled
run should issue fewer external instruction fetches and take fewer cycles.

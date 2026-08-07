# LoopFold

LoopFold is a lightweight RISC-V instruction-buffer and prefetching experiment
for the HeiChips 2026 Hackathon.

The project integrates a small PicoRV32 processor with a compact two-line
instruction buffer. Repeated instruction fetches can be served locally instead
of repeatedly accessing the external SRAM. An optional sequential prefetcher
can additionally fetch the next instruction word when sustained sequential
execution is detected.

The design is intended to provide a small and measurable example of reducing
instruction-fetch traffic in resource-constrained RISC-V systems.

* **Project name:** LoopFold
* **ASIC top cell:** `heichips26_loopcache_rv`
* **Macro directory:** `macros/heichips26_loopfold/`
* **Slot size:** Large (`500 µm × 415 µm`)

## Architecture

The ASIC macro contains the following main blocks:

| Block                     | Responsibility                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------ |
| PicoRV32                  | Minimal RISC-V processor executing the benchmark                                           |
| `loopcache_frontend`      | Two-line instruction buffer, adaptive sequential prefetcher, MMIO and performance counters |
| `narrow_mem_bridge`       | Converts 32-bit processor memory accesses into the 16-bit external memory-link protocol    |
| `loopcache_soc`           | Connects the processor, instruction buffer and memory bridge                               |
| `heichips26_loopcache_rv` | HeiChips Large-slot top-level wrapper                                                      |

The instruction buffer has two independently tagged ways with four 32-bit words
per way, giving a total storage capacity of eight instruction words.

On an instruction miss, the request is forwarded to external memory and the
returned instruction is inserted into the local buffer. Later accesses to the
same resident word can be served directly by the buffer.

A small sequential-history detector tracks instruction-fetch behavior. After
sustained sequential execution is observed, the frontend may prefetch the next
instruction word when the external memory interface would otherwise be idle.
Control-flow instructions reset this confidence so that obvious branch
fall-through paths are not unnecessarily prefetched.

The loop buffer and prefetcher can be enabled independently, allowing the same
program to be measured under different configurations.

See [`../../docs/architecture.md`](../../docs/architecture.md) for additional
architectural details and [`../../docs/memory_link.md`](../../docs/memory_link.md)
for the external memory-link protocol.

## HeiChips interface

| Pin                        | Direction | Meaning                                 |
| -------------------------- | --------- | --------------------------------------- |
| `uo_out[15:0]`             | out       | memory request header / write-data beat |
| `ui_in[15:0]`              | in        | memory read-response beat               |
| `uio_out[0]` / `uio_in[0]` | out / in  | request valid / ready                   |
| `uio_in[1]` / `uio_out[1]` | in / out  | response valid / ready                  |
| `uio_in[2]`                | in        | instruction buffer enable               |
| `uio_in[3]`                | in        | synchronous buffer flush                |
| `uio_in[4]`                | in        | sequential prefetch enable              |
| `uio_out[2]`               | out       | PicoRV32 trap                           |
| `uio_out[3]`               | out       | instruction-buffer enable status        |
| `uio_out[15:4]`            | out       | low 12 bits of the buffer-hit counter   |

The memory interface is 16 bits wide. `narrow_mem_bridge` converts the
processor's 32-bit memory operations into the packetized interface used between
the ASIC macro and the HeiChips eFPGA.

## Performance monitoring

The design includes hardware counters for:

* execution cycles,
* external instruction fetches,
* instruction-buffer hits,
* processor memory-stall cycles,
* issued prefetches,
* useful prefetches.

These counters allow normal execution, buffered execution and buffered
execution with prefetching to be compared directly.

The benchmark firmware and generated memory images are stored in
`../../firmware/`.

## RTL verification

Enter the repository Nix environment and change to this directory:

```sh
cd macros/heichips26_loopfold
```

Useful targets are:

```sh
make firmware
make lint-verilog
make synth-check
make sim-rtl-verilog
make sim-rtl-cocotb
```

`make sim-rtl-verilog` runs the self-checking SystemVerilog testbench.

`make sim-rtl-cocotb` runs multiple benchmark scenarios, including same-line
loops, loops spanning both resident lines, sequential-prefetch behavior and a
slower external SRAM model.

## HeiChips eFPGA SRAM gateway

The repository also contains:

```text
../../efpga/loopcache_sram_gateway/
```

This is the FABulous user design used to connect the hardened LoopFold macro to
the HeiChips `IHP_SRAM_1024x32_1RW` SRAM primitive.

The standalone packet-engine test can be run from the repository root with:

```sh
make -C efpga/loopcache_sram_gateway test-core
```

The final eFPGA bitstream is generated in the official HeiChips tapeout
repository after the Large-slot placement has been assigned.

## ASIC physical design

The LibreLane configuration is located at:

```text
flow/librelane/config.yaml
```

The macro uses the official HeiChips Large-slot floorplan:

```text
500 µm × 415 µm
```

The current physical-design configuration targets a 10 ns clock period and
uses Metal4 as the highest routing layer.

Run the complete hardening flow with:

```sh
make build-top
```

The collected outputs are organized as:

```text
final/         final GDS, LEF, timing libraries and other views
verification/  synthesis, STA, DRC, LVS, antenna and sign-off reports
netlist/       logical, physical and SPICE netlists
```

A gate-level regression can subsequently be run with:

```sh
make sim-gl-cocotb
```

## FPGA demonstration

An independent FPGA demonstration is available under:

```text
../../fpga/davinci_a35t/
```

The DaVinci XC7A35T project reuses `loopcache_soc` and adds a local BRAM
backend, UART reporting and board-level controls.

This provides a way to exercise the same architecture on real FPGA hardware
before ASIC fabrication.

See `../../fpga/davinci_a35t/README.md` for the board-specific build and test
instructions.

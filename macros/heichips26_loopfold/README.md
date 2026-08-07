# heichips26_loopcache_rv

This directory is the synthesizable HeiChips26 Large-slot macro. Its top cell
is `heichips26_loopcache_rv`; there are no separately hardened sub-macros.

## Hardware blocks

| Block | Responsibility |
|---|---|
| PicoRV32 | minimal RV32E-class processor |
| `loopcache_frontend` | 8 × 32-bit instruction line, MMIO and counters |
| `narrow_mem_bridge` | converts 32-bit CPU requests into 16-bit packets |
| top wrapper | maps the link, control and debug signals to HeiChips pins |

The first implementation is intentionally measurable: it accelerates an
aligned loop that fits in a 32-byte line. It does not claim to be a general
set-associative instruction cache.

## Pin assignment

| Pin | Direction | Meaning |
|---|---|---|
| `uo_out[15:0]` | out | request header/write-data beat |
| `ui_in[15:0]` | in | read-response beat |
| `uio_out[0]` / `uio_in[0]` | out/in | request valid/ready |
| `uio_in[1]` / `uio_out[1]` | in/out | response valid/ready |
| `uio_in[2]` | in | loop buffer enable |
| `uio_in[3]` | in | synchronous flush |
| `uio_out[2]` | out | processor trap |
| `uio_out[3]` | out | enable status |
| `uio_out[15:4]` | out | low 12 bits of hit counter |

See [`../../docs/memory_link.md`](../../docs/memory_link.md) for the packet
format and [`../../docs/architecture.md`](../../docs/architecture.md) for the
microarchitecture.

## Useful commands

Run these commands in this directory after entering the repository Nix shell:

```sh
make firmware          # regenerate firmware/loopcache_test.hex
make lint-verilog      # structural and style checks
make synth-check       # technology-independent synthesis
make sim-rtl-verilog   # fast self-checking RTL test
make sim-rtl-cocotb    # compare cache OFF against cache ON
make build-top         # full LibreLane implementation and result collection
make sim-gl-cocotb     # generated-netlist regression
```

`make all` runs firmware generation, lint, both RTL simulations, and the full
physical-design flow. During development it is faster to run the smaller
targets individually.

## Benchmark result locations

The firmware stores the following words in the shared SRAM:

| Byte address | Value |
|---|---|
| `0x300` | computed result, expected `20` |
| `0x304` | elapsed cycles |
| `0x308` | external instruction fetches |
| `0x30c` | loop-buffer hits |
| `0x310` | CPU memory-stall cycles |

## Physical design

`flow/librelane/config.yaml` selects the official `500 µm × 415 µm` Large DEF
template, a 10 ns target clock, Metal4 as the top routing layer, and no power
ring/TopMetal1 use. Generated final views belong in `final/`, reports in
`verification/`, and copied netlists in `netlist/`.

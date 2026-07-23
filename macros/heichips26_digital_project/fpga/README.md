# FPGA Emulation Flow

This directory holds the FPGA emulation flow for this project's **top-level
design** (`heichips26_digital_project`, defined in
`../rtl/heichips26_digital_project.sv`), across several boards. Each board wraps it
in a `<board>_top.sv` that maps board pins to the TinyTapeout-style
`ui_in`/`uo_out`/`uio_*`/`ena`/`clk`/`rst_n` interface.

> [!NOTE]
> To emulate a single macro on its own (e.g. `counter`, without the
> top-level wrapper), see `../macros/counter/fpga/`. Both flows share the
> same recipe logic from `fpga.mk` — see below.

| Board       | Directory       | Toolchain                              | Status                     |
|-------------|-----------------|-----------------------------------------|----------------------------|
| iCEBreaker  | `fpga/icebreaker/` | Yosys → nextpnr-ice40 → icepack      | Build verified, flash untested |
| ULX3S       | `fpga/ulx3s/`   | Yosys → nextpnr-ecp5 → ecppack          | Tested, hardware flash-verified, default |
| Tang Nano 9K| `fpga/nano9k/`  | Yosys → nextpnr-himbaechel → gowin_pack | Build verified, flash untested |
| Basys 3     | `fpga/basys3/`  | Yosys → nextpnr-xilinx → prjxray (`nix-openxc7`) | Tested, hardware flash-verified |
| Boolean     | `fpga/boolean/` | Yosys → nextpnr-xilinx → prjxray (`nix-openxc7`) | Build verified, flash untested |
| pico-ice    | `fpga/pico-ice/` | Yosys → nextpnr-ice40 → icepack         | Build verified, flash untested |

All boards need `verilator` and `yosys`; the iCE40/ECP5/Gowin boards additionally need
`nextpnr-ice40`/`nextpnr-ecp5`/`nextpnr-himbaechel`, `icepack`/`ecppack`/
`gowin_pack`, and `openFPGALoader` — all provided by this repo's main Nix flake
(`nix develop`). Basys 3 and Boolean instead need `nextpnr-xilinx` + `prjxray`,
which come from a **separate** nix shell vendored at the repo root
(`nix-openxc7/`), not the main flake. From `fpga/`, enter it with:

```sh
nix develop ../../../nix-openxc7
```

Once inside, they build like any other board (`make -C basys3 all`, etc.).

## Shared flow: `fpga.mk`

`fpga.mk` implements the whole flow (lint, synthesis, place-and-route,
bitstream, flash) as targets parametrized by variables, split across four
layers:

- `fpga.mk` — the targets themselves, plus defaults common to all boards
- `arch/<arch>.mk` — one per FPGA architecture (`ice40`, `ecp5`, `gowin`,
  `xilinx7`): the synthesis, place-and-route and packing toolchain
- `boards/<board>.mk` — one per board: device, package, and how to flash
- `dut.mk` — one per DUT tree (this directory vs. `macros/counter/fpga/`):
  the RTL under test, shared by every board's `Makefile` in that tree

A board directory's `Makefile` is thin. It includes `dut.mk` for the DUT
sources, names the board top wrapper and the pin file, then includes its
`boards/` fragment and `fpga.mk`, which in turn pulls in the `arch/`
fragment named by the board's `ARCH`:

```make
TOP := counter

include ../dut.mk
MODULES_SYNTH := $(DUT_SRCS)

PCF_FILE := icebreaker.pcf

include ../../../../fpga/boards/icebreaker.mk
include ../../../../fpga/fpga.mk
```

### Set by `dut.mk`

| Variable | | Description |
|---|---|---|
| `SRC_DIR` | mandatory | RTL source directory |
| `DUT_SRCS` | mandatory | Ordered source file list for the design under test, without the board top wrapper |

### Set by the board `Makefile`

| Variable | | Description |
|---|---|---|
| `TOP` | mandatory | Synthesis top module / instance name |
| `MODULES_SYNTH` | mandatory | Ordered source file list for `TOP` — usually `$(DUT_SRCS)` plus the board's `<board>_top.sv` wrapper |
| `PCF_FILE` | mandatory | Board pin constraint file |
| `MODULES_LINT` | optional | Sources for `lint-verilog` (default: `MODULES_SYNTH`). Narrow it to exclude files Verilator can't lint, e.g. a wrapper instantiating a vendor PLL |

### Set by `boards/<board>.mk`

| Variable | | Description |
|---|---|---|
| `ARCH` | mandatory | Selects the `arch/<arch>.mk` fragment |
| `ICE40_DEVICE`, `ECP5_DEVICE`, `GOWIN_DEVICE`/`GOWIN_FAMILY`, `PART` | mandatory | Device and package, whichever the board's arch uses |
| `CHIPDB`, `XRAY_FAMILY` | mandatory | `xilinx7` only |
| `OPENFPGALOADER_BOARD` | mandatory | openFPGALoader board profile, unless `FLASH_CMD` is set instead |
| `OPENFPGALOADER_FLAGS` | optional | Extra openFPGALoader flags |
| `FLASH_CMD` | optional | Complete flash command, replacing the openFPGALoader default, for boards it has no profile for |

### Set by `arch/<arch>.mk`

| Variable | | Description |
|---|---|---|
| `TARGET`, `SYNTH_OPTS` | mandatory | Yosys synth pass and its options |
| `SYNTH_CMD` | optional | Complete synthesis command, replacing `TARGET`/`SYNTH_OPTS`, for a synth pass that doesn't fit the `$(TARGET) $(SYNTH_OPTS) -top $(TOP)` shape (e.g. `synth_xilinx`) |
| `PNR_CMD`, `PNR_OUT` | mandatory | Place-and-route command and its output file |
| `PNR_ARGS`, `PNR_GUI_CMD`, `PNR_DEPS` | optional | PnR flags, GUI variant, and extra prerequisites (e.g. a generated chipdb) |
| `PACK_CMD`, `BITSTREAM` | mandatory | Bitstream packing command and output file |
| `EXTRA_CLEAN` | optional | Extra generated files for `clean` to remove |

Both fragments assign with `?=` throughout, so a board `Makefile` can still
override anything.

### Adding a board

- Create `boards/<board>.mk`, setting `ARCH` and the device, package, and
  flash variables above.
- Create the board directory: its `Makefile` (`include ../dut.mk`, `TOP`,
  `MODULES_SYNTH`, and `PCF_FILE`, then the two remaining `include`s), the
  pin constraint file it names, and a `<board>_top.sv` wrapper mapping
  board pins to the TinyTapeout-style interface.
- If the board's FPGA family is new, also create `arch/<arch>.mk` with that
  family's synthesis, place-and-route, and packing toolchain.

`fpga.mk` itself does not change.

## Picking a board

`fpga/Makefile` is a thin dispatcher — it forwards every target to
`fpga/$(BOARD)/Makefile`, defaulting to `BOARD := ulx3s`:

```make
BOARD ?= ulx3s
%:
	$(MAKE) -C $(BOARD) $@
```

So from `fpga/` you can either run the default board directly...

```sh
make all              # ulx3s
```

...or pick another board with `BOARD=`, or `cd` into its directory —
both are equivalent:

```sh
make BOARD=icebreaker all
make -C icebreaker all
```

`heichips26_digital_project` instantiates the `counter` macro directly, so
each board's `MODULES_SYNTH` pulls in
`../../macros/counter/rtl/counter.sv` alongside
`../../rtl/heichips26_digital_project.sv` — FPGA synthesis needs the full RTL
hierarchy, unlike the ASIC LibreLane flow, which blackboxes `counter` as a
separately hardened macro.

The default board is a **ULX3S** (ECP5, open-source toolchain: Yosys →
nextpnr-ecp5 → ecppack, flashed with openFPGALoader). `ulx3s_top.sv`
wraps `heichips26_digital_project` and maps board pins to the
TinyTapeout-style interface: the FIRE1/F1 button drives `ui_in[0]` (the
design's enable input, hold to run), J1 header `gp[7:1]` carries the
rest of `ui_in`, J1 header `gn[7:0]` is the bidirectional `uio`, the
onboard LEDs mirror `uo_out`, and `BTN_PWRn` is `rst_n`.

## Show Available Targets

The default Make target is `help`, so running `make` prints usage and all
available targets with short descriptions.

```sh
make
make help
```


## Clean

Remove generated files:

```sh
make clean
```


## Lint

Run Verilator lint over the full design hierarchy:

```sh
make lint-verilog
```

To lint a subset, narrow `MODULES_LINT` in the board `Makefile`.


## Synthesis

Run technology-mapped synthesis for the board's FPGA architecture (the
Yosys `synth_*` pass comes from its `arch/<arch>.mk`):

```sh
make synthesis
```

Generate a generic synthesis netlist and Yosys graph:

```sh
make synthesis_generic
```


## Place-and-Route

Run place-and-route with nextpnr:

```sh
make pr
```

Run place-and-route in GUI mode:

```sh
make pr-gui
```


## Bitstream Generation and Flash

Generate a bitstream:

```sh
make gen_bitstream
```

Flash the generated bitstream:

```sh
make flash_bitstream
```

> [!NOTE]
> `flash_bitstream` is intentionally not part of `make all`.
> Use `make flash_bitstream` explicitly when you want to program the FPGA.
> Each board's Makefile sets `FLASH_CMD` to whatever that board needs:
> `openFPGALoader` for most boards, `iceprog -S` for the iCEBreaker
> (SRAM load — `openFPGALoader` has no dedicated iCEBreaker board
> profile), and `dfu-util` for the pico-ice, which has no
> `openFPGALoader` profile either.


## Convert to Verilog

Convert the SystemVerilog top module to Verilog:

```sh
make convert
```


## Build All

Run the full FPGA flow target from the Makefile:

```sh
make all
```

The current `all` recipe executes these steps in order:

1. `make clean`
2. `make lint-verilog`
3. `make synthesis`
4. `make pr`
5. `make gen_bitstream`

This ensures stale artifacts from previous runs are removed before a fresh
build.

> [!NOTE]
> `make all` intentionally stops after bitstream generation and does not
> call `flash_bitstream`.

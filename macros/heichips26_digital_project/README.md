# Heichips26 Digital Project (ihp-sg13cmos5l)

<p align="center">
  <a href="final/render/heichips26_digital_project.png">
    <img src="final/render/heichips26_digital_project.png" alt="Render of the ihp-sg13cmos5l heichips26_digital_project layout" width=50%>
  </a>
  <br>
  <em>Render of the ihp-sg13cmos5l heichips26_digital_project layout.</em>
</p>


## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 heichips26_digital_project/
├─ 📁 final/
│  ├─ 📁 gds/
│  │  └─ heichips26_digital_project.gds
│  ├─ 📁 lef/
│  │  └─ heichips26_digital_project.lef
│  ├─ 📁 lib/
│  │  ├─ 📁 nom_fast_1p32V_m40C/
│  │  ├─ 📁 nom_slow_1p08V_125C/
│  │  └─ 📁 nom_typ_1p20V_25C/
│  ├─ 📁 nl/
│  │  └─ heichips26_digital_project.nl.v
│  ├─ 📁 pnl/
│  │  └─ heichips26_digital_project.pnl.v
│  ├─ 📁 render/
│  │  └─ heichips26_digital_project.png
│  ├─ 📁 spef/
│  │  └─ 📁 nom/
│  └─ 📁 vh/
│     └─ heichips26_digital_project.vh
├─ 📁 flow/
│  ├─ 📁 final/               # .gitignore'd — important files are copied to heichips26_digital_project/final/ (listed here to document LibreLane output folders)
│  │  ├─ 📁 def/              # Design Exchange Format — cell placement & routing (text-based)
│  │  ├─ 📁 gds/              # GDSII layout — final tape-out file
│  │  ├─ 📁 json_h/           # Yosys JSON headers — machine-readable netlist for internal scripts
│  │  ├─ 📁 klayout_gds/      # KLayout GDS — with extra visual-debug metadata
│  │  ├─ 📁 lef/              # Library Exchange Format — abstract pin & blockage view for P&R
│  │  ├─ 📁 lib/              # Liberty timing files — timing, power & area models
│  │  ├─ 📁 mag/              # Magic layout files — used for DRC & GDS generation
│  │  ├─ 📁 mag_gds/          # GDS generated/processed by Magic
│  │  ├─ 📁 nl/               # Netlist — gate-level Verilog after synthesis
│  │  ├─ 📁 odb/              # OpenDB — internal OpenROAD binary database (LEF+DEF combined)
│  │  ├─ 📁 pnl/              # Powered Netlist — gate-level Verilog with explicit VDD/VSS (for LVS)
│  │  ├─ 📁 render/           # Layout render images
│  │  ├─ 📁 sdc/              # Synopsys Design Constraints — clock periods & timing requirements
│  │  ├─ 📁 sdf/              # Standard Delay Format — timing delays for gate-level simulation
│  │  ├─ 📁 spef/             # Standard Parasitic Exchange Format — RC parasitics from layout
│  │  ├─ 📁 spice/            # SPICE netlist — for LVS & transistor-level simulation
│  │  ├─ 📁 vh/               # Verilog headers — for hierarchy management & simulation inclusion
│  │  ├─ metrics.csv          # Design metrics (area, power, timing slack, DRC/LVS) — spreadsheet
│  │  └─ metrics.json         # Design metrics (area, power, timing slack, DRC/LVS) — JSON summary
│  ├─ 📁 librelane/
│  │  ├─ config.yaml
│  │  ├─ impl.sdc
│  │  ├─ pin_order.cfg
│  │  └─ signoff.sdc
├─ 📁 fpga/
│  ├─ 📁 arch/
│  │  ├─ ecp5.mk
│  │  ├─ gowin.mk
│  │  ├─ ice40.mk
│  │  └─ xilinx7.mk
│  ├─ 📁 basys3/
│  │  ├─ Basys-3-Master.xdc
│  │  ├─ basys3_top.sv
│  │  └─ Makefile
│  ├─ 📁 boards/
│  │  ├─ basys3.mk
│  │  ├─ boolean.mk
│  │  ├─ icebreaker.mk
│  │  ├─ nano9k.mk
│  │  ├─ pico-ice.mk
│  │  └─ ulx3s.mk
│  ├─ 📁 boolean/
│  │  ├─ boolean.xdc
│  │  ├─ boolean_top.sv
│  │  └─ Makefile
│  ├─ 📁 icebreaker/
│  │  ├─ icebreaker.pcf
│  │  ├─ icebreaker_top.sv
│  │  └─ Makefile
│  ├─ 📁 nano9k/
│  │  ├─ Makefile
│  │  ├─ nano9k.cst
│  │  └─ nano9k_top.sv
│  ├─ 📁 pico-ice/
│  │  ├─ Makefile
│  │  ├─ pico-ice.pcf
│  │  └─ pico_ice_top.sv
│  ├─ 📁 ulx3s/
│  │  ├─ Makefile
│  │  ├─ ulx3s_top.sv
│  │  └─ ulx3s_v20.lpf
│  ├─ dut.mk
│  ├─ fpga.mk
│  ├─ Makefile
│  └─ README.md
├─ 📁 netlist/
│  ├─ 📁 nl/
│  │  └─ heichips26_digital_project.nl.v
│  ├─ 📁 pnl/
│  │  └─ heichips26_digital_project.pnl.v
│  ├─ 📁 spice/
│  │  └─ heichips26_digital_project.spice
│  └─ 📁 xspice/
│     └─ heichips26_digital_project.xspice
├─ 📁 rtl/
│  └─ heichips26_digital_project.sv
├─ 📁 schematic/
│  └─ 📁 xschem/
│     ├─ heichips26_digital_project.sym
│     └─ xschemrc
├─ 📁 scripts/
│  ├─ lay2img.py
│  ├─ reorder_xspice_pins.py
│  ├─ spi2xspice.py
│  └─ 📁 plot_simulations/
│     ├─ ngspice2python.py
│     └─ plot_heichips26_digital_project.py
├─ 📁 testbenches/
│  ├─ 📁 cocotb/
│  │  ├─ heichips26_digital_project_tb.gtkw
│  │  └─ heichips26_digital_project_tb.py
│  ├─ 📁 verilog/
│  │  ├─ heichips26_digital_project_tb.gtkw
│  │  └─ heichips26_digital_project_tb.sv
│  └─ 📁 xschem/
│     ├─ heichips26_digital_project_tb_tran.sch
│     └─ xschemrc
├─ 📁 verification/
│  ├─ antenna_summary.rpt
│  ├─ antenna_violations.rpt
│  ├─ stapostpnr_summary.rpt
│  ├─ stapostpnr_nom_fast_1p32V_m40C_power.rpt
│  ├─ stapostpnr_nom_slow_1p08V_125C_power.rpt
│  ├─ stapostpnr_nom_typ_1p20V_25C_power.rpt
│  ├─ irdrop.rpt
│  ├─ drc.magic.rpt
│  ├─ drc.klayout.json
│  ├─ lvs.netgen.rpt
│  ├─ manufacturability.rpt
│  ├─ stat.rpt
│  ├─ yosys_post_dff.rpt
│  ├─ yosys_pre_techmap.rpt
│  └─ yosys_synth_check.rpt
├─ Makefile
└─ README.md
```

</details>

## Show Available Targets

The default Make target is `help`, so running `make` prints usage and all available targets with short descriptions.

```sh
make
make help
```


## Linting

To lint the Verilog/SystemVerilog source files with [Verilator](https://www.veripool.org/verilator/), run:

```sh
make lint-verilog                # lint the full heichips26_digital_project design
make lint-verilog CELL=heichips26_digital_project   # lint the standalone heichips26_digital_project cell
make lint-verilog-all            # lint heichips26_digital_project and heichips26_digital_project in sequence
```

When `CELL=heichips26_digital_project` (the default), all synthesis sources (`constants.sv`, `heichips26_digital_project.sv`, `heichips26_digital_project.sv`) are passed to Verilator.
For a single cell, `constants.sv` is always included first so the shared `` `COUNTER_MAX_DEFAULT `` and `` `CLK_FREQ_DEFAULT `` macros are in scope.

The `lint-verilog-all` target runs these lint checks in sequence:

1. `make lint-verilog CELL=heichips26_digital_project`
2. `make lint-verilog` (default: `heichips26_digital_project`)

This is also the lint step used by `make all`.


## Verification and Simulation

We use [cocotb](https://www.cocotb.org/), a Python-based testbench environment, and [Icarus Verilog](https://github.com/steveicarus/iverilog) for the verification of the macro.

The simulation targets are unified and accept an optional `CELL` variable (default: `heichips26_digital_project`).
The waveform viewer can be changed with `WAVEFORM_VIEWER=<gtkwave|surfer>` (default: `gtkwave`).

> [!NOTE]
> In the current repository state, the provided Verilog, cocotb, and Xschem testbench/viewer files are for `heichips26_digital_project`.
> Running simulation/view targets with another `CELL` requires corresponding testbench files (for example, `testbenches/verilog/<CELL>_tb.*`, `testbenches/cocotb/<CELL>_tb.py`, and `testbenches/xschem/<CELL>_tb_tran.sch`).

### RTL Verilog Simulation

Compiles the RTL with Icarus Verilog and runs the simulation.
When `CELL=heichips26_digital_project` (the default), the full `MODULES_SIM` source list and the `.sv` testbench are selected automatically.
For non-top cells, `constants.sv` is included first (so the shared `` `COUNTER_MAX_DEFAULT `` / `` `CLK_FREQ_DEFAULT `` macros are in scope) and the RTL source is auto-selected as `rtl/<CELL>.sv` when present, otherwise `rtl/<CELL>.v`.
The waveform is written to `testbenches/verilog/` (e.g. `testbenches/verilog/heichips26_digital_project_tb.vcd`):

```sh
make sim-rtl-verilog              # run heichips26_digital_project RTL simulation
```

To view the waveform afterwards:

```sh
make sim-view-verilog                                  # view heichips26_digital_project waveform
make sim-view-verilog WAVEFORM_VIEWER=surfer           # use Surfer instead
```

The simulation folder contains a pre-configured waveform layout file (`heichips26_digital_project_tb.gtkw` for GTKWave, `heichips26_digital_project_tb.surf.ron` for Surfer).
The view target loads it automatically together with the current `.vcd`, so signal formatting is preserved across runs.

### RTL / GL cocotb Simulation

The cocotb testbench is located in `testbenches/cocotb/heichips26_digital_project_tb.py` and exercises:

- reset clears the heichips26_digital_project to 0
- the heichips26_digital_project holds its value while `enable_i` is low
- the heichips26_digital_project increments by 1 on every rising clock edge while `enable_i` is high
- the heichips26_digital_project wraps from `CTR_MAX` back to 0

```sh
make sim-rtl-cocotb               # run heichips26_digital_project RTL cocotb simulation
```

To run the gate-level (GL) cocotb simulation (sources the post-synthesis netlist from `final/nl/`):

```sh
make sim-gl-cocotb                # gate-level simulation of heichips26_digital_project
```

> [!NOTE]
> Gate-level simulation requires the latest implementation in `flow/final/` (and a `final/nl/heichips26_digital_project.nl.v` copy via `make copy-final`).

A waveform file is generated under `testbenches/cocotb/sim_build/heichips26_digital_project.fst`.
To view it:

```sh
make sim-view-cocotb                                  # view heichips26_digital_project waveform
make sim-view-cocotb WAVEFORM_VIEWER=surfer           # use Surfer instead
```

The cocotb folder contains a pre-configured waveform layout file (`heichips26_digital_project_tb.gtkw` for GTKWave, `heichips26_digital_project_tb.surf.ron` for Surfer).
The view target loads it automatically together with the current `.fst`, so signal formatting is preserved across runs.

### Gate-Level Xschem Simulation

Runs the mixed-signal gate-level transient simulation testbench in `testbenches/xschem/<CELL>_tb_tran.sch`:

```sh
make sim-gl-xschem                # run heichips26_digital_project gate-level Xschem simulation
make sim-gl-xschem CELL=<cell>    # run gate-level Xschem simulation for another cell
```

> [!NOTE]
> This flow expects the generated XSPICE model in `netlist/xspice/`. If needed, generate it first with:
>
> ```sh
> make generate-xspice
> ```

### View Xschem Simulation Results

After the gate-level Xschem simulation has completed, plot the results with:

```sh
make sim-view-xschem              # plot heichips26_digital_project simulation results
make sim-view-xschem CELL=<cell>  # plot results for another cell
```

This runs `scripts/plot_simulations/plot_<CELL>.py` and exports the figures and a CSV to `scripts/plot_simulations/figures/`.

> [!NOTE]
> `sim-view-xschem` is intentionally **not** called by `sim-all`. It opens an interactive plot window and must be called manually after the simulation has completed.

### Run All Simulations

To run all simulation targets in sequence:

```sh
make sim-all
```

This executes the following targets in order:

1. `sim-rtl-verilog` (default: `heichips26_digital_project`)
2. `sim-rtl-cocotb` (default: `heichips26_digital_project`)
3. `sim-gl-cocotb` (default: `heichips26_digital_project`)
4. `sim-gl-xschem` (default: `heichips26_digital_project`)

> [!NOTE]
> The `sim-view-verilog` and `sim-view-cocotb` targets are intentionally **not** called by `sim-all`.
> Both open a waveform viewer GUI (GTKWave or Surfer), which blocks the shell until the window is closed.
> They are designed for interactive use and must be called manually after the simulation has completed.


## LibreLane Flow

Run the LibreLane flow with:

```sh
make librelane
```

Additional targets are available for different DRC configurations:

- `make librelane-nodrc` – run LibreLane without DRC checks
- `make librelane-magicdrc` – run LibreLane with only Magic DRC checks
- `make librelane-klayoutdrc` – run LibreLane with only KLayout DRC checks

After the LibreLane flow completes successfully, the generated views are saved under `flow/final/`. `flow/final/` is included in `.gitignore`.


## View the Design

After completion, you can view the design using the OpenROAD GUI:

```sh
make librelane-openroad
```

Or using KLayout:

```sh
make librelane-klayout
```


## Copy Important Reports

To copy the yosys synthesis checks, antenna reports, post-PnR timing summary, per-corner power reports, IR-drop report, Magic/KLayout DRC results, LVS report, and manufacturability report from the latest run into `verification/`, run:

```sh
make copy-reports
```

This only works if at least one LibreLane run exists in `flow/librelane/runs/` and the latest run completed without errors.


## Copy the Final Folders

To copy the latest GDS, LEF, LIB, NL, PNL, SPEF, and VH from `flow/final/` into `final/`, run:

```sh
make copy-final
```

This assumes the final folders exist under `flow/final/` after a successful LibreLane run.


## Copy the Final Netlist

To copy the latest SPICE, PnL, and Netlist files from `flow/final/` into `netlist/`, run:

```sh
make copy-netlist
```

This only works if the required final views exist in `flow/final/spice/`, `flow/final/pnl/`, and `flow/final/nl/`.


## Build FPGA

There are two default FPGA emulation flows, sharing the same recipe logic from `fpga/fpga.mk`:

- **Top-level (whole chip)** — `fpga/`, targets a [ULX3S](https://radiona.org/ulx3s/) board (ECP5, Yosys → nextpnr-ecp5 → ecppack), flashed with `openFPGALoader`.
- **Macro-level (`counter` standalone)** — `macros/counter/fpga/`, also targets a ULX3S by default, wired directly to `counter`'s native ports (no chip-level wrapper).

Both flows can also target other boards, each with its own thin Makefile reusing `fpga/fpga.mk` — see `fpga/README.md` for the full board matrix (iCEBreaker, Tang Nano 9K, pico-ice, and, via the separate `nix-openxc7` Xilinx toolchain vendored at the repo root, Basys 3/Boolean).

To run the full top-level flow (lint → synthesis → place-and-route → bitstream), run:

```sh
make build-fpga
```

This invokes `make -C fpga all`. Individual steps can also be run from `fpga/` (or `macros/counter/fpga/` for the macro-level flow, or e.g. `fpga/design/icebreaker/` for another board):

```sh
make -C fpga synthesis       # Yosys ECP5 synthesis
make -C fpga pr              # nextpnr place-and-route
make -C fpga gen_bitstream   # ecppack → .bit
make -C fpga flash_bitstream # flash via openFPGALoader
```

The counter macro can be built and flashed the same way from `macros/counter/`:

```sh
make -C macros/counter build-fpga
```

> [!NOTE]
> Flashing differs per board/toolchain — each Makefile sets `FLASH_CMD` accordingly. The default ULX3S flow and most other boards use `openFPGALoader`; pico-ice uses `dfu-util` instead, since its RP2040 co-processor acts as a USB DFU bootloader that `openFPGALoader`/`iceprog` don't speak to directly.

See `fpga/README.md` for the full shared-flow reference (variables, targets, adding a new board or macro).


## Build Top

To build the macro with LibreLane, copy its reports, copy final folders, copy netlists, copy the render, and render the final GDS, run:

```sh
make build-top
```


## Layout Versus Schematic (LVS) & Design Rule Check (DRC)

The LibreLane flow already includes LVS and DRC checks with Magic and KLayout, and they are saved in the `verification/` folder.


## Build and Verify All

Builds and verifies the whole macro by running both simulation and build steps:

- `lint-verilog-all`
- `sim-all`
- `build-fpga`
- `build-top`

The LVS and DRC verification is done within the LibreLane flow.

```sh
make all
```


## Generate XSPICE File

To generate an XSPICE file of the macro for mixed-signal simulation in Xschem, run:

```sh
make generate-xspice
```

> [!NOTE]
> This command should not be run as part of `all`, since this XSPICE file is generated once with specific CPU settings for a more convenient simulation.
> This method does not work with the `.pnl.v` file in `flow/final/`. The `.nl.v` file from the LibreLane step `yosys-synthesis` must be used.
> Pin reordering uses the symbol file in `schematic/xschem/<TOP>.sym`.
> Conversion pipeline: Copy gate-level Verilog (`.nl.v`) → Verilog with power pins (`.vp`) → SPICE (`.spice`) → XSPICE (`.xspice`) → Reorder pins in XSPICE file according to the Xschem symbol.

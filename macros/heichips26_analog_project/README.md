# HeiChips26 Analog Project (ihp-sg13cmos5l)

<p align="center">
  <a href="final/render/heichips26_analog_project_white.png">
    <img src="final/render/heichips26_analog_project_white.png" alt="Render of the ihp-sg13cmos5l heichips26_analog_project `tiny` layout (200um x 200um)" width=70%>
  </a>
  <br>
  <em>Render of the ihp-sg13cmos5l heichips26_analog_project `tiny` layout (200um x 200um).</em>
</p>

This is the analog-on-top example project for the HeiChips 2026 Hackathon: the top level `heichips26_analog_project` is drawn **by hand** in KLayout, based on one of the floorplan templates in `floorplan/`. Like the digital project, it uses a **recursive macro structure**: the top level embeds the [`inverter`](macros/inverter/README.md) sub-macro, which shows the complete analog design flow (schematic → simulation → layout → DRC/LVS/PEX → post-layout simulation → characterization).

> [!IMPORTANT]
> You must rename `heichips26_analog_project` to a unique name starting with `heichips26_` and edit `submission.yaml` in the repository root.

For an analog-on-top submission, `submission.yaml` needs your macro name and the analog artifact paths, for example:

```yaml
top-cell: "heichips26_yourname"
slot-size: tiny # this example fits the tiny slot
analog-pins: 3  # number of used analog pins (0-3)
gds-path: macros/heichips26_yourname/final/gds/*.gds
lef-path: macros/heichips26_yourname/final/lef/*.lef
header-path: macros/heichips26_yourname/final/vh/*.vh
```


## Directory Structure

<details>
<summary>Show Directory Structure</summary>

```text
📁 heichips26_analog_project/
├─ 📁 final/
│  ├─ 📁 gds/
│  │  └─ heichips26_analog_project.gds
│  ├─ 📁 lef/
│  │  └─ heichips26_analog_project.lef
│  ├─ 📁 lib/
│  │  └─ heichips26_analog_project.lib
│  ├─ 📁 render/
│  │  ├─ heichips26_analog_project_black.png
│  │  └─ heichips26_analog_project_white.png
│  └─ 📁 vh/
│     └─ heichips26_analog_project.vh
├─ 📁 floorplan/
│  ├─ heichips26_template_small.gds          # 500µm × 200µm slot
│  ├─ heichips26_template_small_analog.gds   # 500µm × 200µm slot + 3 analog pins
│  ├─ heichips26_template_tiny.gds           # 200µm × 200µm slot
│  └─ heichips26_template_tiny_analog.gds    # 200µm × 200µm slot + 3 analog pins
├─ 📁 layout/
│  ├─ heichips26_analog_project.gds
│  ├─ heichips26_analog_project.klay.gds
│  └─ heichips26_analog_project.klay.klib
├─ 📁 macros/
│  └─ 📁 inverter/                           # analog example sub-macro (own Makefile & README)
├─ 📁 netlist/
│  ├─ 📁 layout/
│  │  ├─ *.cir                                # KLayout LVS extracted netlists
│  │  └─ *.ext.spc                            # Magic LVS extracted netlists
│  ├─ 📁 pex/
│  │  └─ *_magic_pex_*.spice
│  └─ 📁 schematic/
│     ├─ *.cdl                                # Xschem CDL netlists (KLayout LVS)
│     └─ *.spice                              # Xschem SPICE netlists (Magic + Netgen LVS)
├─ 📁 schematic/
│  └─ 📁 xschem/
│     ├─ heichips26_analog_project.sch
│     ├─ heichips26_analog_project.sym
│     ├─ heichips26_analog_project_pex.sym
│     └─ xschemrc
├─ 📁 scripts/
│  ├─ check_pex_ports.py
│  ├─ lay2img.py
│  ├─ sak-drc.sh
│  ├─ sak-lvs.sh
│  ├─ sak-pex.sh
│  ├─ sak-pin-reorder.py
│  └─ .sak-scripts-version
├─ 📁 testbenches/
│  └─ 📁 xschem/
│     ├─ 📁 plot_simulations/
│     │  ├─ 📁 data/
│     │  ├─ 📁 figures/
│     │  ├─ ngspice2python.py
│     │  └─ plot_heichips26_analog_project.py
│     ├─ heichips26_analog_project_tb_tran.sch
│     ├─ heichips26_analog_project_tb_tran.save
│     └─ xschemrc
├─ 📁 verification/
│  ├─ 📁 drc/
│  │  ├─ 📁 <cell>.klayout.drc/
│  │  └─ 📁 <cell>.magic.drc/
│  └─ 📁 lvs/
│     ├─ 📁 <cell>.klayout.lvs/
│     └─ 📁 <cell>.magic.lvs/
├─ Makefile
└─ README.md
```

</details>


## Recursive Macro Structure

Exactly like `heichips26_digital_project` embeds the `counter` sub-macro, this project embeds the `inverter` sub-macro in `macros/inverter/`, and each level has its own Makefile with the same targets:

- **Top level (`heichips26_analog_project`)** — the hand-drawn submission macro. Its layout instantiates the `inverter` cells. Its Makefile verifies and builds the **top cell only** (`CELL` defaults to `heichips26_analog_project`).
- **Sub-macro (`macros/inverter/`)** — the complete flow reference for the unit `inverter` cell (`TOP = inverter`), including sizing notebooks and CACE characterization.

**Build order matters**: if you modify the inverter, run its own flow first (`make -C macros/inverter all`, or equivalently `make build-inverter` from here), then rebuild the top level. The top-level `make all` does this automatically by running `build-macros` before verifying and building the top cell. You can also remove the sub-macro entirely and draw everything flat in the top-level layout (not recommended).

The top-level `schematic/xschem/xschemrc` and `testbenches/xschem/xschemrc` append the sub-macro's schematic folder to the Xschem library path, so symbols like `inverter.sym` resolve from the top-level schematic.


## Floorplan Templates

Start your top-level layout from one of the GDS templates in `floorplan/`. They define the slot geometry and all pin positions:

- **Signal pins** on Metal3 (west edge): the standard chip interface (`clk`, `ena`, `rst_n`, `ui_in[7:0]`, `uo_out[7:0]`, `uio_*[7:0]`) that connects your project to the eFPGA.
- **Analog pins** (`analog_0` … `analog_2`) on Metal2 (south edge) — only in the `*_analog` variants. If you use them, you must use the `small` or `tiny` slot and declare the count in `submission.yaml` (`analog-pins:`).
- **Power straps** on Metal4, running **vertically all the way from bottom to top**: `VPWR`, `VGND`, and optionally `VAPWR` (analog supply). These vertical straps are required for the power-grid integration. Do not shorten, move, or rename them.

> [!IMPORTANT]
> `TopMetal1` must remain **empty** in your macro. This is required for the chip integration and checked by the precheck.

To edit a layout, enable the Nix shell, export the PDK variables, and start KLayout in edit mode from the repository root:

```sh
nix-shell
export PDK_ROOT=$(pwd)/IHP-Open-PDK && export PDK=ihp-sg13cmos5l
make klayout
```


## Makefile Targets

The Makefile is identical in structure to the inverter sub-macro's (vendored `sak-*` scripts, same variables and targets) with `TOP = heichips26_analog_project` — see [`macros/inverter/README.md`](macros/inverter/README.md) for the full reference of every target. In short:

```sh
make                                     # help: all targets and variables
make klayout-verify-all                  # KLayout DRC + LVS of the top cell
make magic-verify-all                    # Magic DRC + LVS + PEX of the top cell
make build-top                           # LEF, LIB, Verilog stub, final GDS, render
make build-inverter                      # run the inverter sub-macro's full flow (make -C macros/inverter all)
make build-macros                        # verify, build and simulate all sub-macros (currently: inverter)
make sim-xschem                          # top-level transient (default: <CELL>_tb_tran, needs magic-pex first)
make sim-xschem TB=<testbenchname>       # run another testbench
make sim-view-xschem                     # plot the results (default: plot_<CELL>)
make sim-view-xschem SCRIPT=<scriptname> # run another plotting script
make all                                 # build-macros + verify + build + simulate
make clean                               # delete the top level's generated files (final, netlist, reports, simulations)
make clean-macros                        # run make clean in all sub-macros (currently: inverter)
make clean-all                           # clean-macros + clean
```

Differences to the sub-macro:

- `sim-all` runs only the top-level testbenches (e.g. `heichips26_analog_project_tb_tran`). It simulates the schematic by default and includes the extracted PEX netlist by swapping the DUT to the `_pex` symbol for a post-layout run. The inverter's own testbenches and CACE characterization live in `macros/inverter/`.
- `klayout-verify-all`/`magic-verify-all` verify the top cell only — the inverter cells are covered by `build-macros`/`build-inverter` (or run the sub-macro's own `make`).
- `make all` first runs `build-macros`, so the sub-macros are verified, built and simulated before the top cell — the build order below is handled automatically.
- `clean` deletes only the top level's generated files (`final/`, `netlist/`, the DRC/LVS reports, and the simulation outputs — there is no CACE at this level). `clean-macros` runs `make clean` in every sub-macro, and `clean-all` combines both, mirroring `build-macros`/`all`. Directly after cleaning, run `make magic-pex` (or the full `make all`) once before `make sim-xschem`/`make sim-all`, since the testbenches `.include` the extracted PEX netlist.


## Where to Go Next

- Repository root `README.md` — prerequisites, slot sizes, submission checklist, and precheck.
- [`macros/inverter/README.md`](macros/inverter/README.md) — the complete analog macro flow reference (all Makefile targets, DRC levels, PEX modes, `sim_pinname` convention, CACE).

# HeiChips26 Analog Project (ihp-sg13cmos5l)

This is the analog-on-top example project for the HeiChips 2026 Hackathon: the top level `heichips26_analog_project` is drawn **by hand** in KLayout, based on one of the floorplan templates in `floorplan/`. The example [`inverter`](macros/inverter/README.md) macro shows the complete analog design flow (schematic → simulation → layout → DRC/LVS/PEX → post-layout simulation → characterization).


## Directory Structure

```text
📁 heichips26_analog_project/
├─ 📁 floorplan/
│  ├─ heichips26_template_small.gds          # 500µm × 200µm slot
│  ├─ heichips26_template_small_analog.gds   # 500µm × 200µm slot + 3 analog pins
│  ├─ heichips26_template_tiny.gds           # 200µm × 200µm slot
│  └─ heichips26_template_tiny_analog.gds    # 200µm × 200µm slot + 3 analog pins
├─ 📁 macros/
│  └─ 📁 inverter/                           # analog example macro (own Makefile & README)
└─ README.md
```


## Floorplan Templates

Start your top-level layout from one of the GDS templates in `floorplan/`. They define the slot geometry and all pin positions:

- **Signal pins** on Metal3 (west edge): the standard chip interface (`clk`, `ena`, `rst_n`, `ui_in[7:0]`, `uo_out[7:0]`, `uio_*[7:0]`) that connects your project to the eFPGA.
- **Analog pins** (`analog_0` … `analog_2`) on Metal2 (south edge) — only in the `*_analog` variants. If you use them, you must use the `small` or `tiny` slot and declare the count in `submission.yaml` (`analog-pins:`).
- **Power straps** on Metal4, running **vertically all the way from bottom to top**: `VPWR`, `VGND`, and optionally `VAPWR` (analog supply). These vertical straps are required for the power-grid integration — do not shorten, move, or rename them.

> [!IMPORTANT]
> `TopMetal1` must remain **empty** in your macro. This is required for the chip integration and checked by the precheck.

To edit a layout, enable the Nix shell, export the PDK variables, and start KLayout in edit mode from the repository root:

```sh
nix-shell
export PDK_ROOT=$(pwd)/IHP-Open-PDK && export PDK=ihp-sg13cmos5l
make klayout
```


## Example Macro: Inverter

The [`macros/inverter/`](macros/inverter/) macro is a complete, verified reference for the analog flow:

- Schematic entry and testbenches in **Xschem**, simulations with **ngspice** (`make sim-xschem TB=...`)
- Hand-drawn layout in `layout/` (KLayout)
- **DRC, LVS, and PEX** with both Magic and KLayout flows, driven by the vendored IIC-OSIC-TOOLS `sak-*` scripts (`make magic-verify-all`, `make klayout-verify-all`)
- Post-layout (PEX) simulation and Python plotting (`make sim-view-xschem SCRIPT=...`)
- **CACE** characterization (`make sim-cace`)
- Deliverables for integration: GDS, LEF, LIB, and a Verilog stub (`make build-top`)

Its power ring already follows the HeiChips integration rules: vertical `VDD`/`VSS` straps on **Metal4**, horizontal ring parts on **Metal3**, and an empty TopMetal1. When you integrate a macro like this into your hand-drawn top level, connect the template's `VPWR`/`VGND` (and optionally `VAPWR`) Metal4 straps to the macro's supply straps.

See [`macros/inverter/README.md`](macros/inverter/README.md) for the full flow documentation.


## Where to Go Next

- Repository root `README.md` — prerequisites, slot sizes, submission checklist, and precheck.
- `macros/inverter/README.md` — the complete analog macro flow reference.

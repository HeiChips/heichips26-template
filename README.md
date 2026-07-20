# HeiChips 2026 Hackathon Template

This repository is the submission template for the HeiChips 2026 Hackathon.

Please implement your group project based on this template and notify us once you are done, so we can integrate your macro into the chip for tapeout. See [Submission](#Submission).

Your project will be connected to a small eFPGA along with all other user projects. This allows you to configure the eFPGA to route the I/Os of your project to the chip I/Os, implement additional logic in the eFPGA, connect several user projects together (ask what other teams are working on!), and make use of the SRAM.
For more information, see the HeiChips 2026 Tapeout repository: https://github.com/HeiChips/heichips26-tapeout

## Prerequisites

> [!NOTE]
> The HeiChips VM has Nix already pre-installed.

If you haven't installed Nix yet, please do so using LibreLane's documentation: [Nix-based Installation](https://librelane.readthedocs.io/en/latest/installation/nix_installation/index.html). 

Now you simply need to execute `nix-shell` at the root directory of this repository to enable all of the required tools. This has to be done each time you open a new shell.

The following tools are included:

- LibreLane and its dependencies
- cocotb with Icarus Verilog and Verilator, GTKWave and Surfer (WIP)
- nextpnr (icestorm, trellis) and openFPGALoader
- klayout, magic, netgen, ngspice

These tools enable you to implement your macro for the chip, run simulation using cocotb, and emulate your design on an FPGA.

## Slot Sizes

In order to ensure smooth integration of your macro into the chip, we provide three different DEF templates which specify the geometry of your macro and the pin positions.

- Tiny project template: 200um x 200um
- Small project template: 500um x 200um
- Large project template: 500um x 415um

> [!TIP]
> If you would like to use the large template, please talk to us, as there are limited slots available for it.

All submitted designs will be included on the chip (given the space), however, one team will be selected for the **HeiChips 2026 Award** based on several factors. The exact criteria will be announced before the Hackathon.

## Analog-On-Top Submission

If you would like to do an analog-on-top submission (the top-level is manually drawn), please use `macros/heichips26_analog_project/` as the starting point.

> [!IMPORTANT]
> You must rename `heichips26_analog_project` to a unique name starting with `heichips26_` and edit `submission.yaml`.
> Make sure to update the top-level name throughout the repository.

If you would like to use additional analog pins (up to 3 are possible), you must use the `small` slot size.
Use one of the provided templates in `macros/heichips26_analog_project/floorplan` for the pins.

In addition, you need `VDPWR`, `VGND` in your design. Optionally, you can also use `VAPWR`.

> [!IMPORTANT]
> Power straps must go horizontally all the way from the top to the bottom of your layout. This is required for the integration.

### Open a Schematic

1. First, enable a Nix shell using `nix-shell`.
2. Export `PDK_ROOT` and `PDK`: `export PDK_ROOT=$(pwd)/IHP-Open-PDK && export PDK=ihp-sg13cmos5l`
3. Change the path to the schematic or testbench folder of the macro, e.g.
  - `cd macros/heichips26_analog_project/macros/inverter/schematic/xschem`
  - `cd macros/heichips26_analog_project/schematic/xschem`
4. Open xschem: `xschem <name of schematic>`, e.g. `xschem inverter.sch`

### Run a Simulation

1. First, enable a Nix shell using `nix-shell`.
2. Export `PDK_ROOT` and `PDK`: `export PDK_ROOT=$(pwd)/IHP-Open-PDK && export PDK=ihp-sg13cmos5l`
3. Change the path to the schematic or testbench folder of the macro, e.g.
  - `cd macros/heichips26_analog_project/macros/inverter/testbenches/xschem`
  - `cd macros/heichips26_analog_project/schematic/xschem`
4. Open xschem: `xschem <name of testbench>`, e.g. `xschem inverter_tb_tran.sch`
6. In the schematic Ctrl + left click: "Simulate"
7. In the schematic Ctrl + left click: "Annotate OP" or "Load waves"

### Edit a Layout

1. First, enable a Nix shell using `nix-shell`.
2. Export `PDK_ROOT` and `PDK`: `export PDK_ROOT=$(pwd)/IHP-Open-PDK && export PDK=ihp-sg13cmos5l`
3. Start KLayout in edit mode: `make klayout`

Now you can create or open a layout and edit it.

## Digital-On-Top Submissiom

If you would like to do a digital-on-top submission (the top-level is generated automatically), please use `macros/heichips26_digital_project/` as the starting point.

> [!IMPORTANT]
> You must rename `heichips26_digital_project` to a unique name starting with `heichips26_` and edit `submission.yaml`.
> Make sure to update the top-level name throughout the repository.

The `heichips26_digital_project` example uses one sub-macro called `counter`. You can modify it and add additional sub-macros, or you can remove all sub-macros completely and only make a sea-of-gates implementation.

For more details on simulation and FPGA emulation, see `macros/heichips26_digital_project/README.md`.


## Physical Implementation using LibreLane

To implement the macro of your project, run the following make target, which invokes LibreLane:

```
make macro
```

To view the macro in the OpenROAD GUI:

```
make macro-openroad
```

To view the layout of the macro with KLayout:

```
make macro-klayout
```

## Submission

In order to submit your design for integration into the HeiChips 2026 Tapeout, please open an issue at the following repository: https://github.com/HeiChips/heichips26-tapeout/issues

**The submission deadline is to be announced.**

The `submission.yaml` config must be filled out, and the precheck must be green.

Here's an additional checklist:

- [ ] The project top-level has a unique name starting with `heichips26_`.
- [ ] The design is verified and tested.
- [ ] The macro is stored under `macro/`.
- [ ] `TopMetal1` in the macro is empty (for integration).
- [ ] The macro is DRC clean.
- [ ] The macro uses the default power pins (VPWR, VGND, VAPWR optional).
- [ ] The project is licensed with a compatible open source license, for example Apache 2.0.

## License

The code in this repository is licensed under Apache 2.0.

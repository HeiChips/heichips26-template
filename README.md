# HeiChips 2026 Hackathon Template

This repository is the submission template for the HeiChips 2026 Hackathon.

Please implement your group project based on this template and notify us once you are done, so we can integrate your macro into the chip for tapeout. See [Submission](#Submission).

Your project will be connected to a small eFPGA along with all other user projects. This allows you to configure the eFPGA to route the I/Os of your project to the chip I/Os, implement additional logic in the eFPGA, connect several user projects together (ask what other teams are working on!), and make use of the SRAM.
For more information, see the HeiChips 2026 Tapeout repository: https://github.com/HeiChips/heichips26-tapeout

Table Of Contents

- [Prerequisites](#prerequisites)
- [Template Structure](#template-structure)
- [Slot Sizes](#slot-sizes)
- [Analog-On-Top Design](#analog-on-top-design)
- [Digital-On-Top Design](#digital-on-top-design)
- [Submission](#submission)

## Prerequisites

This template provides a Nix shell with all the tools required for analog design, digital design and verification.

If you haven't installed Nix yet, please follow LibreLane's documentation: [Nix-based Installation](https://librelane.readthedocs.io/en/latest/installation/nix_installation/index.html).

> [!NOTE]
> The HeiChips VM has Nix already pre-installed.

Now, simply execute `nix-shell` from the root directory of this repository to enable all of the required tools. This must be done every time you open a new shell.

The first time you enable the Nix shell, please run `make clone-pdk` to install the IHP Open PDK for ihp-sg13cmos5l in this repository.

## Template Structure

The template builds on top of a recursive `macros` structure: inside `macros/` you can find the two directories `heichips26_analog_project` and `heichips26_digital_project`. These are the two example top-level macros for submission.

Macros can themselves have one ore more macros, recursively. As an example, `heichips26_analog_project` includes the analog `inverter` macro, and `heichips26_digital_project` includes the digital `counter` macro. It is not required to use sub-macros such as `invert` and `counter`. You can simply delete them and implement your design in the corresponding top-level macro only.

For the submission, you need to decide whether you want to make an analog-on-top or digital-on-top design. Adjust `submission.yaml` accordingly.

## Slot Sizes

In order to ensure smooth integration of your macro into the chip, we provide three different DEF templates which specify the geometry of your macro and the pin positions.

- Tiny project template: 200µm × 200µm
- Small project template: 500µm × 200µm
- Large project template: 500µm × 415µm

> [!TIP]
> If you would like to use the large template, please talk to us, as there are limited slots available for it.

## Analog-On-Top Design

If you would like to do an analog-on-top design (the top-level is drawn manually), please use `macros/heichips26_analog_project/` as the starting point.

> [!IMPORTANT]
> You must rename `heichips26_analog_project` to a unique name starting with `heichips26_` and edit `submission.yaml`.
> Make sure to update the top-level name throughout the repository.

If you would like to use additional analog pins (up to 3 are possible), you must use the `small` slot size.
Use one of the provided templates in `macros/heichips26_analog_project/floorplan` for the pins.

In addition, you need vertical `VDPWR`, `VGND` straps in your design. Optionally, you can also use `VAPWR`.

> [!IMPORTANT]
> Power straps must run vertically all the way from top to bottom of your layout. This is required for the integration.

For more details, see `macros/heichips26_analog_project/README.md`.

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

## Digital-On-Top Design

If you would like to do a digital-on-top design (the top-level is generated automatically), please use `macros/heichips26_digital_project/` as the starting point.

> [!IMPORTANT]
> You must rename `heichips26_digital_project` to a unique name starting with `heichips26_` and edit `submission.yaml`.
> Make sure to update the top-level name throughout the repository.

The `heichips26_digital_project` example uses one sub-macro called `counter`. You can modify it and add additional sub-macros, or you can remove all sub-macros completely and only make a sea-of-gates implementation.

For more details on simulation and FPGA emulation, see `macros/heichips26_digital_project/README.md`.

## Submission

The `submission.yaml` config must be filled out and the precheck must be successful. The precheck runs every time you push a commit to the repository.
You can also run the precheck locally using: `make precheck`.

Here's an additional checklist:

- [ ] The project top-level has a unique name starting with `heichips26_`.
- [ ] One of the available slot sizes is used (tiny, small or large).
- [ ] `TopMetal1` in the macro is empty. This is required for the integration.
- [ ] The design has been verified in simulation.
- [ ] The macro is DRC clean.
- [ ] The macro should be LVS clean.
- [ ] The macro uses the default power pins: VPWR, VGND, VAPWR (optional)
- [ ] The project is licensed under a compatible open-source license, for example Apache 2.0.

In order to submit your design for integration into the HeiChips 2026 Tapeout, please open an issue at the following repository: https://github.com/HeiChips/heichips26-tapeout/issues

**The submission deadline is to be announced.**

All submitted designs will be included on the chip (given the space). However, one team will be selected for the **HeiChips 2026 Award** based on several factors. The exact criteria will be announced before the hackathon.

## License

The code in this repository is licensed under Apache 2.0 WITH SHL-2.1 if not otherwise stated.

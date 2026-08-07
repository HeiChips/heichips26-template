# LoopCache-RV submission checklist

This file separates results that have already been demonstrated from work that
requires the official HeiChips Nix shell, IHP PDK, final slot assignment, or
submission infrastructure. Do not call the project tapeout-ready until every
required item below is checked.

## Demonstrated in this repository

- [x] Unique top-level name: `heichips26_loopcache_rv`.
- [x] Large-slot outline and pin template selected.
- [x] PicoRV32 dependency pinned as a git submodule with its upstream license.
- [x] RV32E benchmark image generated without an external compiler toolchain.
- [x] Cache-OFF and cache-ON runs produce the same architectural result.
- [x] Cache-ON reduces cycles, external fetches, and memory-stall cycles.
- [x] Complete ASIC RTL hierarchy passes generic Yosys synthesis and checks.
- [x] 16-bit packet protocol, MMIO map, and counters are documented.
- [x] FABulous gateway targets the official Large-project and 1024x32 SRAM
      primitives.
- [x] Gateway core passes generic synthesis and a cycle-accurate read/write
      protocol check, including address, data, handshake, and byte mask.
- [x] No copied example GDS, LEF, netlist, or sign-off report is claimed as a
      LoopCache-RV result.

## Run in the official Nix environment

- [ ] Regenerate firmware with `make firmware`.
- [ ] Pass Verilator lint with `make lint`.
- [ ] Pass SystemVerilog and Cocotb RTL regressions with `make sim`.
- [ ] Re-run the gateway unit test in the official tool environment with
      `make -C efpga/loopcache_sram_gateway test-core`.
- [ ] Clone the pinned PDK with `make clone-pdk`.
- [ ] Complete LibreLane hardening with `make harden`.
- [ ] Review placement density, congestion, clock tree, hold/setup timing, and
      power reports; adjust constraints or floorplan if required.
- [ ] Confirm DRC, LVS, antenna, manufacturability, and IR-drop checks pass.
- [ ] Confirm the project does not use the reserved top metal layer.
- [ ] Run the cache-OFF/cache-ON regression on the generated gate-level
      netlist with `make sim-gl-cocotb` in the macro directory.
- [ ] Run root-level `make precheck` and keep all generated final views and
      reports only after they pass.

## Integrate with the official full-chip repository

- [ ] Ask the organizers to confirm a Large slot is available and record the
      assigned project index/BEL.
- [ ] Update the FABulous placement constraint to the assigned
      `TT_PROJECT_LARGE` instance.
- [ ] Copy `efpga/loopcache_sram_gateway` into the current official tapeout
      repository and build its bitstream.
- [ ] Preload the 4 KiB shared SRAM with `firmware/loopcache_test.hex` using the
      official simulation/programming mechanism.
- [ ] Run a full-chip test covering ASIC macro, configured eFPGA gateway, and
      the official 1024x32 SRAM model.
- [ ] Check that reset, cache-enable/flush pins, firmware completion, trap, and
      performance-counter readout are observable in the official harness.

## Submission actions

- [ ] Replace any placeholder team metadata if the official schema requires
      additional names or contact information.
- [ ] Fork the official template under the final team account.
- [ ] Commit the generated GDS, LEF, Verilog header, timing views, netlists,
      render, and verification reports from the successful physical run.
- [ ] Push the final branch and open the required submission issue or pull
      request before the published deadline.
- [ ] Archive the exact commit hashes for this repository, PicoRV32, PDK, and
      official tapeout repository used for the final build.

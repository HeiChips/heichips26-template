# HeiChips26 eFPGA gateway

`loopcache_sram_gateway/` contains the FABulous user design that connects the
Large LoopCache-RV macro to the chip's official `IHP_SRAM_1024x32_1RW`
primitive. It uses the same clock for the processor, gateway and SRAM, so the
link does not cross a clock domain.

The gateway enables the loop buffer by default. Asserting its active-high
`rst` input resets the gateway, resets the processor through the Large-project
primitive, and flushes the loop buffer.

## Build a bitstream

The official tapeout repository owns the FABulous Yosys/nextpnr forks and
fabric database. Build this source inside that repository:

```sh
git clone --recurse-submodules https://github.com/HeiChips/heichips26-tapeout.git
cp -r loopcache-rv/efpga/loopcache_sram_gateway \
  heichips26-tapeout/user_designs/designs/classic/
cd heichips26-tapeout/user_designs
nix-shell
make loopcache_sram_gateway
```

The design instantiates `TT_PROJECT_LARGE`, so its final BEL/slot constraint
must match the Large slot assigned by the organizers. The bitstream is built
after that assignment; it is not part of the hardened ASIC macro submission.

Before full-fabric integration, test the standalone packet engine with:

```sh
make -C efpga/loopcache_sram_gateway test-core
```

The resulting `.bit`/`.hex` files configure only the central eFPGA. They must
not be confused with the ASIC GDS/LEF files produced by LibreLane.

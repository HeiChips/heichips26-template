# FPGA Emulation Flow — `counter` (standalone)

Emulates the `counter` macro on its own — native ports (`clk_i`,
`rst_ni`, `enable_i`, `count_o`), no chip-level wrapper. See
`../../../fpga/README.md` for the full target reference.

## Picking a board

`Makefile` is a dispatcher, same as `../../../fpga/Makefile`: it forwards
every target to `<board>/Makefile`, defaulting to `BOARD := ulx3s`.

```sh
make all                  # ulx3s
make BOARD=icebreaker all
```

| Board       | Directory     | Status |
|-------------|---------------|--------|
| ULX3S       | `ulx3s/`      | Tested, hardware flash-verified, default |
| pico-ice    | `pico-ice/`   | Build verified, flash untested |
| iCEBreaker  | `icebreaker/`| Build verified, flash untested |
| Tang Nano 9K| `nano9k/`     | Build verified, flash untested |
| Basys 3     | `basys3/`     | Tested, hardware flash-verified (needs `nix-openxc7`) |
| Boolean     | `boolean/`    | Build verified, flash untested (needs `nix-openxc7`) |

Each board's constraint file maps `counter`'s native ports onto pins
already used by its top-level flow (`../../../../fpga/<board>/`) — same
physical pins, different net names. `pico-ice/` is the exception: its
`PCF_FILE` points straight at `../../../../fpga/pico-ice/pico-ice.pcf`
(shared, not copied), since that file already used these names.

> [!NOTE]
> On Basys 3 and Boolean, `rst_ni`/`enable_i` are `sw[0]`/`sw[1]`
> toggles, not buttons — both boards' buttons are active-high, which
> would hold `rst_ni` asserted at idle with no wrapper to invert it.

For chip-level emulation, see `../../../fpga/`.

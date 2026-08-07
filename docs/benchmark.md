# Reference RTL benchmark

The benchmark executes the same 24-word RV32E image with the loop buffer OFF
and ON. A 20-iteration loop occupies addresses `0x20` through `0x30`, entirely
inside one 32-byte buffer line. The external SRAM model uses the documented
16-bit ready/valid protocol.

## Pre-layout result

The following result was measured from a Yosys CXXRTL model generated from the
complete synthesizable hierarchy:

| Mode | Result | Cycles | External instruction fetches | Loop hits | Stall cycles |
|---|---:|---:|---:|---:|---:|
| buffer OFF | 20 | 884 | 130 | 0 | 552 |
| buffer ON | 20 | 561 | 16 | 114 | 96 |

For this deliberately loop-heavy workload, enabling the buffer reduces total
cycles by 36.5%, external instruction fetches by 87.7%, and recorded memory
stall cycles by 82.6%. These are workload-specific architecture results, not
post-layout frequency or power claims.

## Pass criteria

The Cocotb regression treats performance as part of correctness. It requires:

1. identical architectural result in both runs;
2. no hits when bypassed and at least one hit when enabled;
3. fewer external instruction fetches when enabled;
4. fewer elapsed cycles when enabled.

Run `make sim-rtl-cocotb` from `macros/heichips26_loopcache_rv` in the official
Nix shell. After hardening, `make sim-gl-cocotb` repeats the same architectural
checks against the generated standard-cell netlist.

# 16-bit eFPGA memory link

The hardened macro exposes a single-outstanding, ready/valid packet link. It is
small enough to implement in the central eFPGA and sufficient for the shared
4 KiB SRAM.

## Request channel

- data: `uo_out[15:0]`
- valid: `uio_out[0]`
- ready: `uio_in[0]`

The first beat is always a header:

| Bits | Meaning |
|---|---|
| 15 | write request |
| 14 | instruction request |
| 13:4 | 32-bit SRAM word address |
| 3:0 | byte write strobes |

A write header is followed by `wdata[15:0]` and `wdata[31:16]`. The requester
receives no separate write response; accepting the second data beat completes
the write.

## Read-response channel

- data: `ui_in[15:0]`
- valid: `uio_in[1]`
- ready: `uio_out[1]`

The responder sends `rdata[15:0]` followed by `rdata[31:16]`. Only one request
may be outstanding, so no transaction ID is needed.

## Control and debug

| Signal | Meaning |
|---|---|
| `uio_in[2]` | loop buffer enable |
| `uio_in[3]` | synchronous loop buffer flush |
| `uio_out[2]` | CPU trap |
| `uio_out[3]` | sampled enable state |
| `uio_out[15:4]` | low 12 bits of loop-buffer hit count |


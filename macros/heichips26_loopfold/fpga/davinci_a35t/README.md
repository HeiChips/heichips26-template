# LoopFold DaVinci XC7A35T FPGA Demo

This Vivado project runs the existing `loopcache_soc` on the DaVinci Artix-7
board. The FPGA wrapper adds:

- a 4 KiB BRAM responder for the documented 16-bit memory link
- UART reporting at 115200 baud
- a minimal board constraint file derived from the DaVinci XDC

## Build

From the repository root:

```bash
source "$HOME/tools/Xilinx/Vivado/2024.2/settings64.sh"
vivado -mode batch -source fpga/davinci_a35t/build.tcl
```

The bitstream is written to:

```text
fpga/davinci_a35t/build/loopcache_davinci_a35t.bit
```

## Board IO

- `sys_clk`: 50 MHz board clock
- `sys_rst_n`: active-low reset
- `key[1]`: cache enable, leave high for the cached run
- `key[0]`: active-low cache flush
- `uart_txd`: serial output, 115200 8N1
- `led[0]`: reset released
- `led[1]`: PicoRV32 trap reached
- `led[2]`: UART reporter busy
- `led[3]`: at least one loop-cache hit observed

Open a serial terminal at 115200 baud before or immediately after programming.
After the firmware reaches `EBREAK`, the board prints the performance counters.

# SPDX-FileCopyrightText: 2026 Simon Dorrer and Harald Pretl
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

import os
import re
import logging
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, ClockCycles
from cocotb_tools.runner import get_runner

sim      = os.getenv("SIM", "icarus")
pdk_root = os.getenv("PDK_ROOT", Path("~/.ciel").expanduser())
pdk      = os.getenv("PDK", "ihp-sg13cmos5l")
scl      = os.getenv("SCL", "sg13cmos5l_stdcell")
# GL=1 selects the gate-level netlist; anything else (unset, "0", "") stays in RTL mode.
gl       = os.getenv("GL", "0").strip().lower() in ("1", "true", "yes", "on")

hdl_toplevel = "heichips26_digital_project"

CTR_WIDTH        = 8
CTR_MAX          = 2**CTR_WIDTH-1
print(CTR_MAX)
CLK_FREQ_HZ      = 50e6
CLK_FREQ_MHZ     = int(CLK_FREQ_HZ / 1e6)


async def start_clock(clock, freq=CLK_FREQ_MHZ):
    """Start the clock @ freq MHz"""
    period_ns = round(1 / freq * 1000, 4)
    c = Clock(clock, period_ns, "ns")
    cocotb.start_soon(c.start())


async def reset(reset, clock, cycles=2):
    """Pulse the active-low reset for `cycles` clock cycles."""
    cocotb.log.info("Reset asserted...")

    reset.value = 0
    await ClockCycles(clock, cycles)
    reset.value = 1
    await RisingEdge(clock)

    cocotb.log.info("Reset deasserted.")


async def start_up(dut):
    """Startup sequence: clock + reset, heichips26_digital_project disabled, value cleared."""
    await start_clock(dut.clk, CLK_FREQ_MHZ)
    dut.ui_in.value = 0
    await reset(dut.rst_n, dut.clk)


@cocotb.test()
async def test_reset_clears_heichips26_digital_project(dut):
    """After reset deasserts, uo_out must be zero."""
    logger = logging.getLogger("heichips26_digital_project_tb")

    logger.info("Startup sequence...")
    await start_up(dut)

    assert int(dut.uo_out.value) == 0, \
        f"heichips26_digital_project not zero after reset (got {int(dut.uo_out.value)})"

    logger.info("Done!")


@cocotb.test()
async def test_holds_when_disabled(dut):
    """With enable_i = 0, uo_out must not change."""
    logger = logging.getLogger("heichips26_digital_project_tb")

    logger.info("Startup sequence...")
    await start_up(dut)

    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 20)

    assert int(dut.uo_out.value) == 0, \
        f"heichips26_digital_project changed while disabled (got {int(dut.uo_out.value)})"

    logger.info("Done!")


@cocotb.test()
async def test_increments_when_enabled(dut):
    """With enable_i = 1, uo_out must increment by 1 every clock."""
    logger = logging.getLogger("heichips26_digital_project_tb")

    logger.info("Startup sequence...")
    await start_up(dut)

    dut.ui_in.value = 1

    # Sample on a few subsequent clock edges and verify monotonic +1
    expected = 1
    for _ in range(min(8, CTR_MAX + 1)):
        await RisingEdge(dut.clk)
        await Timer(1, "ns")  # let combinational settle past edge
        got = int(dut.uo_out.value)
        assert got == expected, f"expected {expected}, got {got}"
        expected += 1

    logger.info("Done!")


@cocotb.test()
async def test_wraps_at_max(dut):
    """heichips26_digital_project must wrap from CTR_MAX back to 0."""
    logger = logging.getLogger("heichips26_digital_project_tb")

    logger.info("Startup sequence...")
    await start_up(dut)

    dut.ui_in.value = 1

    # Run long enough to hit CTR_MAX and wrap
    saw_max  = False
    saw_wrap = False
    prev     = 0
    for _ in range(2 * (CTR_MAX + 1) + 4):
        await RisingEdge(dut.clk)
        await Timer(1, "ns")
        cur = int(dut.uo_out.value)
        if cur == CTR_MAX:
            saw_max = True
        if saw_max and prev == CTR_MAX and cur == 0:
            saw_wrap = True
            break
        prev = cur

    assert saw_max,  "heichips26_digital_project never reached CTR_MAX"
    assert saw_wrap, "heichips26_digital_project did not wrap from CTR_MAX to 0"

    logger.info("Done!")


def heichips26_digital_project_runner():

    proj_path = Path(__file__).resolve().parent

    sources  = []
    defines  = {}
    includes = [proj_path / "../../rtl/"]

    if gl:
        # SCL models
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / f"{scl}.v")
        sources.append(Path(pdk_root) / pdk / "libs.ref" / scl / "verilog" / "sg13cmos5l_udp.v")

        # Unpowered gate-level netlist of the macro
        sources.append(proj_path / f"../../final/nl/{hdl_toplevel}.nl.v")
        sources.append(proj_path / f"../../macros/counter/final/nl/counter.nl.v")

        # Unpowered netlist: USE_POWER_PINS must NOT be defined at all
        # (passing USE_POWER_PINS=False would still define the macro).
    else:
        sources.append(proj_path / "../../rtl/heichips26_digital_project.sv")
        sources.append(proj_path / "../../macros/counter/rtl/counter.sv")

    build_args = []

    if sim == "icarus":
        # -gno-specify: skip specify blocks; sg13g2_stdcell.v uses
        # `ifnone with edge-sensitive paths`, which iverilog can't parse.
        build_args = ["-DSIM", "-gno-specify"]

    if sim == "verilator":
        build_args = ["--timing", "--trace", "--trace-fst", "--trace-structs"]

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel=hdl_toplevel,
        defines=defines,
        always=True,
        includes=includes,
        build_args=build_args,
        waves=True,
        timescale=("1ns", "1fs")
    )

    plusargs = []

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module="heichips26_digital_project_tb",
        plusargs=plusargs,
        waves=True,
    )


if __name__ == "__main__":
    heichips26_digital_project_runner()

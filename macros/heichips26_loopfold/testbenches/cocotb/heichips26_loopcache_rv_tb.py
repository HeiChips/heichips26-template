# SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

import os
from dataclasses import dataclass
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, FallingEdge, RisingEdge, Timer
from cocotb_tools.runner import get_runner


SIM = os.getenv("SIM", "icarus")
GL = os.getenv("GL", "0").strip().lower() in ("1", "true", "yes", "on")
REPO_ROOT = Path(__file__).resolve().parents[4]
PDK_ROOT = Path(os.getenv("PDK_ROOT", REPO_ROOT / "IHP-Open-PDK")).expanduser()
PDK = os.getenv("PDK", "ihp-sg13cmos5l")
SCL = os.getenv("SCL", "sg13cmos5l_stdcell")
TOP = "heichips26_loopcache_rv"
CLOCK_PERIOD_NS = 20


@dataclass
class RunResult:
    result: int
    cycles: int
    external_fetches: int
    hits: int
    stalls: int
    prefetches: int
    useful_prefetches: int


class SharedSramModel:
    """Behavioral responder for the documented 16-bit memory link."""

    def __init__(self, dut, image: list[int], read_latency_cycles: int = 0):
        self.dut = dut
        self.initial_image = list(image)
        self.read_latency_cycles = read_latency_cycles
        self.words = [0] * 1024
        self.reset_memory()

    def reset_memory(self):
        self.words = [0] * 1024
        self.words[: len(self.initial_image)] = self.initial_image

    async def run(self):
        state = "header"
        write_address = 0
        write_strobes = 0
        write_low = 0
        pending_read: list[int] = []
        response_delay = 0

        while True:
            await FallingEdge(self.dut.clk)

            # Drive inputs half a cycle before the active clock edge.
            tx_ready = 0 if pending_read else 1
            rx_valid = 1 if pending_read and response_delay == 0 else 0
            control = int(self.dut.uio_in.value)
            control = (control & ~0x3) | tx_ready
            if rx_valid:
                control |= 0x2
                self.dut.ui_in.value = pending_read[0]
            else:
                self.dut.ui_in.value = 0
            self.dut.uio_in.value = control

            # Sample the stable pre-edge outputs. Sampling after the rising
            # edge would observe the bridge's next state and miss a transfer.
            await Timer(1, unit="ns")
            if not self.dut.rst_n.value.is_resolvable or not int(
                self.dut.rst_n.value
            ):
                await RisingEdge(self.dut.clk)
                state = "header"
                pending_read.clear()
                response_delay = 0
                continue

            uio_value = self.dut.uio_out.value
            uo_value = self.dut.uo_out.value
            tx_valid = int(uio_value) & 0x1 if uio_value.is_resolvable else 0
            rx_ready = (int(uio_value) >> 1) & 1 if uio_value.is_resolvable else 0
            beat = int(uo_value) if uo_value.is_resolvable else 0

            await RisingEdge(self.dut.clk)

            if pending_read and response_delay > 0:
                response_delay -= 1

            if tx_valid and tx_ready:
                if state == "header":
                    is_write = (beat >> 15) & 1
                    word_address = (beat >> 4) & 0x3FF
                    write_strobes = beat & 0xF
                    if is_write:
                        write_address = word_address
                        state = "write_low"
                    else:
                        word = self.words[word_address]
                        pending_read = [word & 0xFFFF, (word >> 16) & 0xFFFF]
                        response_delay = self.read_latency_cycles
                elif state == "write_low":
                    write_low = beat
                    state = "write_high"
                elif state == "write_high":
                    old = self.words[write_address]
                    new = write_low | (beat << 16)
                    merged = old
                    for byte in range(4):
                        if (write_strobes >> byte) & 1:
                            mask = 0xFF << (8 * byte)
                            merged = (merged & ~mask) | (new & mask)
                    self.words[write_address] = merged & 0xFFFF_FFFF
                    state = "header"
                else:
                    raise AssertionError(f"invalid memory model state: {state}")

            if rx_valid and rx_ready:
                pending_read.pop(0)


def load_firmware(name: str) -> list[int]:
    path = (
        Path(__file__).resolve().parents[4]
        / "firmware"
        / f"loopcache_{name}.hex"
    )
    return [int(line, 16) for line in path.read_text(encoding="ascii").splitlines()]


async def reset(dut, cache_enable: bool, prefetch_enable: bool):
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    control = 0
    if cache_enable:
        control |= 1 << 2
    if prefetch_enable:
        control |= 1 << 4
    dut.uio_in.value = control
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)


async def run_until_trap(
    dut,
    memory: SharedSramModel,
    cache_enable: bool,
    prefetch_enable: bool,
) -> RunResult:
    memory.reset_memory()
    await reset(dut, cache_enable, prefetch_enable)

    for _ in range(20_000):
        await RisingEdge(dut.clk)
        await Timer(1, unit="ns")
        if (int(dut.uio_out.value) >> 2) & 1:
            break
    else:
        raise AssertionError("processor did not trap within 20,000 cycles")

    return RunResult(
        result=memory.words[0x300 // 4],
        cycles=memory.words[0x304 // 4],
        external_fetches=memory.words[0x308 // 4],
        hits=memory.words[0x30C // 4],
        stalls=memory.words[0x310 // 4],
        prefetches=memory.words[0x314 // 4],
        useful_prefetches=memory.words[0x318 // 4],
    )


async def compare_modes(
    dut, benchmark: str, read_latency_cycles: int = 0
) -> tuple[RunResult, RunResult, RunResult]:
    cocotb.start_soon(Clock(dut.clk, CLOCK_PERIOD_NS, unit="ns").start())
    memory = SharedSramModel(
        dut,
        load_firmware(benchmark),
        read_latency_cycles=read_latency_cycles,
    )
    cocotb.start_soon(memory.run())

    baseline = await run_until_trap(
        dut, memory, cache_enable=False, prefetch_enable=False
    )
    cached = await run_until_trap(
        dut, memory, cache_enable=True, prefetch_enable=False
    )
    adaptive = await run_until_trap(
        dut, memory, cache_enable=True, prefetch_enable=True
    )

    assert baseline.result == 20
    assert cached.result == baseline.result
    assert adaptive.result == baseline.result
    assert baseline.hits == 0
    assert baseline.prefetches == 0
    assert cached.prefetches == 0
    dut._log.info(
        "%s latency=%d baseline=%s",
        benchmark,
        read_latency_cycles,
        baseline,
    )
    dut._log.info(
        "%s latency=%d cached=%s",
        benchmark,
        read_latency_cycles,
        cached,
    )
    dut._log.info(
        "%s latency=%d adaptive=%s",
        benchmark,
        read_latency_cycles,
        adaptive,
    )
    return baseline, cached, adaptive


@cocotb.test()
async def test_same_line_loop(dut):
    baseline, cached, adaptive = await compare_modes(dut, "same_line")

    assert cached.hits > 0
    assert cached.external_fetches < baseline.external_fetches
    assert cached.cycles < baseline.cycles
    assert adaptive.external_fetches < baseline.external_fetches
    assert adaptive.cycles < baseline.cycles


@cocotb.test()
async def test_cross_line_loop_uses_two_lines(dut):
    """A loop crossing one line boundary must remain resident in V2."""

    baseline, cached, adaptive = await compare_modes(dut, "cross_line")

    assert cached.hits > 0
    assert cached.external_fetches < baseline.external_fetches
    assert cached.cycles < baseline.cycles
    assert adaptive.external_fetches < baseline.external_fetches
    assert adaptive.cycles < baseline.cycles


@cocotb.test()
async def test_split_loop_uses_two_lines(dut):
    """Two non-adjacent hot instruction lines must coexist in V2."""

    baseline, cached, adaptive = await compare_modes(dut, "split_loop")

    assert cached.hits > 0
    assert cached.external_fetches < baseline.external_fetches
    assert cached.cycles < baseline.cycles
    assert adaptive.external_fetches < baseline.external_fetches
    assert adaptive.cycles < baseline.cycles
    # An adaptive prefetcher must not destroy the resident two-line working
    # set.  Allow one speculative narrow-link transaction during warm-up, but
    # reject the repeated pollution seen with an over-eager predictor.
    assert adaptive.external_fetches <= cached.external_fetches + 2
    assert adaptive.cycles <= cached.cycles + 20


@cocotb.test()
async def test_straight_line_prefetch(dut):
    """Sequential confidence should turn lookahead requests into useful hits."""

    baseline, cached, adaptive = await compare_modes(dut, "straight_line")

    assert cached.hits == 0
    assert adaptive.prefetches > 0
    assert adaptive.useful_prefetches > 0
    assert adaptive.useful_prefetches <= adaptive.prefetches
    assert adaptive.cycles < cached.cycles
    assert adaptive.stalls < cached.stalls


@cocotb.test()
async def test_cross_line_with_slow_sram(dut):
    """Loop-cache benefit should grow when the backing SRAM is slower."""

    baseline, cached, adaptive = await compare_modes(
        dut,
        "cross_line",
        read_latency_cycles=4,
    )

    assert cached.hits > 0
    assert cached.external_fetches < baseline.external_fetches
    assert cached.cycles < baseline.cycles
    assert adaptive.external_fetches < baseline.external_fetches
    assert adaptive.cycles < baseline.cycles


def runner():
    test_dir = Path(__file__).resolve().parent
    project_dir = test_dir.parents[1]
    repo_root = test_dir.parents[3]

    sources = []
    defines = {}
    if GL:
        sources.extend(
            [
                PDK_ROOT / PDK / "libs.ref" / SCL / "verilog" / f"{SCL}.v",
                PDK_ROOT / PDK / "libs.ref" / SCL / "verilog" / "sg13cmos5l_udp.v",
                project_dir / f"netlist/nl/{TOP}.nl.v",
            ]
        )
    else:
        sources.extend(
            [
                repo_root / "third_party/picorv32/picorv32.v",
                project_dir / "rtl/loopcache_frontend.sv",
                project_dir / "rtl/narrow_mem_bridge.sv",
                project_dir / "rtl/loopcache_soc.sv",
                project_dir / f"rtl/{TOP}.sv",
            ]
        )

    build_args = []
    if SIM == "icarus":
        build_args = ["-DSIM", "-gno-specify"]
    elif SIM == "verilator":
        build_args = ["--timing", "--trace", "--trace-fst", "--trace-structs"]

    sim_runner = get_runner(SIM)
    sim_runner.build(
        sources=sources,
        hdl_toplevel=TOP,
        defines=defines,
        always=True,
        build_args=build_args,
        waves=True,
        timescale=("1ns", "1fs"),
    )
    sim_runner.test(
        hdl_toplevel=TOP,
        test_module="heichips26_loopcache_rv_tb",
        waves=True,
    )


if __name__ == "__main__":
    runner()

import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.types import LogicArray
from cocotb_test.simulator import run

@cocotb.test()
async def dff_generic(dut):
    """D flip-flop generic test"""

    clock = Clock(dut.clk, 2, units="ns")
    cocotb.start_soon(clock.start(start_high=False))

    dut.d.value = 1
    dut.reset.value = 1
    await RisingEdge(dut.clk)
    dut.reset.value = 0
    await RisingEdge(dut.clk)
    assert LogicArray(dut.q.value) == LogicArray("0")

    for i in range(10):
        val = random.randint(0, 1)
        dut.d.value = val
        await RisingEdge(dut.clk)
        await RisingEdge(dut.clk)
        assert dut.q.value == val, f"output q was incorrect on the {i}th cycle"

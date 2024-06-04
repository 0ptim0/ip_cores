import random

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.types import LogicArray
from cocotb_test.simulator import run

@cocotb.test()
async def rgb(dut):
    """RGB test"""

    clock = Clock(dut.clk, 2, units="ns")
    cocotb.start_soon(clock.start(start_high=False))


import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge

@cocotb.test()
async def glitch_filter(dut):
    """Glitch_filter test"""

    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start(start_high=False))
    dut.reset.value = 1
    dut.i.value = 1
    await RisingEdge(dut.clk)
    dut.reset.value = 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0

    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 0
    await RisingEdge(dut.clk)
    assert dut.o.value.integer == 1
    await FallingEdge(dut.clk)
    

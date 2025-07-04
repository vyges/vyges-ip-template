# How to run
# Make sure you have cocotb installed (pip install cocotb).
# Run your simulator with cocotb testbench, e.g., for Icarus Verilog:
# iverilog -g2012 -o your_ip_block.vvp rtl/top_wrapper.sv rtl/your_ip_block.sv tb/cocotb/your_ip_block_tb.py
# vvp -M $COCOTB_LIBRARY -m libcocotbvpi your_ip_block.vvp

# How to run with cocotb
# cocotb-config --compile --testbench tb/cocotb/your_ip_block_tb.py
# cocotb-config --run --testbench tb/cocotb/your_ip_block_tb.py

# What this testbench does:
# - Generates a 100 MHz clock.
# - Holds reset low for 100 ns, then releases it.
# - Performs one APB write to address 0x0000.
# - Reads back from address 0x0000.
# - Checks that read data matches what was written.
# - Logs result info.

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer, FallingEdge

class APBMaster:
    def __init__(self, dut):
        self.dut = dut

    async def reset(self, duration_ns=100):
        self.dut.rst_n.value = 0
        for _ in range(duration_ns // 10):
            await RisingEdge(self.dut.clk)
        self.dut.rst_n.value = 1
        await RisingEdge(self.dut.clk)

    async def write(self, addr, data):
        self.dut.psel.value = 1
        self.dut.penable.value = 0
        self.dut.pwrite.value = 1
        self.dut.paddr.value = addr
        self.dut.pwdata.value = data

        await RisingEdge(self.dut.clk)
        self.dut.penable.value = 1

        # Wait for pready
        while self.dut.pready.value.integer != 1:
            await RisingEdge(self.dut.clk)

        await RisingEdge(self.dut.clk)
        self.dut.psel.value = 0
        self.dut.penable.value = 0
        self.dut.pwrite.value = 0

    async def read(self, addr):
        self.dut.psel.value = 1
        self.dut.penable.value = 0
        self.dut.pwrite.value = 0
        self.dut.paddr.value = addr

        await RisingEdge(self.dut.clk)
        self.dut.penable.value = 1

        # Wait for pready
        while self.dut.pready.value.integer != 1:
            await RisingEdge(self.dut.clk)

        await RisingEdge(self.dut.clk)
        data = self.dut.prdata.value.integer

        self.dut.psel.value = 0
        self.dut.penable.value = 0

        return data


@cocotb.test()
async def basic_apb_test(dut):
    """Basic APB read/write test"""

    # Start clock: 10ns period = 100 MHz
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    apb = APBMaster(dut)

    # Reset DUT
    await apb.reset()

    # Example: write value 0xABCD1234 to address 0x0000
    await apb.write(0x0000, 0xABCD1234)

    # Read back from address 0x0000
    read_data = await apb.read(0x0000)
    dut._log.info(f"Read data: 0x{read_data:08X}")

    assert read_data == 0xABCD1234, f"Read data mismatch: expected 0xABCD1234, got 0x{read_data:08X}"

    # Additional tests can be added here

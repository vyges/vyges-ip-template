#==============================================================================
# Example Cocotb Testbench
#==============================================================================
# Description: Example testbench demonstrating VCD waveform generation
# Author:      Vyges Team
# Date:        2025-01-20
# Version:     1.0.0
#==============================================================================

import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
import random

@cocotb.test()
async def test_basic(dut):
    """Basic functionality test"""
    # Create clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset sequence
    dut.rst_n.value = 0
    await Timer(100, units="ns")
    dut.rst_n.value = 1
    
    # Wait for reset to complete
    await RisingEdge(dut.clk)
    
    # Basic test sequence
    dut._log.info("Starting basic test sequence...")
    
    # Test 1: Basic functionality
    for i in range(5):
        await RisingEdge(dut.clk)
        dut._log.info(f"Clock cycle {i+1}")
    
    dut._log.info("Test 1 completed")

@cocotb.test()
async def test_random(dut):
    """Random stimulus test"""
    # Create clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset sequence
    dut.rst_n.value = 0
    await Timer(100, units="ns")
    dut.rst_n.value = 1
    
    # Wait for reset to complete
    await RisingEdge(dut.clk)
    
    # Random test sequence
    dut._log.info("Starting random test sequence...")
    
    # Test 2: Random stimulus
    for i in range(10):
        await RisingEdge(dut.clk)
        # Add random stimulus here if DUT has inputs
        dut._log.info(f"Random test cycle {i+1}")
    
    dut._log.info("Test 2 completed")

@cocotb.test()
async def test_edge_cases(dut):
    """Edge case test"""
    # Create clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset sequence
    dut.rst_n.value = 0
    await Timer(100, units="ns")
    dut.rst_n.value = 1
    
    # Wait for reset to complete
    await RisingEdge(dut.clk)
    
    # Edge case test sequence
    dut._log.info("Starting edge case test sequence...")
    
    # Test 3: Edge cases
    for i in range(15):
        await RisingEdge(dut.clk)
        dut._log.info(f"Edge case test cycle {i+1}")
    
    dut._log.info("Test 3 completed") 
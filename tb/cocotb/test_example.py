#=============================================================================
# Cocotb Test for example_module
#=============================================================================
# Description: Basic functional test for example_module
# Author: Vyges Team
# License: Apache-2.0
#=============================================================================

import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from cocotb.clock import Clock
import random

@cocotb.test()
async def test_reset_behavior(dut):
    """Test reset behavior of the module"""
    
    # Create clock
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Apply reset
    dut.rst_n_i.value = 0
    await RisingEdge(dut.clk_i)
    
    # Check reset values
    assert dut.data_out_o.value == 0, f"data_out_o should be 0 after reset, got {dut.data_out_o.value}"
    assert dut.valid_out_o.value == 0, f"valid_out_o should be 0 after reset, got {dut.valid_out_o.value}"
    
    # Release reset
    dut.rst_n_i.value = 1
    await RisingEdge(dut.clk_i)
    
    # Check post-reset behavior
    assert dut.valid_out_o.value == 1, f"valid_out_o should be 1 after reset release, got {dut.valid_out_o.value}"

@cocotb.test()
async def test_data_flow(dut):
    """Test basic data flow through the module"""
    
    # Create clock
    clock = Clock(dut.clk_i, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset
    dut.rst_n_i.value = 0
    await RisingEdge(dut.clk_i)
    dut.rst_n_i.value = 1
    await RisingEdge(dut.clk_i)
    
    # Test data values
    test_data = [0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0]
    
    for data in test_data:
        # Apply input data
        dut.data_in_i.value = data
        await RisingEdge(dut.clk_i)
        
        # Check output after one cycle delay
        await RisingEdge(dut.clk_i)
        assert dut.data_out_o.value == data, f"data_out_o mismatch: expected {data}, got {dut.data_out_o.value}"
        assert dut.valid_out_o.value == 1, f"valid_out_o should be 1, got {dut.valid_out_o.value}"

@cocotb.test()
async def test_parameterization(dut):
    """Test that the module works with different DATA_WIDTH parameters"""
    
    # This test would require recompiling with different parameters
    # For now, just verify the current parameter value
    assert dut.DATA_WIDTH.value == 8, f"Expected DATA_WIDTH=8, got {dut.DATA_WIDTH.value}"
    
    # Test with maximum value for 8-bit
    dut.rst_n_i.value = 0
    await RisingEdge(dut.clk_i)
    dut.rst_n_i.value = 1
    await RisingEdge(dut.clk_i)
    
    # Test edge case values
    edge_cases = [0x00, 0xFF, 0x55, 0xAA]
    
    for data in edge_cases:
        dut.data_in_i.value = data
        await RisingEdge(dut.clk_i)
        await RisingEdge(dut.clk_i)
        assert dut.data_out_o.value == data, f"Edge case failed: expected {data}, got {dut.data_out_o.value}" 
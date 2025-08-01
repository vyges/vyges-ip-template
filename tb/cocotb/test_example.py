#==============================================================================
# Example Cocotb Testbench
#==============================================================================
# Description: Simple example testbench demonstrating cocotb usage
# Author:      Vyges Team
# Date:        2025-01-20
# Version:     1.0.0
# License:     Apache-2.0
#
# This is a template test file. Replace with actual test logic for your IP.
#==============================================================================

import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
import random

#==============================================================================
# Test Configuration
#==============================================================================

# Test parameters (customize for your IP)
CLOCK_PERIOD = 10  # ns
SIMULATION_TIME = 1000  # ns

#==============================================================================
# Test Functions
#==============================================================================

@cocotb.test()
async def test_basic_operation(dut):
    """Basic functionality test - minimal test that just verifies compilation and basic operation"""
    
    # Create clock
    clock = Clock(dut.clk, CLOCK_PERIOD, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset the design
    dut.rst_n.value = 0
    await Timer(CLOCK_PERIOD * 2, units="ns")
    dut.rst_n.value = 1
    
    # Wait for a few clock cycles
    await Timer(CLOCK_PERIOD * 5, units="ns")
    
    # Basic assertion - check that the design is not stuck
    assert dut.rst_n.value == 1, "Reset should be deasserted"
    
    print("✅ Basic operation test passed")

@cocotb.test()
async def test_signal_check(dut):
    """Signal connectivity test - verify that all signals are properly connected"""
    
    # Create clock
    clock = Clock(dut.clk, CLOCK_PERIOD, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset the design
    dut.rst_n.value = 0
    await Timer(CLOCK_PERIOD * 2, units="ns")
    dut.rst_n.value = 1
    
    # Check that signals are accessible (not None)
    assert dut.clk is not None, "Clock signal should be accessible"
    assert dut.rst_n is not None, "Reset signal should be accessible"
    
    # Add more signal checks based on your IP's interface
    # Example:
    # assert dut.data_in is not None, "Data input signal should be accessible"
    # assert dut.data_out is not None, "Data output signal should be accessible"
    
    print("✅ Signal connectivity test passed")

#==============================================================================
# Helper Functions (customize for your IP)
#==============================================================================

async def apply_stimulus(dut, data_in):
    """Apply input stimulus to the design"""
    # Customize this function based on your IP's interface
    # Example:
    # dut.data_in.value = data_in
    # await RisingEdge(dut.clk)
    pass

async def check_output(dut, expected_data):
    """Check output values against expected results"""
    # Customize this function based on your IP's interface
    # Example:
    # actual_data = dut.data_out.value
    # assert actual_data == expected_data, f"Expected {expected_data}, got {actual_data}"
    pass

#==============================================================================
# Additional Test Examples (uncomment and customize as needed)
#==============================================================================

# @cocotb.test()
# async def test_data_processing(dut):
#     """Test data processing functionality"""
#     
#     # Create clock
#     clock = Clock(dut.clk, CLOCK_PERIOD, units="ns")
#     cocotb.start_soon(clock.start())
#     
#     # Reset
#     dut.rst_n.value = 0
#     await Timer(CLOCK_PERIOD * 2, units="ns")
#     dut.rst_n.value = 1
#     
#     # Test data processing
#     test_data = [0x01, 0x02, 0x03, 0x04]
#     for data in test_data:
#         await apply_stimulus(dut, data)
#         await Timer(CLOCK_PERIOD * 2, units="ns")
#         # await check_output(dut, expected_result)
#     
#     print("✅ Data processing test passed")

# @cocotb.test()
# async def test_edge_cases(dut):
#     """Test edge cases and boundary conditions"""
#     
#     # Create clock
#     clock = Clock(dut.clk, CLOCK_PERIOD, units="ns")
#     cocotb.start_soon(clock.start())
#     
#     # Reset
#     dut.rst_n.value = 0
#     await Timer(CLOCK_PERIOD * 2, units="ns")
#     dut.rst_n.value = 1
#     
#     # Test edge cases
#     # Example: test with maximum/minimum values
#     # await apply_stimulus(dut, 0xFF)  # Max value
#     # await apply_stimulus(dut, 0x00)  # Min value
#     
#     print("✅ Edge cases test passed")

#==============================================================================
# Test Configuration and Setup
#==============================================================================

def test_config():
    """Return test configuration for this testbench"""
    return {
        "clock_period": CLOCK_PERIOD,
        "simulation_time": SIMULATION_TIME,
        "test_modules": ["test_basic_operation", "test_signal_check"],
        "description": "Example cocotb testbench for IP template"
    }

#==============================================================================
# Notes for IP Developers
#==============================================================================
#
# 1. Replace the example_module interface with your actual IP interface
# 2. Add proper signal definitions and test logic for your specific IP
# 3. Include comprehensive test cases covering:
#    - Basic functionality
#    - Edge cases and boundary conditions
#    - Error conditions and recovery
#    - Performance and timing requirements
# 4. Add proper assertions and coverage collection
# 5. Document any IP-specific test requirements or constraints
#
#============================================================================== 
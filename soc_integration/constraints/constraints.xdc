#=============================================================================
# XDC Constraints for example_module
#=============================================================================
# Description: FPGA pin constraints and timing
# Author: Vyges Team
# License: Apache-2.0
#=============================================================================

# Clock pin assignment (example for Arty-A7-35)
set_property PACKAGE_PIN W5 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports clk_i]

# Reset pin assignment
set_property PACKAGE_PIN U18 [get_ports rst_n_i]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n_i]

# Data input pins (8-bit)
set_property PACKAGE_PIN U16 [get_ports {data_in_i[0]}]
set_property PACKAGE_PIN E19 [get_ports {data_in_i[1]}]
set_property PACKAGE_PIN U19 [get_ports {data_in_i[2]}]
set_property PACKAGE_PIN V13 [get_ports {data_in_i[3]}]
set_property PACKAGE_PIN V14 [get_ports {data_in_i[4]}]
set_property PACKAGE_PIN V15 [get_ports {data_in_i[5]}]
set_property PACKAGE_PIN W13 [get_ports {data_in_i[6]}]
set_property PACKAGE_PIN W14 [get_ports {data_in_i[7]}]

# Data output pins (8-bit)
set_property PACKAGE_PIN U15 [get_ports {data_out_o[0]}]
set_property PACKAGE_PIN U14 [get_ports {data_out_o[1]}]
set_property PACKAGE_PIN V12 [get_ports {data_out_o[2]}]
set_property PACKAGE_PIN V11 [get_ports {data_out_o[3]}]
set_property PACKAGE_PIN V10 [get_ports {data_out_o[4]}]
set_property PACKAGE_PIN V9  [get_ports {data_out_o[5]}]
set_property PACKAGE_PIN V8  [get_ports {data_out_o[6]}]
set_property PACKAGE_PIN V7  [get_ports {data_out_o[7]}]

# Valid output pin
set_property PACKAGE_PIN U16 [get_ports valid_out_o]

# I/O standards for all pins
set_property IOSTANDARD LVCMOS33 [get_ports {data_in_i[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {data_out_o[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports valid_out_o]

# Timing constraints
create_clock -period 10.000 -name clk_i [get_ports clk_i]
set_clock_uncertainty 0.1 [get_clocks clk_i]

# Input delays
set_input_delay -clock clk_i -max 1.0 [get_ports data_in_i]
set_input_delay -clock clk_i -max 0.5 [get_ports rst_n_i]

# Output delays
set_output_delay -clock clk_i -max 1.0 [get_ports data_out_o]
set_output_delay -clock clk_i -max 0.5 [get_ports valid_out_o]

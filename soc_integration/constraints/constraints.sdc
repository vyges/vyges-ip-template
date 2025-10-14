#=============================================================================
# SDC Constraints for example_module
#=============================================================================
# Description: Timing constraints for ASIC synthesis
# Author: Vyges Team
# License: Apache-2.0
#=============================================================================

# Clock definition
create_clock -name clk_i -period 10.0 [get_ports clk_i]

# Clock uncertainty
set_clock_uncertainty 0.1 [get_clocks clk_i]

# Input delays
set_input_delay -clock clk_i -max 1.0 [get_ports data_in_i]
set_input_delay -clock clk_i -max 0.5 [get_ports rst_n_i]

# Output delays
set_output_delay -clock clk_i -max 1.0 [get_ports data_out_o]
set_output_delay -clock clk_i -max 0.5 [get_ports valid_out_o]

# False paths
set_false_path -from [get_ports rst_n_i] -to [get_ports data_out_o]
set_false_path -from [get_ports rst_n_i] -to [get_ports valid_out_o]

# Load capacitance
set_load 0.1 [get_ports data_out_o]
set_load 0.05 [get_ports valid_out_o]

# Drive strength
set_drive 0.1 [get_ports clk_i]
set_drive 0.1 [get_ports rst_n_i]
set_drive 0.1 [get_ports data_in_i]

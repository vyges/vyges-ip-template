# Simulation Directory

This directory contains simulation configurations, results, and waveforms for comprehensive verification of IP blocks, supporting digital, analog, and mixed-signal simulation.

## Directory Structure

```
simulation/
├── configs/          # Simulation configuration files
├── results/          # Simulation results and reports
└── waveforms/        # Waveform files and plots
```

## Simulation Types

### Digital Simulation
- **Tool**: Verilator, ModelSim, Icarus Verilog, VCS
- **Purpose**: Verify digital RTL functionality
- **Files**: Testbench outputs, coverage reports, timing analysis
- **Integration**: Works with SystemVerilog, VHDL, Cocotb

### Analog Simulation
- **Tool**: ngspice, Xyce, Spectre
- **Purpose**: Verify analog circuit performance
- **Files**: SPICE simulation results, AC/DC analysis, Monte Carlo
- **Integration**: Works with SPICE netlists, Verilog-A models

### Mixed-Signal Simulation
- **Tool**: ngspice (xspice), Xyce, ModelSim-AMS
- **Purpose**: Verify digital-analog interaction
- **Files**: Combined simulation results, interface verification
- **Integration**: Digital RTL + analog SPICE netlists

## Configuration Files (configs/)

### Digital Simulation Configs
- `tb_config.json` - Testbench configuration
- `coverage_config.json` - Coverage settings
- `verilator_config.vlt` - Verilator configuration
- `questa_config.do` - ModelSim/Questa configuration
- `vcs_config.f` - VCS configuration

### Analog Simulation Configs
- `dc_analysis.sp` - DC operating point analysis
- `ac_analysis.sp` - AC frequency response
- `transient_analysis.sp` - Transient simulation
- `monte_carlo.sp` - Monte Carlo analysis
- `corner_analysis.sp` - Process corner analysis
- `noise_analysis.sp` - Noise analysis

### Mixed-Signal Configs
- `mixed_signal.sp` - Combined digital-analog simulation
- `system_verification.sp` - System-level verification
- `interface_test.sp` - Digital-analog interface testing

### FPGA Simulation Configs
- `fpga_tb_config.json` - FPGA testbench configuration
- `fpga_timing.sdc` - FPGA timing constraints
- `fpga_synthesis.tcl` - FPGA synthesis scripts

### ASIC Simulation Configs
- `asic_tb_config.json` - ASIC testbench configuration
- `asic_timing.sdc` - ASIC timing constraints
- `asic_synthesis.tcl` - ASIC synthesis scripts

## Results Directory (results/)

### Digital Results
- `coverage_report.html` - Code coverage reports
- `functional_test_results.txt` - Functional test results
- `timing_analysis.txt` - Timing analysis results
- `linting_report.txt` - Code quality reports

### Analog Results
- `dc_results.txt` - DC operating point results
- `ac_results.txt` - AC analysis results
- `transient_results.txt` - Transient simulation results
- `monte_carlo_results.txt` - Monte Carlo analysis results
- `noise_results.txt` - Noise analysis results

### Mixed-Signal Results
- `system_verification_results.txt` - System-level verification
- `performance_characterization.txt` - Performance metrics
- `interface_verification.txt` - Interface verification results

### FPGA Results
- `fpga_timing_report.txt` - FPGA timing analysis
- `fpga_resource_report.txt` - FPGA resource utilization
- `fpga_power_report.txt` - FPGA power analysis

### ASIC Results
- `asic_timing_report.txt` - ASIC timing analysis
- `asic_area_report.txt` - ASIC area analysis
- `asic_power_report.txt` - ASIC power analysis

## Waveforms Directory (waveforms/)

### Digital Waveforms
- `tb_waves.vcd` - Digital testbench waveforms
- `control_signals.vcd` - Control signal waveforms
- `data_signals.vcd` - Data signal waveforms

### Analog Waveforms
- `analog_signals.raw` - Analog signal waveforms
- `comparator_outputs.raw` - Comparator output waveforms
- `dac_outputs.raw` - DAC output waveforms
- `adc_outputs.raw` - ADC output waveforms

### Mixed-Signal Waveforms
- `adc_conversion.raw` - ADC conversion waveforms
- `system_response.raw` - System response waveforms
- `interface_signals.raw` - Interface signal waveforms

### FPGA Waveforms
- `fpga_tb_waves.vcd` - FPGA testbench waveforms
- `fpga_timing_waves.vcd` - FPGA timing waveforms

### ASIC Waveforms
- `asic_tb_waves.vcd` - ASIC testbench waveforms
- `asic_timing_waves.vcd` - ASIC timing waveforms

## Simulation Workflow

### 1. Setup
- Configure simulation parameters in `configs/`
- Set up testbench environment
- Define simulation scenarios

### 2. Run
- Execute simulations using appropriate tools
- Monitor simulation progress
- Handle simulation errors

### 3. Analyze
- Review results in `results/`
- Generate performance metrics
- Validate against specifications

### 4. Visualize
- View waveforms in `waveforms/`
- Create plots and graphs
- Document key findings

### 5. Document
- Update documentation with findings
- Generate simulation reports
- Archive important results

## Tools Integration

### Digital Tools
- **Verilator**: Fast digital simulation
- **Cocotb**: Python-based testbenches
- **GTKWave**: Waveform viewer
- **ModelSim/Questa**: Commercial simulation
- **VCS**: Synopsys simulation

### Analog Tools
- **ngspice**: Circuit simulation
- **Xyce**: Parallel circuit simulation
- **Spectre**: Cadence simulation
- **Gnuplot**: Waveform plotting

### Mixed-Signal Tools
- **ngspice (xspice)**: Mixed-signal simulation
- **Xyce**: Advanced mixed-signal capabilities
- **ModelSim-AMS**: Mixed-signal simulation

### FPGA Tools
- **Vivado**: Xilinx FPGA tools
- **Quartus**: Intel FPGA tools
- **ModelSim**: FPGA simulation

### ASIC Tools
- **OpenROAD**: Open-source ASIC flow
- **Yosys**: Synthesis
- **OpenLane**: Complete ASIC flow

## Performance Metrics

### Digital Performance
- **Functionality**: Correct operation verification
- **Timing**: Setup/hold time compliance
- **Coverage**: Code and functional coverage
- **Power**: Power consumption analysis

### Analog Performance
- **Gain**: Voltage/current gain specifications
- **Bandwidth**: Frequency response bandwidth
- **Noise**: Input-referred noise density
- **Linearity**: DNL/INL specifications

### Mixed-Signal Performance
- **Resolution**: Effective number of bits (ENOB)
- **Sampling Rate**: Maximum conversion rate
- **SNR/SFDR**: Signal-to-noise ratio, spurious-free dynamic range
- **Power Efficiency**: Power per operation

### FPGA Performance
- **Resource Utilization**: LUT, FF, BRAM usage
- **Timing**: Clock frequency, critical path
- **Power**: Dynamic and static power consumption

### ASIC Performance
- **Area**: Cell area utilization
- **Timing**: Critical path delay
- **Power**: Total power consumption
- **Yield**: Manufacturing yield considerations 
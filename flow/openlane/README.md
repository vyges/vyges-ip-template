# OpenLane ASIC Flow

This directory contains OpenLane ASIC implementation flows for the IP block, providing a complete open-source digital ASIC design flow from RTL to GDSII.

## Directory Structure

```
openlane/
├── configs/               # OpenLane configuration files
│   ├── config.json       # Main configuration file
│   ├── config.tcl        # TCL configuration
│   └── constraints.sdc   # Timing constraints
├── scripts/              # Custom TCL scripts
│   ├── pre_flow.tcl      # Pre-flow setup scripts
│   ├── post_flow.tcl     # Post-flow analysis scripts
│   └── custom.tcl        # Custom implementation scripts
├── reports/              # Implementation reports
│   ├── synthesis/        # Synthesis reports
│   ├── floorplan/        # Floorplanning reports
│   ├── placement/        # Placement reports
│   ├── routing/          # Routing reports
│   └── final/            # Final implementation reports
├── results/              # Implementation results
│   ├── netlist/          # Synthesized netlists
│   ├── layout/           # Layout files
│   ├── gds/              # GDSII files
│   └── lef/              # LEF files
└── logs/                 # Implementation logs
```

## OpenLane Flow Overview

### Complete Digital ASIC Flow
```
RTL → Synthesis → Floorplan → Placement → CTS → Routing → GDSII
```

### Flow Stages

1. **Synthesis**
   - RTL to gate-level netlist conversion
   - Technology mapping to standard cells
   - Timing and area optimization

2. **Floorplanning**
   - Die size and aspect ratio definition
   - Core area and I/O placement
   - Power distribution planning

3. **Placement**
   - Standard cell placement
   - Timing-driven placement
   - Congestion-aware placement

4. **Clock Tree Synthesis (CTS)**
   - Clock distribution network
   - Clock skew optimization
   - Clock routing

5. **Routing**
   - Global routing
   - Detailed routing
   - Design rule compliance

6. **Final Implementation**
   - GDSII generation
   - LEF extraction
   - Final verification

## Configuration

### Main Configuration (config.json)
```json
{
  "DESIGN_NAME": "your_ip_name",
  "VERILOG_FILES": "dir::../../rtl/*.v",
  "CLOCK_PORT": "clk",
  "CLOCK_PERIOD": 10.0,
  "FP_CORE_UTIL": 50,
  "PL_TARGET_DENSITY": 0.5,
  "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
  "CLK_BUFFER": "sky130_fd_sc_hd__clkbuf_4",
  "ROUTING_CORES": 4
}
```

### Key Parameters
- **DESIGN_NAME**: Name of the IP block
- **VERILOG_FILES**: Path to RTL files
- **CLOCK_PORT**: Primary clock signal
- **CLOCK_PERIOD**: Target clock period in ns
- **FP_CORE_UTIL**: Floorplan core utilization
- **PL_TARGET_DENSITY**: Placement target density

## Usage

### Basic Flow Execution
```bash
cd flow/openlane
make
```

### Interactive Mode
```bash
cd flow/openlane
make interactive
```

### Custom Configuration
```bash
cd flow/openlane
make DESIGN_CONFIG=configs/custom_config.json
```

### Flow Stages
```bash
# Run specific stages
make synthesis
make floorplan
make placement
make routing
make final
```

## Supported PDKs

### SkyWater 130nm
- **PDK**: sky130A, sky130B
- **Standard Cells**: sky130_fd_sc_hd, sky130_fd_sc_hs, sky130_fd_sc_ls
- **I/O Cells**: sky130_fd_io
- **Special Cells**: sky130_fd_sc_hd__fill_*

### GlobalFoundries 180nm
- **PDK**: gf180mcu
- **Standard Cells**: gf180mcu_fd_sc_mcu*
- **I/O Cells**: gf180mcu_fd_io*
- **Special Cells**: Various fill and tap cells

## Reports and Analysis

### Synthesis Reports
- **Area**: Cell area utilization
- **Timing**: Setup/hold timing analysis
- **Power**: Power estimation
- **Resources**: Cell count and types

### Floorplan Reports
- **Die Size**: Core and die dimensions
- **Utilization**: Core area utilization
- **I/O Placement**: Pin assignments
- **Power Grid**: Power distribution analysis

### Placement Reports
- **Cell Placement**: Standard cell locations
- **Timing**: Placement-based timing analysis
- **Congestion**: Routing congestion analysis
- **Power**: Power distribution analysis

### Routing Reports
- **Routing Completion**: Route success/failure
- **Timing**: Post-route timing analysis
- **DRC**: Design rule check results
- **LVS**: Layout vs schematic verification

### Final Reports
- **GDSII**: Final layout generation
- **LEF**: Abstract layout extraction
- **Timing**: Final timing analysis
- **Power**: Final power analysis

## Best Practices

### RTL Design
- Use synchronous design practices
- Implement proper clock domain crossing
- Optimize for target technology
- Follow synthesis-friendly coding styles

### Configuration
- Set realistic timing constraints
- Configure appropriate utilization targets
- Use technology-specific optimizations
- Monitor resource usage

### Implementation
- Monitor flow progress and logs
- Analyze intermediate results
- Optimize configuration parameters
- Validate final implementation

### Verification
- Perform functional simulation
- Validate timing requirements
- Check power consumption
- Verify DRC/LVS compliance

## Integration with Vyges

### Metadata Integration
- Update vyges-metadata.json with ASIC results
- Include area, timing, and power metrics
- Document PDK and technology information
- Track implementation status

### CI/CD Integration
- Automated OpenLane flow execution
- Regression testing and validation
- Performance tracking and reporting
- Quality metrics monitoring

## Troubleshooting

### Common Issues
- **Synthesis Failures**: Check RTL syntax and constraints
- **Placement Issues**: Adjust density and utilization targets
- **Routing Failures**: Optimize placement and congestion
- **Timing Violations**: Review constraints and optimization settings

### Debugging
- Check OpenLane logs for detailed error messages
- Analyze intermediate reports for issues
- Use interactive mode for step-by-step debugging
- Validate configuration parameters

## References

- [OpenLane Documentation](https://openlane.readthedocs.io/)
- [Open PDKs](https://github.com/google/skywater-pdk)
- [OpenROAD](https://theopenroadproject.org/)
- [Yosys](http://www.clifford.at/yosys/) 
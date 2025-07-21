# Analog Design Directory

This directory contains analog design files following the Efabless open-source analog design flow recommendations. This structure supports mixed-signal IP development with both digital and analog components.

## Directory Structure

```
analog/
├── xschem/          # Schematic entry and symbol files (Xschem)
├── magic/           # Layout database files (Magic)
├── netlist/         # SPICE netlists for simulation
├── gds/             # Final GDS layout files
├── lef/             # Abstract layout views (LEF)
└── macros/          # Reusable analog components (symbolic links)
```

## Tool Integration

### Schematic Entry (xschem/)
- **Purpose**: Create and edit analog circuit schematics
- **Tool**: Xschem (open-source schematic editor)
- **Files**: `.sch` (schematic), `.sym` (symbols)
- **Output**: SPICE netlists for simulation
- **Integration**: Works with ngspice, Xyce for simulation

### Layout Design (magic/)
- **Purpose**: Create physical layout of analog circuits
- **Tool**: Magic (open-source layout editor)
- **Files**: `.mag` (Magic database)
- **Features**: Device extraction, parasitic extraction, DRC checking
- **Integration**: Exports to GDS, LEF for digital integration

### Netlist Generation (netlist/)
- **Purpose**: SPICE netlists for circuit simulation
- **Sources**: Xschem schematics, Magic layout extraction
- **Tools**: ngspice, Xyce for simulation
- **Files**: `.sp` (SPICE netlists)
- **Integration**: Mixed-signal simulation with digital RTL

### Layout Files (gds/, lef/)
- **GDS**: Final layout for fabrication (Graphic Design System)
- **LEF**: Abstract layout views for digital integration
- **Tools**: Magic, KLayout for viewing and editing
- **Integration**: Merges with digital layout for tapeout

### Reusable Components (macros/)
- **Purpose**: Symbolic links to reusable analog IP blocks
- **Structure**: Each macro should be its own repository
- **Examples**: Bandgap references, PLLs, DACs, comparators, ADCs
- **Integration**: Enables modular analog design

## Workflow Integration

This analog design flow integrates with the existing digital flow:

1. **Digital RTL** (`../rtl/`) - Digital control logic
2. **Analog Circuits** (`analog/`) - Analog signal path
3. **Mixed-Signal Simulation** (`../simulation/`) - Combined verification
4. **Layout Verification** (`../layout/`) - DRC/LVS checks
5. **Integration** (`../integration/`) - System-level integration

## Mixed-Signal IP Development

### Digital-Analog Interface
- **Digital Control**: SystemVerilog RTL for control logic
- **Analog Core**: SPICE netlists for analog circuits
- **Interface**: Mixed-signal simulation for verification
- **Integration**: Combined layout for tapeout

### Example Mixed-Signal IPs
- **ADCs**: Digital control + analog sampling circuits
- **DACs**: Digital input + analog output stages
- **PLLs**: Digital phase detector + analog VCO
- **Sensors**: Analog front-end + digital processing

## Open Source EDA Tools

### Schematic and Layout
- **Xschem**: Schematic entry and netlist generation
- **Magic**: Layout editor with extraction capabilities
- **KLayout**: Layout viewer and DRC

### Simulation
- **ngspice**: Circuit simulation with mixed-signal support
- **Xyce**: Parallel circuit simulation
- **Verilator**: Digital simulation with analog interfaces

### Verification
- **Netgen**: LVS verification
- **Magic**: DRC checking
- **KLayout**: Advanced DRC and visualization

## PDK Integration

### Open PDKs Supported
- **SkyWater 130nm**: sky130A, sky130B
- **GlobalFoundries 180nm**: gf180mcu
- **IHP 130nm**: SG13G2 BiCMOS

### PDK Setup
```bash
# Install open PDKs
git clone https://github.com/google/skywater-pdk
cd skywater-pdk
make timing

# Set environment variables
export PDK_ROOT=/path/to/pdk
export PDK=sky130A
```

## References

- [Efabless Analog Design Flow](http://opencircuitdesign.com/analog_flow/index.html)
- [Open Circuit Design Tools](http://opencircuitdesign.com/)
- [Open PDKs](https://github.com/google/skywater-pdk)
- [Magic Layout Editor](http://opencircuitdesign.com/magic/)
- [Xschem Schematic Editor](http://repo.hu/projects/xschem/) 
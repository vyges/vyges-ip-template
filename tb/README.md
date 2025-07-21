# Testbench Structure

This directory contains testbench infrastructure for the Vyges IP template, supporting both SystemVerilog and Cocotb testbenches with multiple simulators.

## Directory Structure

```
tb/
├── sv_tb/           # SystemVerilog testbenches
│   ├── Makefile     # SV testbench Makefile
│   └── tb_example.sv # Example testbench
├── cocotb/          # Cocotb testbenches
│   ├── Makefile     # Cocotb testbench Makefile
│   └── test_example.py # Example testbench
└── README.md        # This file
```

## Usage

### Master Makefile (from project root)

```bash
# Run basic test with default settings (SV + Icarus)
make test_basic

# Run with specific testbench type and simulator
make test_basic TESTBENCH_TYPE=cocotb SIM=verilator

# Run all tests
make test_all

# View waveforms
make waves

# Clean all artifacts
make clean

# Get help
make help
```

### SystemVerilog Testbench

```bash
cd tb/sv_tb

# Run with Icarus Verilog (default)
make test_basic

# Run with Verilator
make test_basic SIM=verilator

# View waveforms
make waves

# Clean
make clean
```

### Cocotb Testbench

```bash
cd tb/cocotb

# Run with Icarus Verilog (default)
make test_basic

# Run with Verilator
make test_basic SIM=verilator

# View waveforms
make waves

# Clean
make clean
```

## Supported Simulators

- **Icarus Verilog**: Fast, open-source Verilog simulator
- **Verilator**: High-performance SystemVerilog simulator with coverage support

## Waveform Generation

Both testbench types generate VCD (Value Change Dump) files for waveform viewing:

- **Location**: `tb/sv_tb/waveforms/` or `tb/cocotb/waveforms/`
- **Viewer**: Use GTKWave or any VCD-compatible viewer
- **Command**: `gtkwave waveforms/tb_example.vcd`

## Configuration

### Environment Variables

- `SIM`: Simulator (icarus, verilator)
- `TESTBENCH_TYPE`: Testbench type (sv, cocotb)
- `TOP_MODULE`: Top module name for simulation

### Customization

1. **RTL Files**: Place your RTL files in `rtl/` directory
2. **Testbench Files**: 
   - SV: Create `tb_*.sv` files in `tb/sv_tb/`
   - Cocotb: Create `test_*.py` files in `tb/cocotb/`
3. **Top Module**: Update `TOP_MODULE` variable in respective Makefiles

## Example Workflow

1. **Setup**: Place your RTL files in `rtl/`
2. **Create Testbench**: Add testbench files to appropriate directory
3. **Run Tests**: Use master Makefile from project root
4. **View Results**: Check waveforms and reports
5. **Iterate**: Modify RTL and testbenches as needed

## Integration with CI/CD

The testbench infrastructure integrates with the GitHub Actions workflow:

- **Automatic Testing**: CI runs tests on all supported simulators
- **Waveform Artifacts**: VCD files are preserved as build artifacts
- **Coverage Reports**: Verilator coverage data is collected
- **Multi-Simulator**: Tests run on both Icarus and Verilator

## Best Practices

1. **Naming Convention**: Use `tb_` prefix for SV testbenches, `test_` prefix for Cocotb
2. **VCD Generation**: Always include waveform dump in testbenches
3. **Reset Sequence**: Implement proper reset handling
4. **Timeout**: Include simulation timeout to prevent hanging
5. **Logging**: Use appropriate logging for debugging 
# Testbench Directory

This directory contains testbenches and verification infrastructure for the IP block.

## Current Structure

- `sv_tb/` - SystemVerilog testbenches
- `uvm_tb/` - UVM testbenches  
- `cocotb/` - Cocotb testbenches

## VyContext Enhancement

When VyContext detects the **verification** role, it will enhance this directory to:

```
tb/ → verification/
├── sv_tb/                  # SystemVerilog testbenches (existing)
├── uvm_tb/                 # UVM testbenches (existing)
├── cocotb/                 # Cocotb testbenches (existing)
├── coverage/               # Coverage models and bindings
│   ├── coverage_models.sv
│   └── coverage_bindings.sv
├── formal/                 # Formal properties and assertions
│   ├── properties.sv
│   └── constraints.sv
├── stimulus/               # Directed & constrained tests
│   ├── directed_tests.sv
│   └── constrained_tests.py
├── results/                # Regression logs / coverage reports
│   ├── regression_logs/
│   └── coverage_reports/
└── config.yaml            # Verification manifest
```

## Benefits of Unified Structure

1. **CI Integration**: One-line verification commands
2. **Clear Scope**: Verification intent is explicit
3. **Automated Regression**: `config.yaml` enables automated testing
4. **Results Tracking**: Centralized regression logs and coverage reports

## Usage Examples

### Running Verification
```bash
# VyContext automatically:
# 1. Creates unified verification/ structure
# 2. Migrates existing tb/ content
# 3. Sets up formal verification tools
# 4. Shows verification-relevant files only
```

### VyContext Role Switching

When switching to **verification** role:
```bash
# VyContext automatically:
# 1. Creates verification/ directory structure
# 2. Sets up SymbiYosys, Z3, and other formal tools
# 3. Shows only verification-relevant directories
# 4. Hides SoC integration and FPGA directories
```

## Tools Required (from vyges-ip.yml)

```yaml
verification:
  tools_required:
    - name: verilator
      version: "5.018"
      license: "LGPL-3.0"
    - name: yosys
      version: "0.46"
      license: "ISC"
    - name: symbiyosys
      version: "1.8"
      license: "ISC"
    - name: z3
      version: "4.12.2"
      license: "MIT"
```

## File Extensions

Verification role focuses on:
- `.sv` - SystemVerilog files
- `.svh` - SystemVerilog header files
- `.sva` - SystemVerilog assertions
- `.py` - Python test scripts
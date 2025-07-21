[![Vyges IP Template](https://img.shields.io/badge/template-vyges--ip--template-blue)](https://github.com/vyges/vyges-ip-template)
[![Use this template](https://img.shields.io/badge/Use%20this%20template-vyges--ip--template-brightgreen?style=for-the-badge)](https://github.com/vyges/vyges-ip-template/generate)
![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)
![Build](https://github.com/vyges/vyges-ip-template/actions/workflows/test.yml/badge.svg)

# Vyges IP Template

A minimal, production-ready template for building reusable SystemVerilog IP blocks with the Vyges ecosystem.

## 🚀 Quickstart

1. **Create Repository from Template:**
   - Go to [https://github.com/vyges/vyges-ip-template/generate](https://github.com/vyges/vyges-ip-template/generate)
   - Click "Use this template"
   - Name your repository (e.g., `uart-controller`)
   - Create repository

2. **Clone Your New Repository:**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```

3. **Initialize your project:**
   ```bash
   vyges init --interactive
   ```

4. **Simulate a Hello World test:**
   ```bash
   vyges test --simulation
   ```

5. **Next steps:**
   - Edit your RTL in `rtl/`
   - Add testbenches in `tb/`
   - See [Developer_Guide.md](Developer_Guide.md) for advanced usage, project structure, and customization.

**✅ This approach avoids all remote configuration issues!**

## 🔧 Project Structure

This template provides a comprehensive structure supporting digital, analog, and mixed-signal IP development:

```
ip-block/
├── rtl/                    # SystemVerilog RTL implementation
├── analog/                 # Analog design files (Efabless flow)
│   ├── xschem/            # Schematic entry (Xschem)
│   ├── magic/             # Layout database (Magic)
│   ├── netlist/           # SPICE netlists
│   ├── gds/               # Final GDS layout
│   ├── lef/               # Abstract layout views
│   └── macros/            # Reusable analog components
├── simulation/             # Mixed-signal simulation
│   ├── configs/           # Simulation configurations
│   ├── results/           # Simulation results
│   └── waveforms/         # Waveform files
├── layout/                 # Layout verification
│   ├── constraints/       # Layout constraints
│   ├── lvs/              # Layout vs Schematic
│   └── drc/              # Design Rule Checks
├── tb/                     # Testbenches and verification
├── flow/                   # EDA tool flows
│   ├── yosys/              # Generic synthesis (PDK-agnostic)
│   ├── openlane/           # ASIC synthesis (PDK-required)
│   ├── fpga/               # FPGA synthesis (PDK-agnostic)
│   └── vivado/             # Xilinx FPGA flows
├── integration/            # System integration examples
├── packaging/              # IP packaging and distribution
└── .github/workflows/      # CI/CD automation
```

### Design Flow Support

- **Digital Flow**: RTL synthesis, verification, FPGA/ASIC implementation
- **Analog Flow**: Schematic entry, layout, SPICE simulation, DRC/LVS
- **Mixed-Signal Flow**: Combined digital-analog verification and integration

## 🔧 GitHub Actions Workflow

This template includes a comprehensive GitHub Actions workflow (`build-and-test.yml`) that provides automated testing and validation for your IP projects.

### Features

- ✅ **Disabled by default** - Only runs when manually triggered
- ✅ **Configurable testing** - Choose which components to test
- ✅ **Multiple simulators** - Support for Verilator and Icarus Verilog
- ✅ **Multiple platforms** - Support for ASIC and FPGA targets
- ✅ **Complete EDA toolchain** - Full open-source ASIC design flow
- ✅ **Project validation** - Checks project structure and metadata
- ✅ **Linting** - SystemVerilog code quality checks
- ✅ **Simulation testing** - Testbench execution and validation
- ✅ **Synthesis checking** - Flow configuration validation

### Quick Start

1. **Enable the workflow** in your IP repository (see detailed instructions below)
2. **Go to Actions tab** and select "Build and Test IP"
3. **Click "Run workflow"** and configure your test options
4. **Review results** and artifacts

### Enabling the Workflow

The workflow is **disabled by default** for the template repository. To enable it in your IP repository:

1. Edit `.github/workflows/build-and-test.yml`
2. Find the `check-enabled` job
3. Change the line:
   ```yaml
   echo "should-run=false" >> $GITHUB_OUTPUT
   ```
   to:
   ```yaml
   echo "should-run=true" >> $GITHUB_OUTPUT
   ```

### What's Included

The workflow automatically installs a complete open-source EDA toolchain including:
- **Simulation**: Verilator 5.026, Icarus Verilog, GHDL
- **Synthesis**: Yosys ≥0.39 with VHDL plugin
- **Layout**: KLayout, Magic, Netgen
- **Physical Design**: OpenROAD tools (TritonFPlan, RePlAce, TritonCTS, FastRoute, TritonRoute)
- **Circuit Design**: XSChem, ngspice
- **Process Kits**: Open PDKs (sky130, gf180mcu)
- **Languages**: SystemVerilog, VHDL, Python (cocotb), Ada

**📖 For complete documentation, see [`.github/workflows/README.md`](.github/workflows/README.md)**

## 📚 Documentation

- **[Developer_Guide.md](Developer_Guide.md)** - Comprehensive development guide with AI-assisted workflows
- **[.github/workflows/README.md](.github/workflows/README.md)** - Detailed GitHub Actions workflow documentation
- **[vyges-metadata-spec/](https://github.com/vyges/vyges-metadata-spec)** - Metadata specification and schema

## 🛠️ Development Tools

This template is designed to work with the complete Vyges ecosystem:

- **Vyges CLI** - Command-line interface for IP development
- **Vyges Catalog** - IP catalog and discovery platform
- **Vyges IDE** - Integrated development environment
- **AI-assisted development** - Comprehensive AI context and guidance

## 📄 License

This template is licensed under the Apache License 2.0. See [LICENSE](LICENSE) for details.

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📞 Support

- **Documentation**: [Developer_Guide.md](Developer_Guide.md)
- **Issues**: [GitHub Issues](https://github.com/vyges/vyges-ip-template/issues)
- **Discussions**: [GitHub Discussions](https://github.com/vyges/vyges-ip-template/discussions)

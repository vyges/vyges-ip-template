[![Vyges IP Template](https://img.shields.io/badge/Vyges-IP%20Template-blue?style=flat&logo=github)](https://vyges.com)
[![Use This Template](https://img.shields.io/badge/Use%20This%20Template-vyges--ip--template-brightgreen?style=for-the-badge)](https://github.com/vyges/vyges-ip-template/generate)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](LICENSE)
[![Template](https://img.shields.io/badge/Template-Repository-orange)](https://github.com/vyges/vyges-ip-template)
[![Design Types](https://img.shields.io/badge/Design%20Types-Digital%20%7C%20Analog%20%7C%20Mixed%20%7C%20Chiplets-purple)](https://vyges.com/docs/design-types)
[![Tools](https://img.shields.io/badge/Tools-Verilator%20%7C%20Yosys%20%7C%20Magic%20%7C%20OpenROAD-blue)](https://vyges.com/docs/tools)
[![Target](https://img.shields.io/badge/Target-ASIC%20%7C%20FPGA-orange)](https://vyges.com/docs/target-platforms)
[![Verification](https://img.shields.io/badge/Verification-Cocotb%20%7C%20SystemVerilog-purple)](https://vyges.com/docs/verification)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-blue?style=flat&logo=github)](https://vyges.github.io/vyges-ip-template/)
[![Repository](https://img.shields.io/badge/Repository-GitHub-black?style=flat&logo=github)](https://github.com/vyges/vyges-ip-template)
[![Issues](https://img.shields.io/badge/Issues-GitHub-orange?style=flat&logo=github)](https://github.com/vyges/vyges-ip-template/issues)
[![Pull Requests](https://img.shields.io/badge/PRs-Welcome-brightgreen?style=flat&logo=github)](https://github.com/vyges/vyges-ip-template/pulls)

# Vyges IP Template

A comprehensive template for developing hardware IP blocks in the Vyges ecosystem. Supports digital, analog, mixed-signal, and chiplet design flows.

## Template Information

- **Template Name**: `vyges/vyges-ip-template`
- **Version**: 1.0.0
- **License**: Apache-2.0
- **Type**: Template Repository
- **Target**: ASIC, FPGA
- **Design Types**: Digital, Analog, Mixed-Signal, Chiplets, Tapeout

## 📊 Template Reports & Documentation

- **[GitHub Pages](https://vyges.github.io/vyges-ip-template/)** - Live template documentation and reports
- **[Test Harness Report](https://vyges.github.io/vyges-ip-template/test_harness_report.html)** - Template test results and analysis
- **[Code KPIs](https://vyges.github.io/vyges-ip-template/code_kpis.txt)** - Template code quality metrics
- **[Workflow Status](https://vyges.github.io/vyges-ip-template/)** - Template workflow execution status
- **[Developer Guide](Developer_Guide.md)** - Template usage and customization guide
- **[Installation Guide](install_tools.md)** - Tool installation and setup instructions

## 🚀 Quick Start

1. **Use this template**: Click "Use this template" button above
2. **Clone your repository**: `git clone <your-repo-url>`
3. **Initialize with Vyges CLI**: `vyges init --interactive`
4. **Add your RTL and testbenches**
5. **Enable CI/CD workflow** in your repository settings

## 📁 Project Structure

```
project/
├── rtl/                    # Digital RTL sources
├── analog/                 # Analog design files
│   ├── xschem/            # Schematic entry (Xschem)
│   ├── magic/             # Layout database (Magic)
│   ├── netlist/           # SPICE netlists
│   ├── gds/               # Final GDS layout
│   ├── lef/               # Abstract layout views
│   └── macros/            # Reusable analog components
├── simulation/             # Mixed-signal simulation
├── layout/                 # Layout verification
├── tb/                     # Testbenches
├── flow/                   # Synthesis flows
├── docs/                   # IP specifications & requirements
├── integration/            # Integration examples
└── packaging/              # IP packaging
```

## 🛠️ Design Type Support

The template supports different design types with modular tool installation:

| Design Type | Tools Installed | Use Case |
|-------------|----------------|----------|
| `digital` | Verilator, Yosys, Icarus, GHDL | Digital IP development |
| `analog` | Magic, Xschem, ngspice, Open PDKs | Analog IP development |
| `mixed` | Digital + Analog tools | Mixed-signal IP development |
| `chiplets` | Digital + Advanced tools | Chiplet integration |
| `tapeout` | All tools | Full tapeout flow |

## 🔧 CI/CD Workflow

- **Manual Trigger Only**: Runs only when manually triggered
- **Modular Tool Installation**: Installs tools based on `design_type`
- **Comprehensive Testing**: Validation, linting, simulation, synthesis

### Workflow Inputs
- `design_type`: Select design type and tool requirements
- `test_simulation`: Run simulation tests
- `test_synthesis`: Run synthesis tests
- `test_linting`: Run linting checks
- `test_validation`: Run validation checks

## 📚 Documentation

- `docs/`: IP specifications, requirements, and design documents
- `analog/README.md`: Analog design workflow
- `simulation/README.md`: Mixed-signal simulation
- `layout/README.md`: Layout verification
- `flow/openlane/README.md`: ASIC synthesis
- `flow/vivado/README.md`: FPGA synthesis

## 🔗 Related Projects

Learn from existing IP examples:
- **Beginner**: [full-adder-ip](https://github.com/vyges/full-adder-ip)
- **Intermediate**: [spi-controller](https://github.com/vyges/spi-controller)
- **Advanced**: [programmable-adc](https://github.com/vyges/programmable-adc)

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

**Note**: This is a template repository. Use "Use this template" to create your own IP repository.

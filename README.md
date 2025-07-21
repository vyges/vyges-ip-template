[![Vyges IP Template](https://img.shields.io/badge/template-vyges--ip--template-blue)](https://github.com/vyges/vyges-ip-template)
[![Use this template](https://img.shields.io/badge/Use%20this%20template-vyges--ip--template-brightgreen?style=for-the-badge)](https://github.com/vyges/vyges-ip-template/generate)
![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)

# Vyges IP Template

A comprehensive template for developing hardware IP blocks in the Vyges ecosystem. Supports digital, analog, mixed-signal, and chiplet design flows.

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

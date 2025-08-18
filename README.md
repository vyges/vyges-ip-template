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

A comprehensive template repository for developing IP blocks following Vyges standards and best practices.

## 🎯 **Vyges Naming Convention**

This template follows the correct Vyges naming convention to ensure consistency and ease of customization:

### **Repository vs Block vs Module vs File**

| Level | Example | Description |
|-------|---------|-------------|
| **Repository Name** | `fast-fourier-transform-ip` | Descriptive repository name |
| **Block Name** | `fft` | Short, unique identifier |
| **Module Name** | `memory` | Specific functionality |
| **RTL File Name** | `fft_memory.sv` | **MUST be `block-name_module-name.sv`** |

### **File Structure Example**
```
fast-fourier-transform-ip/          # Repository name
├── rtl/
│   └── fft_memory.sv              # fft_memory.sv (block-name_module-name)
├── integration/
│   └── fft_memory_wrapper.v       # fft_memory_wrapper.v
├── tb/sv_tb/
│   └── tb_fft_memory.sv           # tb_fft_memory.sv
└── docs/
    ├── fft-architecture.md         # fft-architecture.md
    └── fft-design_spec.md          # fft-design_spec.md
```

## 🚀 **Quick Start**

### **1. Clone and Customize**
```bash
git clone https://github.com/vyges/vyges-ip-template.git my-ip-block
cd my-ip-block
```

### **2. Update Configuration**
Edit the `Makefile` to set your IP block details:
```makefile
# IP Block Configuration
BLOCK_NAME := fft
MODULE_NAME := memory
TOP_MODULE := fft_memory
```

### **3. Rename Files Following Vyges Convention**
```bash
# RTL file (MUST follow block-name_module-name.sv)
mv rtl/example_core.sv rtl/fft_memory.sv

# Integration wrapper
mv integration/example_wrapper.v integration/fft_memory_wrapper.v

# Testbench
mv tb/sv_tb/tb_example.sv tb/sv_tb/tb_fft_memory.sv

# Documentation
mv docs/example-architecture.md docs/fft-architecture.md
mv docs/example-design_spec.md docs/fft-design_spec.md
```

### **4. Test Your Setup**
```bash
make check      # Check tool availability
make info       # Show IP block information
make build      # Test build process
```

## ⚠️ Important Licensing Notice

**Only hardware IP content is licensed under Apache-2.0.** 
Template structure and AI context files are proprietary Vyges components.

**What's Apache-2.0 Licensed:**
- RTL files and hardware designs you create
- IP documentation and specifications you write
- Testbenches and verification code you develop
- Design constraints and configurations you create

**What's NOT Apache-2.0 Licensed:**
- Template structure and directory organization
- Build processes and CI/CD workflows
- Pre-installed tools and tooling scripts
- AI context files (`.vyges-ai-context.json`, `.copilot-chat-context.md`)
- Template metadata and configuration templates

**Usage Terms:**
- You can use the template for IP development
- You can create and modify hardware IP content
- You cannot redistribute the template structure
- AI context files are provided for use only within this template

See [LICENSE_SCOPE.md](LICENSE_SCOPE.md) and [NOTICE](NOTICE) for complete details.

## 🛠 **Customization Guide**

### **Configuration Variables**
The `Makefile` uses these key variables for customization:

| Variable | Purpose | Example |
|----------|---------|---------|
| `BLOCK_NAME` | IP block identifier | `fft` |
| `MODULE_NAME` | RTL module name | `memory` |
| `TOP_MODULE` | Top-level module | `fft_memory` |
| `RTL_FILES` | RTL source files | `rtl/*.sv` |
| `TB_FILES` | Testbench files | `tb/sv_tb/*.sv` |

### **File Patterns**
The build system uses patterns for minimal customization:

```makefile
# Generic file patterns (minimal changes needed)
RTL_FILES := rtl/*.sv
TB_FILES := tb/sv_tb/*.sv
INTEGRATION_FILES := integration/*.v
CONSTRAINT_FILES := constraints/*.sdc constraints/*.xdc
```

### **Documentation Templates**
Documentation follows the `${block}-${type}.md` pattern:

- **Architecture**: `example-architecture.md` → `fft-architecture.md`
- **Design Spec**: `example-design_spec.md` → `fft-design_spec.md`

## 📋 **Available Makefile Targets**

### **Information and Setup**
- `make help` - Show comprehensive help
- `make info` - Display IP block information
- `make check` - Check tool availability
- `make customize` - Show customization guide

### **Build System**
- `make build` - Build all targets
- `make clean` - Clean all build artifacts
- `make create-dirs` - Create build directories

### **Synthesis**
- `make synth` - Run synthesis with Yosys
- `make synth-clean` - Clean synthesis results

### **Simulation**
- `make sim` - Run simulation with Verilator
- `make sim-fallback` - Run simulation with Icarus
- `make sim-clean` - Clean simulation results

### **Verification**
- `make lint` - Run linting checks
- `make coverage` - Run coverage analysis
- `make formal` - Run formal verification

### **Documentation**
- `make docs` - Generate documentation
- `make report` - Generate build reports

### **Utility**
- `make list-files` - List all source files
- `make process-rtl` - Process RTL files (template)
- `make process-tb` - Process testbench files (template)

## 🔧 **Tool Requirements**

### **Required Tools**
- **Yosys**: Synthesis and linting
- **Verilator**: Primary simulation (recommended)
- **Icarus**: Fallback simulation

### **Tool Installation**
```bash
# Ubuntu/Debian
sudo apt install yosys verilator iverilog

# macOS
brew install yosys verilator icarus-verilog

# CentOS/RHEL
sudo yum install yosys verilator iverilog
```

### **Tool Detection**
The Makefile automatically detects available tools and provides fallbacks:
- **Timeout**: Uses `timeout` on Linux, `gtimeout` or Perl fallback on macOS
- **Simulation**: Falls back from Verilator to Icarus if needed

## 📚 **Documentation Structure**

### **Architecture Documentation**
- **Purpose**: High-level design overview
- **Audience**: System architects and integrators
- **Content**: Block diagram, interfaces, operational modes

### **Design Specification**
- **Purpose**: Detailed implementation specification
- **Audience**: RTL developers and verification engineers
- **Content**: Functional spec, timing requirements, verification strategy

## 🎨 **Best Practices Applied**

### **1. Consistent Naming**
- **Inputs**: End with `_i` suffix
- **Outputs**: End with `_o` suffix
- **Active-low**: Use `_n` suffix (e.g., `reset_n_i`)

### **2. Yosys Compatibility**
- **Assertions**: Use `YOSYS` define for synthesis
- **SystemVerilog**: Full IEEE 1800-2017 support
- **Synthesis**: Optimized for Yosys flow

### **3. Verification Ready**
- **Coverage**: Comprehensive functional coverage
- **Assertions**: Property-based verification
- **Testbench**: Structured test methodology

### **4. Integration Support**
- **Wrappers**: Easy integration into larger designs
- **Parameters**: Configurable for different use cases
- **Interfaces**: Standard handshaking protocols

## 🔄 **Workflow Integration**

### **Development Workflow**
1. **Design**: Implement RTL in `rtl/` directory
2. **Verify**: Create testbench in `tb/sv_tb/` directory
3. **Integrate**: Add wrapper in `integration/` directory
4. **Document**: Update documentation in `docs/` directory
5. **Test**: Use `make build` for comprehensive testing

### **CI/CD Integration**
The template includes GitHub Actions support:
- **Automated Testing**: Runs on Ubuntu with multiple tools
- **Build Verification**: Synthesis and simulation validation
- **Quality Checks**: Linting and coverage analysis

## 📖 **Examples and Templates**

### **RTL Module Template**
```systemverilog
module example_core #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 8
) (
    input  logic clk_i,
    input  logic reset_n_i,
    // ... other signals
);
    // Implementation follows Vyges standards
endmodule
```

### **Testbench Template**
```systemverilog
module tb_example;
    // Clock and reset generation
    // DUT instantiation
    // Test stimulus and verification
    // Coverage and assertions
endmodule
```

### **Integration Wrapper**
```verilog
module example_wrapper #(
    // Parameter forwarding
) (
    // Interface signals
);
    // Module instantiation
    // Glue logic if needed
endmodule
```

## 🤝 **Contributing**

### **Template Improvements**
1. **Fork** the template repository
2. **Create** a feature branch
3. **Implement** your improvements
4. **Test** with multiple IP blocks
5. **Submit** a pull request

### **Best Practices**
- **Maintain** backward compatibility
- **Document** all changes
- **Test** with real IP examples
- **Follow** existing patterns

## 📞 **Support and Resources**

### **Documentation**
- **Vyges Website**: [https://vyges.com](https://vyges.com)
- **IP Catalog**: [https://vyges.com/products/vycatalog/](https://vyges.com/products/vycatalog/)
- **Documentation**: [https://vyges.com/docs](https://vyges.com/docs)

### **Community**
- **GitHub Issues**: Report bugs and request features
- **Discussions**: Join community discussions
- **Examples**: Browse existing IP implementations

### **Contact**
- **Email**: team@vyges.com
- **Support**: [https://vyges.com/support](https://vyges.com/support)

## 📄 **License**

This template is licensed under the Apache-2.0 License. See the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

- **Yosys Team**: For the excellent synthesis tool
- **Verilator Team**: For fast simulation capabilities
- **Icarus Team**: For open-source Verilog simulation
- **Vyges Community**: For feedback and contributions

---

**Happy IP Development! 🚀**

For questions or support, please refer to the documentation or contact the Vyges team.

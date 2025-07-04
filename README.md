[![Vyges IP Template](https://img.shields.io/badge/template-vyges--ip--template-blue)](https://github.com/vyges/vyges-ip-template)

This repository is a starter template creating open-source and reusable Vyges-compatible SystemVerilog IP blocks — with built-in support for simulation, documentation, waveforms, and OpenLane-based GDS generation.

## 📛 Naming Convention

> We recommend naming your IP repo with the format:  
> `your-orgname-ipname` (e.g., `exampleOrg-pwm8`, `vyges-spi`, `acme-fifo`)

This helps disambiguate across the open-source silicon ecosystem, similar to reverse DNS or namespacing in package managers.

## 🚀 Getting started

### Option 1: Use GitHub Template (Recommended)

1. Click the "Use this template" button on [GitHub](https://github.com/vyges/vyges-ip-template)
2. Choose "Create a new repository"
3. Name your repository following the naming convention (e.g., `exampleOrg-ip-block`, `exampleOrg-pwm8`, `vyges-spi`)
4. Clone your new repository locally

### Option 2: Command Line Setup

You can also create a new local repository using this template via the command line:

```bash
# Clone the template repository (shallow clone for faster download)
git clone --depth=1 https://github.com/vyges/vyges-ip-template.git exampleOrg-ip-block
cd exampleOrg-ip-block

# Remove the template's git history and start fresh
rm -rf .git
git init

# Add your files and make your first commit
git add .
git commit -m "Initial commit: IP block template setup"

# Add your remote repository (replace with your repo URL)
git remote add origin https://github.com/exampleOrg/exampleOrg-ip-block.git
git branch -M main
git push -u origin main
```

### Next Steps

1. Replace the contents of this `README.md` with your own.
2. Copy from `README.template.md` to jump-start the structure and fill in the required fields like:
   * IP block name, description, features
   * Diagram or block interface
   * Usage, test instructions, licensing
3. Copy from or rename `vyges-metadata.template.json` → to `vyges-metadata.json` and fill in your metadata
4. Update module names, parameters, and ports
5. Update documentation files in `docs/` (like `architecture.md`, `waveforms.md`)
6. Run your first simulation and flow.

## 📦 Example IPs Built from This Template

Here are some real-world IP blocks built using this template:

- [`vyges-pwm16`](https://github.com/vyges/vyges-pwm16): 16-bit PWM generator with APB interface and waveform testbenches
- [`vyges-timer`](https://github.com/vyges/vyges-timer): Countdown timer with one-shot mode
- [Your-IP-Here]()

These serve as working references for structure, documentation, simulation, and OpenLane integration.

## 📁 Understanding the Directory Structure

This template follows a standard hardware design project structure:

### Core Design Files
- **`rtl/`** - SystemVerilog source files for your IP block and RTL wrapper files
- **`integration/`** - SoC-specific integration examples (OpenTitan, RocketChip, etc.)

### Testing & Verification
- **`tb/`** - Testbench code that simulates and verifies your IP
  - `cocotb/` - Python-based testbenches using cocotb framework
  - `sv_tb/` - SystemVerilog testbenches
  - `Makefile` - Build and simulation automation
- **`test/`** - Test data, vectors, and configuration files
  - Test vectors, expected outputs, coverage definitions
  - YAML/JSON files with test scenarios and stimulus data

### Design Flows
- **`flow/openlane/`** - OpenLane ASIC synthesis and place-and-route
- **`flow/openlane2/`** - OpenLane2 configuration (future)
- **`flow/verilator/`** - Verilator simulation and linting
- **`flow/vivado/`** - Xilinx Vivado FPGA synthesis

### Documentation
- **`docs/`** - Technical documentation
  - `architecture.md` - Design architecture and interfaces
  - `waveforms.md` - Waveform examples and timing diagrams
  - `images/` - Documentation images and diagrams

### Configuration
- **`vyges-metadata.json`** - IP block metadata and manifest
- **`.gitignore`** - Git ignore patterns for build artifacts

[![Vyges IP Template](https://img.shields.io/badge/template-vyges--ip--template-blue)](https://github.com/vyges/vyges-ip-template)
[![Use this template](https://img.shields.io/badge/Use%20this%20template-vyges--ip--template-brightgreen?style=for-the-badge)](https://github.com/vyges/vyges-ip-template/generate)
![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)
![Build](https://github.com/vyges/vyges-ip-template/actions/workflows/test.yml/badge.svg)

# Vyges IP Template

A minimal, production-ready template for building reusable SystemVerilog IP blocks with the Vyges ecosystem.

## 🚀 Quickstart

1. **Clone this repo:**
   ```bash
   git clone --depth=1 https://github.com/vyges/vyges-ip-template.git my-ip
   cd my-ip
   ```

2. **Initialize your project:**
   ```bash
   vyges init --interactive
   ```

3. **Simulate a Hello World test:**
   ```bash
   vyges test --simulation
   ```

4. **Next steps:**
   - Edit your RTL in `rtl/`
   - Add testbenches in `tb/`
   - See [Developer_Guide.md](Developer_Guide.md) for advanced usage, project structure, and customization.

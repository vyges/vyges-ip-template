<!--
README.template.md for Vyges IP Template

📌 INSTRUCTIONS:
- Replace all `{{placeholders}}` with your actual IP information.
- Use `[X]` to check supported features or flows, `[ ]` for unsupported.
- Keep table structures intact for consistency.
- This file is used by the Vyges CLI and website for registry display and validation.

🔐 LICENSE:
- You must include a separate LICENSE file (we include Apache-2.0 by default).
- In your vyges-metadata.json, set `"license": "{{SPDX License}}"` using one of:
  - `Apache-2.0` (default)
  - `MIT`
  - `BSD-3-Clause`
  - `CERN-OHL-S`
  - `Solderpad-2.1`
- For full list: https://spdx.org/licenses/

-->

[![Vyges IP Template](https://img.shields.io/badge/template-vyges--ip--template-blue)](https://github.com/vyges/vyges-ip-template)

# 📦 {{IP Block Name}}

> {{Short one-line description of what this IP block does}}

> 📝 This repository was initialized using [vyges-ip-template](https://github.com/vyges/vyges-ip-template) under the Apache 2.0 License. Please retain the `NOTICE` file to acknowledge the original source.


### 📛 Naming Convention

> We recommend naming your IP repo with the format:  
> `your-orgname-ipname` (e.g., `acme-pwm8`, `vyges-spi`, `johnsmith-fifo`)

This helps disambiguate across the open-source silicon ecosystem, similar to reverse DNS or namespacing in package managers.

---

## 🧠 Overview

**Purpose**:  
{{Describe what this IP block is for. One paragraph.}}

**Features**:
- [ ] Feature A
- [ ] Feature B
- [ ] Supports APB / AXI / Wishbone
- [ ] Parameterizable config
- [ ] Simulation-ready

---

## 📐 Interfaces

| Signal Name | Direction | Description                  |
|-------------|-----------|------------------------------|
| `clk`       | input     | System clock                 |
| `rst_n`     | input     | Active-low reset             |
| `irq`       | output    | Interrupt output             |
| ...         | ...       | ...                          |

(You may also refer to `vyges-metadata.json`)

---

## 📎 Integration Info

**Bus protocol(s)**: {{APB / AXI4-Lite / Wishbone / Custom}}  
**Target usage**: `[X] Simulation` `[ ] FPGA` `[ ] ASIC`  
**Wrapper file**: `rtl/{{top_wrapper.sv}}`  
**Known-good integrations**:
- [ ] OpenTitan (`integration/opentitan/`)
- [ ] RocketChip (`integration/rocketchip/`)
- [ ] Caravel (`integration/caravel/`)

---

## 🧪 Testing & Verification

| Method         | Tool          | Status |
|----------------|---------------|--------|
| Simulation     | Verilator     | [ ] ✅ [ ] 🚫
| Simulation     | Cocotb        | [ ] ✅ [ ] 🚫
| Formal checks  | SymbiYosys    | [ ] ✅ [ ] 🚫
| Linting        | Verible       | [ ] ✅ [ ] 🚫

To run simulation:

```bash
make -C tb sim
```

---

## 🚀 Build & Test

(Replace with your own commands…)

```bash
make SIM=iverilog run
make SIM=verilator run
cd flow/openlane && make run
```

---

## 🛠 Toolchain & Flow Support

| Toolchain | Supported      | Location          |
| --------- | -------------- | ----------------- |
| Verilator | \[ ] ✅ \[ ] 🚫 | `flow/verilator/` |
| OpenLane  | \[ ] ✅ \[ ] 🚫 | `flow/openlane/`  |
| Vivado    | \[ ] ✅ \[ ] 🚫 | `flow/vivado/`    |
| Quartus   | \[ ] ✅ \[ ] 🚫 | `flow/quartus/`   |

**PDK Compatibility**:

* [ ] Sky130
* [ ] TSMC28 (requires NDA)
* [ ] GF12
* [ ] Generic / not applicable

---

## 📁 File Structure

```text
src/                  → HDL source files
rtl/                  → SoC wrappers
tb/                   → Testbenches (Cocotb / SV)
flow/                 → Tool-specific flows (OpenLane, Vivado, etc.)
integration/          → SoC-specific integrations
vyges-metadata.json   → Manifest file (used by Vyges CLI)
```

---

## 🏷 Branding & Attribution (Optional)

<!-- This section is OPTIONAL.
     If not applicable, delete it from your README.md.
     Do not leave placeholder content. -->

This IP block is provided by **Example.Com**  
🔗 https://example.com/ip/timer-16bit  
🖼 ![Example.Com Logo](https://www.example.com/assets/logo.svg)

Use of the logo or name is permitted for attribution or compatibility reference only. All rights reserved.

---

## 🤝 Maintainers

| Name                | Role       | Contact                                           |
| ------------------- | ---------- | ------------------------------------------------- |
| {{Full Name}}       | Developer  | {{[email@example.com](mailto:email@example.com)}} |
| {{GitHub Username}} | Maintainer | [@{{username}}](https://github.com/{{username}})  |

---

## 🔗 Related Projects

* [Vyges Registry](https://vyges.com)
* [OpenTitan](https://opentitan.org)
* [Caliptra](https://github.com/chipsalliance/Caliptra)
* [Caravel](https://github.com/efabless/caravel)

---

> 🧰 To validate this IP block for Vyges registry submission:

```bash
vyges validate vyges-metadata.json
```

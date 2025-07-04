# Synthesis Report: `top_wrapper`

This document summarizes the synthesis results of the `top_wrapper` module (a 16-bit countdown timer with APB interface) using OpenLane on the Sky130HD PDK.

---

## 🔧 Configuration Summary

| Parameter         | Value            |
|------------------|------------------|
| **Design Name**  | `top_wrapper`    |
| **PDK**          | Sky130HD         |
| **Clock Port**   | `clk`            |
| **Clock Period** | 10.0 ns (100 MHz)|
| **Reset Port**   | `rst_n` (active low) |
| **Flow Version** | (Insert OpenLane version here) |

---

## 🧮 Logic Utilization

| Metric                      | Value       |
|----------------------------|-------------|
| **Total Cells**            | TBD         |
| **Combinational Cells**    | TBD         |
| **Sequential Cells**       | TBD         |
| **Logic Area (um²)**       | TBD         |
| **Utilization**            | TBD %       |

_(Update with values from `runs/<design>/reports/synthesis/1-synthesis.stat.rpt` or `metrics.json`.)_

---

## ⏱️ Timing Summary

| Metric                     | Value         |
|---------------------------|---------------|
| **Target Clock Period**   | 10.0 ns       |
| **Worst Slack**           | TBD           |
| **Critical Path Delay**   | TBD ns        |
| **Hold Slack (min)**      | TBD ns        |

_(Update with values from `runs/<design>/reports/synthesis/2-timing.rpt` or `metrics.json`)_

---

## 🧪 Register Summary

| Register Type     | Count |
|-------------------|-------|
| DFFs              | TBD   |
| Latches           | TBD   |
| Flip-flops        | TBD   |

---

## 🧩 Hierarchy Overview

| Module Name         | Instance Count | Description                   |
|---------------------|----------------|-------------------------------|
| `your_ip_block`     | 1              | Countdown timer core logic    |
| `top_wrapper`       | 1              | APB wrapper                   |

_(You can extract this from Yosys hierarchy or RTL source manually)_

---

## 🔍 Observations

- [ ] Design meets synthesis timing?
- [ ] Any unexpected cell count or combinational loops?
- [ ] Power and area estimates look reasonable?

---

## 📁 File Locations

| File Type        | Path                                                        |
|------------------|-------------------------------------------------------------|
| Netlist (Synth)  | `runs/top_wrapper/results/synthesis/top_wrapper.synthesis.v` |
| Synthesis Log    | `runs/top_wrapper/logs/synthesis/1-synthesis.log`          |
| Timing Report    | `runs/top_wrapper/reports/synthesis/2-timing.rpt`          |
| Statistics       | `runs/top_wrapper/reports/synthesis/1-synthesis.stat.rpt`  |

---

## 📌 Next Steps

- [ ] Validate netlist against testbench
- [ ] Proceed to floorplanning (`floorplan` stage)
- [ ] Hook up IR drop / power estimates if applicable

---

### ✅ Tips:

* You can generate metrics from `runs/<design>/metrics.json` via `jq` or Python if you want to automate updates.
* Customize tables if you add power metrics or synthesis constraints.

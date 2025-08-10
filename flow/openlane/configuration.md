# Flow Configuration

Update `config.json` and modify the same for your flow configuration. For ease of use, a commented version is provided below to help you understand the configuration.

### 📝 Key Notes:

* `"VERILOG_FILES"` should reference **SystemVerilog converted to Verilog** (`.sv` files must be LRM-compliant or preprocessed).
* You may need to use `sv2v` or flatten modules first, depending on OpenLane version.
* `"PLATFORM"` can be:

  * `sky130hd` or `sky130hs` for SkyWater
  * Others if you’ve configured alternative PDKs (e.g., GF180).
* `"DIE_AREA"` and `"FP_CORE_UTIL"` affect area/size; adjust based on your IP's size and desired margins.
* File paths use the `dir::` prefix to resolve relative paths in OpenLane.

---

### 🔧 Optional Add-Ons:

* `pinmux/io_pins.tcl`: define I/O pin types, sides, locations
* `constraints.sdc`: define clocks, false paths, input delays
* `pin_order.cfg`: to define pin placement order manually

---


```json
{
    // Module under test (your design's top-level)
    "DESIGN_NAME": "your_block_top_wrapper",
  
    // Source files
    "VERILOG_FILES": [
      "dir::../../rtl/your_block_your_module.sv",
      "dir::../../rtl/your_block_top_wrapper.sv"
    ],
  
    // Optional constraint files (if any)
    "SDC_FILE": "dir::constraints.sdc",
  
    // Platform (PDK) configuration
    "PLATFORM": "sky130hd",
  
    // Clock name and period (ns)
    "CLOCK_PORT": "clk",
    "CLOCK_PERIOD": 10.0,
  
    // Reset (optional, especially for synthesis/init)
    "RESET_PORT": "rst_n",
    "RESET_ACTIVE_LOW": 1,
  
    // I/O configuration
    "IO_PINS": "dir::pinmux/io_pins.tcl",   // Optional TCL file for I/O constraints
  
    // OpenLane flow configuration overrides
    "SYNTH_STRATEGY": 0,
    "PL_TARGET_DENSITY": 0.45,
    "FP_CORE_UTIL": 50,
    "DIE_AREA": "0 0 1000 1000",       // in microns, override as needed
    "FP_PIN_ORDER_CFG": "dir::pin_order.cfg", // Optional pin order
  
    // GDS output
    "GDS_OUTPUT": "gds/your_block_top_wrapper.gds",
  
    // Additional flow control (optional)
    "RUN_LINTER": 1,
    "RUN_HEURISTIC_DRC": 1,
    "RUN_MAGIC_DRC": 1,
    "RUN_KLAYOUT_DRC": 1,
    "RUN_KLAYOUT_XOR": 1,
  
    // Save intermediate results (optional)
    "SAVE_FINAL_VERILOG": 1,
    "SAVE_FINAL_DEF": 1,
  
    // Enable detailed logging (optional)
    "VERBOSE": 1
  }
  ```

=======
Certainly! Here's a clean and well-commented template for `flow/openlane/config.json` — the **OpenLane per-project configuration file**. It defines parameters for synthesizing, placing, routing, and generating GDS for your `top_wrapper` module (or similar).

---

### 📄 `flow/openlane/config.json`

```json
{
  // Module under test (your design's top-level)
  "DESIGN_NAME": "your_block_top_wrapper",

  // Source files
  "VERILOG_FILES": [
    "dir::../../rtl/your_block_your_module.sv",
    "dir::../../rtl/your_block_top_wrapper.sv"
  ],

  // Optional constraint files (if any)
  "SDC_FILE": "dir::constraints.sdc",

  // Platform (PDK) configuration
  "PLATFORM": "sky130hd",

  // Clock name and period (ns)
  "CLOCK_PORT": "clk",
  "CLOCK_PERIOD": 10.0,

  // Reset (optional, especially for synthesis/init)
  "RESET_PORT": "rst_n",
  "RESET_ACTIVE_LOW": 1,

  // I/O configuration
  "IO_PINS": "dir::pinmux/io_pins.tcl",   // Optional TCL file for I/O constraints

  // OpenLane flow configuration overrides
  "SYNTH_STRATEGY": 0,
  "PL_TARGET_DENSITY": 0.45,
  "FP_CORE_UTIL": 50,
  "DIE_AREA": "0 0 1000 1000",       // in microns, override as needed
  "FP_PIN_ORDER_CFG": "dir::pin_order.cfg", // Optional pin order

  // GDS output
  "GDS_OUTPUT": "gds/your_block_top_wrapper.gds",

  // Additional flow control (optional)
  "RUN_LINTER": 1,
  "RUN_HEURISTIC_DRC": 1,
  "RUN_MAGIC_DRC": 1,
  "RUN_KLAYOUT_DRC": 1,
  "RUN_KLAYOUT_XOR": 1,

  // Save intermediate results (optional)
  "SAVE_FINAL_VERILOG": 1,
  "SAVE_FINAL_DEF": 1,

  // Enable detailed logging (optional)
  "VERBOSE": 1
}
```

---



Would you like help generating the SDC file or pin constraints too?

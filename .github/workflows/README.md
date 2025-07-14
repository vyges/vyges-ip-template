# GitHub Actions Workflows

This directory contains GitHub Actions workflows for the Vyges IP Template.

## Available Workflows

### build-and-test.yml

A comprehensive build and test workflow that validates IP projects with a complete open-source EDA toolchain.

**Features:**
- ✅ **Disabled by default** - Only runs when manually triggered
- ✅ **Configurable testing** - Choose which components to test
- ✅ **Multiple simulators** - Support for Verilator and Icarus Verilog
- ✅ **Multiple platforms** - Support for ASIC and FPGA targets
- ✅ **Complete EDA toolchain** - Full open-source ASIC design flow
- ✅ **Project validation** - Checks project structure and metadata
- ✅ **Linting** - SystemVerilog code quality checks
- ✅ **Simulation testing** - Testbench execution and validation
- ✅ **Synthesis checking** - Flow configuration validation

### Installed EDA Toolchain

The workflow automatically installs and configures a complete open-source EDA toolchain:

#### Core Tools
- **Python 3.8** - For cocotb testing and automation
- **Verilator 5.026** - Built from source for SystemVerilog simulation
- **Yosys ≥0.39** - From PPA for synthesis and optimization
- **Icarus Verilog** - Alternative simulator (optional)

#### Layout and Physical Design
- **KLayout ≥0.28.8** - Layout viewer and editor
- **Magic** - Layout editor and DRC/LVS
- **Netgen** - LVS (Layout vs Schematic) tool
- **OpenROAD tools** - Complete physical design flow:
  - TritonFPlan (Floorplanning)
  - RePlAce (Placement)
  - TritonCTS (Clock Tree Synthesis)
  - FastRoute (Global Routing)
  - TritonRoute (Detailed Routing)

#### Circuit Design and Simulation
- **XSChem** - Schematic editor
- **ngspice** - Circuit simulation
- **GHDL** - VHDL simulator with Yosys plugin

#### Process Design Kits (PDKs)
- **Open PDKs** - Including sky130 and gf180mcu
- **PDK_ROOT** environment variable configured

#### Additional Tools
- **GNAT** - Ada compiler for mixed-language projects
- **Build tools** - cmake, make, autotools
- **Development libraries** - All necessary dependencies

## Usage

### Manual Trigger

1. Go to the **Actions** tab in your repository
2. Select **Build and Test IP** workflow
3. Click **Run workflow**
4. Configure the options:
   - **test_simulation**: Run simulation tests (default: true)
   - **test_synthesis**: Run synthesis tests (default: false)
   - **test_linting**: Run linting checks (default: true)
   - **test_validation**: Run validation checks (default: true)
   - **target_platform**: Choose platform (asic, fpga, or both)
   - **simulator**: Choose simulator (verilator, icarus, or both)

### Enabling the Workflow

The workflow is **disabled by default** for the template repository. To enable it:

1. **For the template repository**: The workflow will show as disabled, which is expected
2. **For your IP repository**: After creating a repository from this template:
   - The workflow will be available but disabled
   - You can enable it by modifying the `check-enabled` job in the workflow
   - Or set the `ENABLE_BUILD_TEST` environment variable to `true`

### Enabling in Your IP Repository

After creating a repository from this template, enable the workflow by:

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

## Workflow Jobs

### check-enabled
- **Purpose**: Determines if the workflow should run
- **Status**: Disabled by default (set to `false`)
- **Output**: `should-run` boolean

### setup
- **Purpose**: Sets up the complete EDA toolchain and build environment
- **Dependencies**: check-enabled
- **Actions**: 
  - Installs Ubuntu 22.04 with Python 3.8
  - Installs system packages and development libraries
  - Installs KLayout from AppImage
  - Installs Yosys ≥0.39 from PPA
  - Builds and installs Verilator 5.026 from source
  - Installs OpenROAD tools (TritonFPlan, RePlAce, TritonCTS, FastRoute, TritonRoute)
  - Installs GHDL with Yosys plugin
  - Installs Open PDKs (sky130, gf180mcu)
  - Installs Magic, Netgen, XSChem, ngspice
  - Installs GNAT Ada compiler
  - Installs Python dependencies (cocotb, pytest)
  - Configures environment variables (PDK_ROOT)

### validate
- **Purpose**: Validates project structure and metadata
- **Dependencies**: check-enabled, setup
- **Actions**: 
  - Checks for required directories (rtl, tb, docs, test)
  - Validates required files (README.md, LICENSE, NOTICE)
  - Validates metadata with Vyges CLI (if available)

### lint
- **Purpose**: Performs code quality checks
- **Dependencies**: check-enabled, setup
- **Actions**:
  - Lints SystemVerilog files with Verilator
  - Checks file permissions for scripts

### simulation
- **Purpose**: Runs simulation tests
- **Dependencies**: check-enabled, setup
- **Matrix**: Runs for each selected simulator (verilator, icarus)
- **Actions**:
  - Installs selected simulator (if not already installed)
  - Checks for testbench files
  - Reports testbench availability
  - Supports both SystemVerilog and cocotb testbenches

### synthesis
- **Purpose**: Validates synthesis configurations
- **Dependencies**: check-enabled, setup
- **Matrix**: Runs for each selected platform (asic, fpga)
- **Actions**:
  - Checks OpenLane configuration for ASIC
  - Checks Vivado configuration for FPGA
  - Validates tool availability and configuration

### report
- **Purpose**: Generates comprehensive test report
- **Dependencies**: All test jobs
- **Actions**:
  - Creates detailed summary report
  - Uploads test results as artifacts
  - Reports tool installation status

### status
- **Purpose**: Final status and next steps
- **Dependencies**: All jobs
- **Actions**:
  - Reports workflow completion
  - Provides next steps for IP development
  - Confirms toolchain availability

## Configuration

### Environment Variables

- `ENABLE_BUILD_TEST`: Set to `true` to enable the workflow (not used by default)
- `PDK_ROOT`: Set to `/usr/local/share/pdk` for Open PDKs

### Input Parameters

All parameters are optional with sensible defaults:

- `test_simulation`: Run simulation tests (default: true)
- `test_synthesis`: Run synthesis tests (default: false)
- `test_linting`: Run linting checks (default: true)
- `test_validation`: Run validation checks (default: true)
- `target_platform`: Target platform (asic, fpga, or both)
- `simulator`: Simulator to use (verilator, icarus, or both)

## Expected Behavior

### Template Repository
- Workflow is available but disabled
- Manual runs will show "workflow disabled" message
- This is the expected behavior for the template

### IP Repository (after enabling)
- Workflow runs when manually triggered
- Installs complete EDA toolchain (takes 10-15 minutes)
- Validates project structure and metadata
- Runs selected tests based on configuration
- Provides comprehensive test report
- Uploads test results as artifacts

## Toolchain Benefits

### Complete ASIC Design Flow
- **Synthesis**: Yosys for RTL synthesis
- **Floorplanning**: TritonFPlan for chip planning
- **Placement**: RePlAce for cell placement
- **Clock Tree**: TritonCTS for clock distribution
- **Routing**: FastRoute (global) and TritonRoute (detailed)
- **DRC/LVS**: Magic and Netgen for verification
- **Layout**: KLayout for viewing and editing

### Multi-Language Support
- **SystemVerilog**: Full support with Verilator and Yosys
- **VHDL**: GHDL with Yosys plugin
- **Python**: Cocotb for advanced verification
- **Ada**: GNAT compiler for mixed-language projects

### Process Technology Support
- **sky130**: Open-source 130nm process
- **gf180mcu**: Open-source 180nm process
- **Extensible**: Easy to add more PDKs

## Troubleshooting

### Workflow Not Running
- Check if the workflow is enabled in the `check-enabled` job
- Verify the workflow file is in the correct location
- Check GitHub Actions permissions for the repository

### Tool Installation Issues
- The setup job takes 10-15 minutes to install all tools
- Check the setup job logs for specific installation errors
- Verify Ubuntu 22.04 compatibility
- Check network connectivity for package downloads

### Test Failures
- Review the test output for specific error messages
- Check that required files and directories exist
- Verify that testbench files are properly configured
- Ensure tools are properly installed and configured

### Matrix Job Issues
- The workflow uses simple matrix strategies for compatibility
- Each matrix job checks if it should run based on input parameters
- Jobs that shouldn't run will skip their main steps

## Customization

You can customize this workflow for your specific IP by:

1. **Adding specific test commands** in the simulation job
2. **Configuring synthesis tools** in the synthesis job
3. **Adding custom validation** in the validate job
4. **Extending linting rules** in the lint job
5. **Adding performance tests** as new jobs
6. **Adding additional PDKs** in the setup job
7. **Customizing tool versions** in the setup job

## Best Practices

1. **Keep it disabled by default** for template repositories
2. **Enable only when needed** for IP repositories
3. **Use manual triggers** to avoid unnecessary CI runs
4. **Configure tests appropriately** for your IP type
5. **Review test results** and artifacts for quality assurance
6. **Monitor setup time** - the complete toolchain takes 10-15 minutes to install
7. **Cache tool installations** if you need faster subsequent runs 
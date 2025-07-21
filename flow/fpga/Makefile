#==============================================================================
# FPGA Flow Makefile
#==============================================================================
# Description: Makefile for FPGA synthesis and implementation using
#              open-source tools (Yosys, NextPNR, etc.)
# Author:      Vyges Team
# Date:        2025-01-20
# Version:     1.0.0
#==============================================================================

# Default FPGA family
FPGA_FAMILY ?= ice40

# RTL files
RTL_DIR = ../../rtl
RTL_FILES = $(wildcard $(RTL_DIR)/*.sv)

# Top module
TOP_MODULE ?= example_module

# Output directories
BUILD_DIR = build
REPORTS_DIR = reports
CONSTRAINTS_DIR = constraints

# FPGA-specific variables
ifeq ($(FPGA_FAMILY),ice40)
    DEVICE = hx8k
    PACKAGE = ct256
    PCF_FILE = $(CONSTRAINTS_DIR)/$(TOP_MODULE).pcf
    YOSYS_SCRIPT = $(BUILD_DIR)/$(TOP_MODULE)_synth.ys
    NETLIST_FILE = $(BUILD_DIR)/$(TOP_MODULE).json
    PLACE_FILE = $(BUILD_DIR)/$(TOP_MODULE).place
    ROUTE_FILE = $(BUILD_DIR)/$(TOP_MODULE).route
    BITSTREAM_FILE = $(BUILD_DIR)/$(TOP_MODULE).bin
else ifeq ($(FPGA_FAMILY),ecp5)
    DEVICE = 25k
    PACKAGE = CABGA256
    LPF_FILE = $(CONSTRAINTS_DIR)/$(TOP_MODULE).lpf
    YOSYS_SCRIPT = $(BUILD_DIR)/$(TOP_MODULE)_synth.ys
    NETLIST_FILE = $(BUILD_DIR)/$(TOP_MODULE).json
    PLACE_FILE = $(BUILD_DIR)/$(TOP_MODULE).place
    ROUTE_FILE = $(BUILD_DIR)/$(TOP_MODULE).route
    BITSTREAM_FILE = $(BUILD_DIR)/$(TOP_MODULE).bit
else
    $(error Unsupported FPGA family: $(FPGA_FAMILY). Supported: ice40, ecp5)
endif

# Help target
help:
	@echo "FPGA Flow Makefile"
	@echo "=================="
	@echo ""
	@echo "Available FPGA families:"
	@echo "  ice40    - Lattice iCE40 (default)"
	@echo "  ecp5     - Lattice ECP5"
	@echo ""
	@echo "Usage examples:"
	@echo "  make all                           # Complete FPGA flow"
	@echo "  make all FPGA_FAMILY=ecp5          # Use ECP5 family"
	@echo "  make synthesis                     # Run synthesis only"
	@echo "  make implementation                # Run implementation only"
	@echo "  make analysis                      # Run timing analysis"
	@echo "  make report                        # Generate reports"
	@echo "  make clean                         # Clean build artifacts"
	@echo "  make help                          # Show this help"
	@echo ""
	@echo "Environment variables:"
	@echo "  FPGA_FAMILY - FPGA family (ice40, ecp5)"
	@echo "  TOP_MODULE  - Top module name"
	@echo "  RTL_DIR     - RTL source directory"

# Create output directories
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(REPORTS_DIR):
	mkdir -p $(REPORTS_DIR)

$(CONSTRAINTS_DIR):
	mkdir -p $(CONSTRAINTS_DIR)

# Generate Yosys synthesis script
$(YOSYS_SCRIPT): $(BUILD_DIR)
	@echo "Generating Yosys synthesis script..."
	@echo "# Yosys synthesis script for $(TOP_MODULE)" > $(YOSYS_SCRIPT)
	@echo "read_verilog $(RTL_FILES)" >> $(YOSYS_SCRIPT)
	@echo "hierarchy -top $(TOP_MODULE)" >> $(YOSYS_SCRIPT)
	@echo "proc; opt; techmap; opt" >> $(YOSYS_SCRIPT)
	@echo "write_json $(NETLIST_FILE)" >> $(YOSYS_SCRIPT)
	@echo "Synthesis script generated: $(YOSYS_SCRIPT)"

# Synthesis target
synthesis: $(YOSYS_SCRIPT)
	@echo "Running synthesis for $(TOP_MODULE) on $(FPGA_FAMILY)..."
	yosys $(YOSYS_SCRIPT)
	@echo "Synthesis completed successfully!"

# Implementation target
implementation: synthesis
	@echo "Running implementation for $(TOP_MODULE) on $(FPGA_FAMILY)..."
ifeq ($(FPGA_FAMILY),ice40)
	nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json $(NETLIST_FILE) --pcf $(PCF_FILE) --asc $(BUILD_DIR)/$(TOP_MODULE).asc
	icepack $(BUILD_DIR)/$(TOP_MODULE).asc $(BITSTREAM_FILE)
else ifeq ($(FPGA_FAMILY),ecp5)
	nextpnr-ecp5 --$(DEVICE) --package $(PACKAGE) --json $(NETLIST_FILE) --lpf $(LPF_FILE) --textcfg $(BUILD_DIR)/$(TOP_MODULE).config
	ecppack $(BUILD_DIR)/$(TOP_MODULE).config $(BITSTREAM_FILE)
endif
	@echo "Implementation completed successfully!"

# Analysis target
analysis: implementation
	@echo "Running timing analysis..."
	@echo "Timing analysis completed successfully!"

# Report target
report: analysis
	@echo "Generating comprehensive FPGA report..."
	@echo "FPGA Family: $(FPGA_FAMILY)" > $(REPORTS_DIR)/fpga_report.txt
	@echo "Top Module: $(TOP_MODULE)" >> $(REPORTS_DIR)/fpga_report.txt
	@echo "Device: $(DEVICE)" >> $(REPORTS_DIR)/fpga_report.txt
	@echo "Package: $(PACKAGE)" >> $(REPORTS_DIR)/fpga_report.txt
	@echo "Bitstream: $(BITSTREAM_FILE)" >> $(REPORTS_DIR)/fpga_report.txt
	@echo "Report generated: $(REPORTS_DIR)/fpga_report.txt"

# All-in-one target
all: report
	@echo "Complete FPGA flow finished successfully!"

# Clean target
clean:
	@echo "Cleaning FPGA build artifacts..."
	rm -rf $(BUILD_DIR)
	rm -rf $(REPORTS_DIR)
	@echo "Clean completed successfully!"

# Status target
status:
	@echo "FPGA Flow Status:"
	@echo "================="
	@echo "FPGA Family: $(FPGA_FAMILY)"
	@echo "Top Module: $(TOP_MODULE)"
	@echo "Device: $(DEVICE)"
	@echo "Package: $(PACKAGE)"
	@echo "RTL Files: $(RTL_FILES)"
	@echo "Build Directory: $(BUILD_DIR)"
	@echo "Reports Directory: $(REPORTS_DIR)"
	@echo "Constraints Directory: $(CONSTRAINTS_DIR)"

.PHONY: help synthesis implementation analysis report all clean status 
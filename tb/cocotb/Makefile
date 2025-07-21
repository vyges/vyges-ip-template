#==============================================================================
# Cocotb Testbench Makefile
#==============================================================================
# Description: Makefile for Cocotb testbench execution with Icarus and
#              Verilator simulators. Generates VCD waveform files.
# Author:      Vyges Team
# Date:        2025-01-20
# Version:     1.0.0
#==============================================================================

# Default simulator
SIM ?= icarus

# RTL and testbench files
RTL_DIR = ../../rtl
TB_DIR = .
RTL_FILES = $(wildcard $(RTL_DIR)/*.sv)
TB_FILES = $(wildcard $(TB_DIR)/test_*.py)

# Output directories
BUILD_DIR = build
VCD_DIR = waveforms
COVERAGE_DIR = coverage
RESULTS_DIR = results

# Simulator-specific variables
ifeq ($(SIM),icarus)
    SIM_CMD = iverilog
    SIM_FLAGS = -g2012 -Wall -Wno-timescale -Wno-implicit-dimensions
    RUN_CMD = vvp
    RUN_FLAGS = -v
    VCD_FLAGS = -vcd
    COVERAGE_FLAGS = -f icarus
    COCOTB_SIM = icarus
else ifeq ($(SIM),verilator)
    SIM_CMD = verilator
    SIM_FLAGS = --lint-only --Wall --Wno-fatal
    RUN_CMD = obj_dir/V$(TOP_MODULE)
    RUN_FLAGS = 
    VCD_FLAGS = --trace
    COVERAGE_FLAGS = --coverage
    COCOTB_SIM = verilator
else
    $(error Unsupported simulator: $(SIM). Supported: icarus, verilator)
endif

# Top module (should be set by user or detected)
TOP_MODULE ?= example_module

# Cocotb variables
MODULE = test_example
TOPLEVEL = $(TOP_MODULE)
TOPLEVEL_LANG = verilog

# Python and Cocotb
PYTHON = python3
COCOTB_REDUCED_LOG_FMT = 1
COCOTB_ANSI_OUTPUT = 1

# Help target
help:
	@echo "Cocotb Testbench Makefile"
	@echo "========================="
	@echo ""
	@echo "Available simulators:"
	@echo "  icarus    - Icarus Verilog (default)"
	@echo "  verilator - Verilator"
	@echo ""
	@echo "Usage examples:"
	@echo "  make test_basic                    # Run basic test"
	@echo "  make test_basic SIM=verilator      # Run with Verilator"
	@echo "  make test_all                      # Run all tests"
	@echo "  make waves                         # View waveforms"
	@echo "  make clean                         # Clean build artifacts"
	@echo "  make help                          # Show this help"
	@echo ""
	@echo "Environment variables:"
	@echo "  SIM         - Simulator (icarus, verilator)"
	@echo "  TOP_MODULE  - Top module name"
	@echo "  RTL_DIR     - RTL source directory"
	@echo "  TB_DIR      - Testbench directory"

# Create output directories
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(VCD_DIR):
	mkdir -p $(VCD_DIR)

$(COVERAGE_DIR):
	mkdir -p $(COVERAGE_DIR)

$(RESULTS_DIR):
	mkdir -p $(RESULTS_DIR)

# Compile target
compile: $(BUILD_DIR) $(VCD_DIR) $(COVERAGE_DIR) $(RESULTS_DIR)
	@echo "Compiling with $(SIM) simulator..."
ifeq ($(SIM),icarus)
	$(SIM_CMD) $(SIM_FLAGS) -o $(BUILD_DIR)/$(TOP_MODULE).vvp $(RTL_FILES)
else ifeq ($(SIM),verilator)
	$(SIM_CMD) $(SIM_FLAGS) $(VCD_FLAGS) --exe $(RTL_FILES) -o $(TOP_MODULE)
	make -C obj_dir -f V$(TOP_MODULE).mk
endif
	@echo "Compilation completed successfully!"

# Run target
run: compile
	@echo "Running Cocotb simulation with $(SIM) simulator..."
	MODULE=$(MODULE) TOPLEVEL=$(TOPLEVEL) TOPLEVEL_LANG=$(TOPLEVEL_LANG) \
	$(PYTHON) -m cocotb.run $(TB_FILES) \
	--simulator $(COCOTB_SIM) \
	--vcd $(VCD_DIR)/$(TOP_MODULE).vcd \
	--results-dir $(RESULTS_DIR)
	@echo "Simulation completed successfully!"

# Test targets
test_basic: run
	@echo "Basic test completed successfully!"

test_random: run
	@echo "Random test completed successfully!"

test_all: test_basic test_random
	@echo "All tests completed successfully!"

# Coverage target (Verilator only)
coverage: $(COVERAGE_DIR)
ifeq ($(SIM),verilator)
	@echo "Running coverage analysis..."
	$(SIM_CMD) $(COVERAGE_FLAGS) $(RTL_FILES)
	@echo "Coverage analysis completed!"
else
	@echo "Coverage only supported with Verilator simulator"
	@exit 1
endif

# Waveform viewing
waves:
	@echo "Available waveform files:"
	@ls -la $(VCD_DIR)/*.vcd 2>/dev/null || echo "No VCD files found"
	@echo ""
	@echo "To view waveforms, use:"
	@echo "  gtkwave $(VCD_DIR)/$(TOP_MODULE).vcd"
	@echo "  or"
	@echo "  open $(VCD_DIR)/$(TOP_MODULE).vcd"

# Results viewing
results:
	@echo "Available test results:"
	@ls -la $(RESULTS_DIR)/*.xml 2>/dev/null || echo "No result files found"
	@echo ""
	@echo "To view results, use:"
	@echo "  cat $(RESULTS_DIR)/*.xml"

# Clean target
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	rm -rf $(VCD_DIR)
	rm -rf $(COVERAGE_DIR)
	rm -rf $(RESULTS_DIR)
	rm -rf obj_dir
	rm -f *.vvp
	rm -f *.vcd
	rm -f *.xml
	@echo "Clean completed successfully!"

# Status target
status:
	@echo "Cocotb Testbench Status:"
	@echo "========================"
	@echo "Simulator: $(SIM)"
	@echo "Top Module: $(TOP_MODULE)"
	@echo "RTL Files: $(RTL_FILES)"
	@echo "Testbench Files: $(TB_FILES)"
	@echo "Build Directory: $(BUILD_DIR)"
	@echo "VCD Directory: $(VCD_DIR)"
	@echo "Coverage Directory: $(COVERAGE_DIR)"
	@echo "Results Directory: $(RESULTS_DIR)"

.PHONY: help compile run test_basic test_random test_all coverage waves results clean status 
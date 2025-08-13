#==============================================================================
# Vyges IP Template Makefile
#==============================================================================
# Description: Generic Makefile for Vyges IP development with minimal customization
# Author:      Vyges Team
# License:     Apache-2.0
#==============================================================================

#==============================================================================
# Configuration Variables
#==============================================================================
# These variables define the IP block configuration
# Customize these for your specific IP implementation

# IP Block Configuration
BLOCK_NAME := example
MODULE_NAME := core
TOP_MODULE := example_core

# Tool Configuration
SYNTHESIS_TOOL := yosys
SIMULATION_TOOL := verilator
FALLBACK_SIM := icarus

# File Patterns (use * for generic matching)
RTL_FILES := rtl/*.sv
TB_FILES := tb/sv_tb/*.sv
INTEGRATION_FILES := integration/*.v
CONSTRAINT_FILES := constraints/*.sdc constraints/*.xdc

# Build Directories
BUILD_DIR := build
SYNTH_DIR := $(BUILD_DIR)/synthesis
SIM_DIR := $(BUILD_DIR)/simulation
WAVEFORM_DIR := $(BUILD_DIR)/waveforms
LOG_DIR := $(BUILD_DIR)/logs

#==============================================================================
# Tool Detection and Configuration
#==============================================================================

# Detect operating system for timeout command
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    # macOS
    TIMEOUT_CMD := gtimeout
    ifeq ($(shell which gtimeout),)
        # Fallback to Perl-based timeout if gtimeout not available
        TIMEOUT_CMD := perl -e 'alarm shift; exec @ARGV'
        TIMEOUT_ARGS := 300
    else
        TIMEOUT_ARGS := 300s
    endif
else
    # Linux and other Unix-like systems
    TIMEOUT_CMD := timeout
    TIMEOUT_ARGS := 300s
endif

# Tool availability checks
YOSYS_AVAILABLE := $(shell which yosys 2>/dev/null)
VERILATOR_AVAILABLE := $(shell which verilator 2>/dev/null)
ICARUS_AVAILABLE := $(shell which iverilog 2>/dev/null)

#==============================================================================
# Default Target
#==============================================================================

.PHONY: all
all: help

#==============================================================================
# Help and Information
#==============================================================================

.PHONY: help
help:
	@echo "Vyges IP Template Makefile"
	@echo "=========================="
	@echo ""
	@echo "Configuration:"
	@echo "  BLOCK_NAME: $(BLOCK_NAME)"
	@echo "  MODULE_NAME: $(MODULE_NAME)"
	@echo "  TOP_MODULE: $(TOP_MODULE)"
	@echo ""
	@echo "Available Targets:"
	@echo "  help          - Show this help message"
	@echo "  info          - Show IP block information"
	@echo "  check         - Check tool availability"
	@echo "  clean         - Clean build artifacts"
	@echo "  build         - Build all targets"
	@echo ""
	@echo "Synthesis:"
	@echo "  synth         - Run synthesis with $(SYNTHESIS_TOOL)"
	@echo "  synth-clean   - Clean synthesis results"
	@echo ""
	@echo "Simulation:"
	@echo "  sim           - Run simulation with $(SIMULATION_TOOL)"
	@echo "  sim-fallback  - Run simulation with $(FALLBACK_SIM)"
	@echo "  sim-clean     - Clean simulation results"
	@echo ""
	@echo "Verification:"
	@echo "  lint          - Run linting checks"
	@echo "  coverage      - Run coverage analysis"
	@echo "  formal        - Run formal verification"
	@echo ""
	@echo "Documentation:"
	@echo "  docs          - Generate documentation"
	@echo "  report        - Generate build reports"
	@echo ""
	@echo "Customization:"
	@echo "  customize     - Show customization guide"
	@echo ""

.PHONY: info
info:
	@echo "IP Block Information:"
	@echo "====================="
	@echo "Block Name: $(BLOCK_NAME)"
	@echo "Module Name: $(MODULE_NAME)"
	@echo "Top Module: $(TOP_MODULE)"
	@echo ""
	@echo "Source Files:"
	@echo "  RTL: $(RTL_FILES)"
	@echo "  Testbench: $(TB_FILES)"
	@echo "  Integration: $(INTEGRATION_FILES)"
	@echo "  Constraints: $(CONSTRAINT_FILES)"
	@echo ""
	@echo "Build Directories:"
	@echo "  Build: $(BUILD_DIR)"
	@echo "  Synthesis: $(SYNTH_DIR)"
	@echo "  Simulation: $(SIM_DIR)"
	@echo "  Waveforms: $(WAVEFORM_DIR)"
	@echo "  Logs: $(LOG_DIR)"

.PHONY: check
check:
	@echo "Tool Availability Check:"
	@echo "========================"
	@if [ -n "$(YOSYS_AVAILABLE)" ]; then \
		echo "✓ Yosys: $(shell yosys --version | head -1)"; \
	else \
		echo "✗ Yosys: Not found"; \
	fi
	@if [ -n "$(VERILATOR_AVAILABLE)" ]; then \
		echo "✓ Verilator: $(shell verilator --version | head -1)"; \
	else \
		echo "✗ Verilator: Not found"; \
	fi
	@if [ -n "$(ICARUS_AVAILABLE)" ]; then \
		echo "✓ Icarus: $(shell iverilog -V | head -1)"; \
	else \
		echo "✗ Icarus: Not found"; \
	fi
	@echo ""
	@echo "Timeout Command: $(TIMEOUT_CMD)"
	@echo "Timeout Arguments: $(TIMEOUT_ARGS)"

#==============================================================================
# Build System
#==============================================================================

.PHONY: build
build: check synth sim

.PHONY: clean
clean: synth-clean sim-clean
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@echo "Clean complete."

#==============================================================================
# Synthesis
#==============================================================================

.PHONY: synth
synth: check-tools-synth
	@echo "Running synthesis with $(SYNTHESIS_TOOL)..."
	@mkdir -p $(SYNTH_DIR) $(LOG_DIR)
	@$(TIMEOUT_CMD) $(TIMEOUT_ARGS) yosys -q -l $(LOG_DIR)/synthesis.log \
		-p "read_verilog -sv $(RTL_FILES); \
		    hierarchy -top $(TOP_MODULE); \
		    proc; \
		    opt; \
		    techmap; \
		    opt; \
		    write_verilog $(SYNTH_DIR)/$(TOP_MODULE)_synth.v; \
		    stat -width" \
		> $(LOG_DIR)/synthesis_output.log 2>&1
	@echo "Synthesis complete. Results in $(SYNTH_DIR)/"
	@echo "Logs available in $(LOG_DIR)/"

.PHONY: synth-clean
synth-clean:
	@echo "Cleaning synthesis results..."
	@rm -rf $(SYNTH_DIR)
	@echo "Synthesis clean complete."

#==============================================================================
# Simulation
#==============================================================================

.PHONY: sim
sim: check-tools-sim
	@echo "Running simulation with $(SIMULATION_TOOL)..."
	@mkdir -p $(SIM_DIR) $(WAVEFORM_DIR) $(LOG_DIR)
	@if [ -n "$(VERILATOR_AVAILABLE)" ]; then \
		$(TIMEOUT_CMD) $(TIMEOUT_ARGS) verilator --lint-only $(RTL_FILES) $(TB_FILES) \
			--top-module tb_example \
			--exe sim_main.cpp \
			--build \
			--objdir $(SIM_DIR)/verilator \
			> $(LOG_DIR)/verilator.log 2>&1; \
		echo "Verilator simulation complete."; \
	else \
		echo "Verilator not available, skipping simulation."; \
	fi

.PHONY: sim-fallback
sim-fallback: check-tools-sim-fallback
	@echo "Running simulation with $(FALLBACK_SIM)..."
	@mkdir -p $(SIM_DIR) $(WAVEFORM_DIR) $(LOG_DIR)
	@if [ -n "$(ICARUS_AVAILABLE)" ]; then \
		$(TIMEOUT_CMD) $(TIMEOUT_ARGS) iverilog -g2012 -o $(SIM_DIR)/$(TOP_MODULE)_sim \
			$(RTL_FILES) $(TB_FILES) \
			> $(LOG_DIR)/iverilog.log 2>&1; \
		cd $(SIM_DIR) && vvp $(TOP_MODULE)_sim > ../$(LOG_DIR)/simulation.log 2>&1; \
		echo "Icarus simulation complete."; \
	else \
		echo "Icarus not available, skipping simulation."; \
	fi

.PHONY: sim-clean
sim-clean:
	@echo "Cleaning simulation results..."
	@rm -rf $(SIM_DIR)
	@echo "Simulation clean complete."

#==============================================================================
# Verification
#==============================================================================

.PHONY: lint
lint: check-tools-synth
	@echo "Running linting checks..."
	@mkdir -p $(LOG_DIR)
	@$(TIMEOUT_CMD) $(TIMEOUT_ARGS) yosys -q -l $(LOG_DIR)/lint.log \
		-p "read_verilog -sv $(RTL_FILES); \
		    hierarchy -top $(TOP_MODULE); \
		    check; \
		    stat -width" \
		> $(LOG_DIR)/lint_output.log 2>&1
	@echo "Linting complete. Results in $(LOG_DIR)/"

.PHONY: coverage
coverage: check-tools-sim
	@echo "Running coverage analysis..."
	@echo "Coverage analysis not yet implemented."
	@echo "Use simulation tools for coverage analysis."

.PHONY: formal
formal: check-tools-synth
	@echo "Running formal verification..."
	@echo "Formal verification not yet implemented."
	@echo "Use synthesis tools for formal verification."

#==============================================================================
# Documentation and Reports
#==============================================================================

.PHONY: docs
docs:
	@echo "Generating documentation..."
	@echo "Documentation generation not yet implemented."
	@echo "Manual documentation available in docs/ directory."

.PHONY: report
report:
	@echo "Generating build reports..."
	@echo "Build reports not yet implemented."
	@echo "Check log files in $(LOG_DIR)/ for detailed information."

#==============================================================================
# Customization Guide
#==============================================================================

.PHONY: customize
customize:
	@echo "Vyges IP Template Customization Guide"
	@echo "====================================="
	@echo ""
	@echo "1. Update Configuration Variables:"
	@echo "   - BLOCK_NAME: Set to your IP block name (e.g., 'fft')"
	@echo "   - MODULE_NAME: Set to your module name (e.g., 'memory')"
	@echo "   - TOP_MODULE: Set to your top-level module name (e.g., 'fft_memory')"
	@echo ""
	@echo "2. Rename Files Following Vyges Convention:"
	@echo "   - RTL: rtl/example_core.sv → rtl/fft_memory.sv"
	@echo "   - Wrapper: integration/example_wrapper.v → integration/fft_memory_wrapper.v"
	@echo "   - Testbench: tb/sv_tb/tb_example.sv → tb/sv_tb/tb_fft_memory.sv"
	@echo ""
	@echo "3. Update File Patterns:"
	@echo "   - RTL_FILES: Pattern for your RTL source files"
	@echo "   - TB_FILES: Pattern for your testbench files"
	@echo "   - INTEGRATION_FILES: Pattern for integration files"
	@echo ""
	@echo "4. Update Documentation:"
	@echo "   - Modify docs/*.md files for your IP"
	@echo "   - Update metadata in vyges-metadata.template.json"
	@echo "   - Use generic examples like 'example.com' in metadata"
	@echo ""
	@echo "5. Test Your Changes:"
	@echo "   - Run 'make check' to verify tools"
	@echo "   - Run 'make build' to test build process"
	@echo "   - Verify all targets work correctly"
	@echo ""
	@echo "Vyges Naming Convention:"
	@echo "  - Repository: fast-fourier-transform-ip (descriptive)"
	@echo "  - Block: fft (short identifier)"
	@echo "  - Module: memory (functionality)"
	@echo "  - RTL File: fft_memory.sv (block-name_module-name.sv)"

#==============================================================================
# Tool Checks
#==============================================================================

.PHONY: check-tools-synth
check-tools-synth:
	@if [ -z "$(YOSYS_AVAILABLE)" ]; then \
		echo "Error: Yosys not found. Please install yosys."; \
		exit 1; \
	fi

.PHONY: check-tools-sim
check-tools-sim:
	@if [ -z "$(VERILATOR_AVAILABLE)" ] && [ -z "$(ICARUS_AVAILABLE)" ]; then \
		echo "Error: Neither Verilator nor Icarus found."; \
		echo "Please install at least one simulation tool."; \
		exit 1; \
	fi

.PHONY: check-tools-sim-fallback
check-tools-sim-fallback:
	@if [ -z "$(ICARUS_AVAILABLE)" ]; then \
		echo "Error: Icarus not found. Please install iverilog."; \
		exit 1; \
	fi

#==============================================================================
# Utility Targets
#==============================================================================

.PHONY: list-files
list-files:
	@echo "Source Files:"
	@echo "============="
	@echo "RTL Files:"
	@for file in $(RTL_FILES); do echo "  $$file"; done
	@echo ""
	@echo "Testbench Files:"
	@for file in $(TB_FILES); do echo "  $$file"; done
	@echo ""
	@echo "Integration Files:"
	@for file in $(INTEGRATION_FILES); do echo "  $$file"; done
	@echo ""
	@echo "Constraint Files:"
	@for file in $(CONSTRAINT_FILES); do echo "  $$file"; done

.PHONY: create-dirs
create-dirs:
	@mkdir -p $(BUILD_DIR) $(SYNTH_DIR) $(SIM_DIR) $(WAVEFORM_DIR) $(LOG_DIR)
	@echo "Build directories created."

#==============================================================================
# Pattern-Based File Processing
#==============================================================================
# These targets demonstrate how to use patterns for generic processing

.PHONY: process-rtl
process-rtl:
	@echo "Processing RTL files..."
	@for file in $(RTL_FILES); do \
		if [ -f "$$file" ]; then \
			echo "Processing $$file"; \
			# Add your RTL processing logic here \
		fi; \
	done

.PHONY: process-tb
process-tb:
	@echo "Processing testbench files..."
	@for file in $(TB_FILES); do \
		if [ -f "$$file" ]; then \
			echo "Processing $$file"; \
			# Add your testbench processing logic here \
		fi; \
	done

#==============================================================================
# End of Makefile
#============================================================================== 
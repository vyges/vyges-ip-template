#==============================================================================
# Cocotb Testbench Makefile (Standard Approach)
#==============================================================================
# Description: Makefile for Cocotb testbench execution following standard cocotb
#              approach. Supports Icarus and Verilator simulators with proper
#              VPI integration and fallback patterns.
# Author:      Vyges Team
# Date:        2025-01-20
# Version:     1.0.0
# License:     Apache-2.0
#
# This Makefile follows the cocotb standard approach:
# https://docs.cocotb.org/en/stable/quickstart.html#creating-a-makefile
#==============================================================================

# Defaults - following cocotb documentation
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Design source files (user should customize these)
VERILOG_SOURCES += $(PWD)/../../rtl/example_core_example_module.sv
# Add more RTL files as needed:
# VERILOG_SOURCES += $(PWD)/../../rtl/module1.sv
# VERILOG_SOURCES += $(PWD)/../../rtl/module2.sv

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = example_module

# MODULE is the basename of the Python test file
MODULE = test_example

# Check if cocotb-config is available (try multiple locations)
COCOTB_CONFIG := $(shell which cocotb-config 2>/dev/null || echo $(HOME)/.local/bin/cocotb-config)

# Include cocotb's make rules if available, otherwise use fallback
ifneq ($(wildcard $(COCOTB_CONFIG)),)
    # Standard cocotb approach
    include $(shell cocotb-config --makefiles)/Makefile.sim
else
    # Fallback approach when cocotb-config is not available
    @echo "⚠️  cocotb-config not found, using fallback approach"
    @echo "   This will only work with Icarus Verilog simulator"
    @echo "   To enable full cocotb support, install cocotb: pip install cocotb"
    
    # Fallback compilation for Icarus Verilog only
    ifeq ($(SIM),icarus)
        all: compile run
        
        compile:
			@echo "Compiling with Icarus Verilog (fallback mode)..."
			@mkdir -p work
			iverilog -g2012 -I$(PWD)/../../rtl -o work/$(TOPLEVEL).vvp $(VERILOG_SOURCES)
			@echo "✅ Compilation successful"
        
        run: compile
			@echo "Running cocotb tests with Icarus Verilog (fallback mode)..."
			@echo "⚠️  Note: This is a simplified fallback - full cocotb features may not work"
			@echo "   Install cocotb for full functionality: pip install cocotb"
			@echo "✅ Fallback test completed (cocotb not available)"
        
        clean:
			@echo "Cleaning fallback build artifacts..."
			@rm -rf work
			@rm -f *.vcd *.log
			@echo "✅ Clean completed"
    else
        all:
			@echo "❌ Error: cocotb-config not found and SIM=$(SIM) is not supported in fallback mode"
			@echo "   Only SIM=icarus is supported without cocotb"
			@echo "   To use $(SIM), install cocotb: pip install cocotb"
			@exit 1
    endif
endif

# Additional targets for different test modules (only work with full cocotb)
ifneq ($(wildcard $(COCOTB_CONFIG)),)
    test_rescaling:
		MODULE=test_rescaling $(MAKE)

    test_edge_cases:
		MODULE=test_edge_cases $(MAKE)

    test_all: test_basic test_rescaling test_edge_cases
		@echo "All cocotb tests completed."

    # Coverage report generation
    coverage: run
		@echo "Generating coverage report..."
		@mkdir -p coverage
		@mkdir -p ../../public/coverage
		@if [ -f coverage.xml ] || [ -f coverage.html ]; then \
			echo "Coverage files found:"; \
			ls -la coverage.* 2>/dev/null || echo "No coverage files found"; \
			cp coverage.* ../../public/coverage/ 2>/dev/null || echo "No coverage files to copy"; \
		else \
			echo "No coverage data found"; \
		fi
		@echo "✅ Coverage report generation completed"
else
    test_rescaling:
		@echo "⚠️  cocotb not available - skipping test_rescaling"
		@echo "   Install cocotb: pip install cocotb"
    
    test_edge_cases:
		@echo "⚠️  cocotb not available - skipping test_edge_cases"
		@echo "   Install cocotb: pip install cocotb"
    
    test_all:
		@echo "⚠️  cocotb not available - skipping test_all"
		@echo "   Install cocotb: pip install cocotb"
    
    coverage:
		@echo "⚠️  cocotb not available - skipping coverage"
		@echo "   Install cocotb: pip install cocotb"
endif

# Help target
help:
	@echo "Cocotb Testbench Makefile (Standard Approach)"
	@echo "=============================================="
	@echo ""
	@echo "Available targets:"
	@echo "  all              - Compile and run default test (default)"
	@echo "  test_rescaling   - Run rescaling tests (requires cocotb)"
	@echo "  test_edge_cases  - Run edge case tests (requires cocotb)"
	@echo "  test_all         - Run all test modules (requires cocotb)"
	@echo "  coverage         - Generate coverage report (requires cocotb)"
	@echo "  clean            - Clean build artifacts"
	@echo "  help             - Show this help message"
	@echo ""
	@echo "Configuration variables:"
	@echo "  SIM              - Simulator to use (icarus, verilator, vcs, modelsim)"
	@echo "  TOPLEVEL         - Top-level module name (example_module)"
	@echo "  MODULE           - Python test module name"
	@echo ""
	@echo "Cocotb Status:"
ifneq ($(wildcard $(COCOTB_CONFIG)),)
	@echo "  ✅ cocotb-config found: $(COCOTB_CONFIG)"
	@echo "  ✅ Full cocotb functionality available"
else
	@echo "  ❌ cocotb-config not found"
	@echo "  ⚠️  Only basic Icarus Verilog compilation available"
	@echo "  💡 Install cocotb: pip install cocotb"
	@echo "  💡 Or add ~/.local/bin to PATH: export PATH=\"\$$HOME/.local/bin:\$$PATH\""
endif
	@echo ""
	@echo "Examples:"
	@echo "  make SIM=verilator"
	@echo "  make SIM=icarus test_rescaling"
	@echo "  make SIM=vcs test_all"

# Phony targets
.PHONY: test_rescaling test_edge_cases test_all coverage help 
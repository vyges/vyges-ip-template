# tb/Makefile - SystemVerilog testbench simulation with multiple simulator support including Verilator

# Simulator choice (iverilog, vlog, vcs, verilator)

# How to run:
# make SIM=iverilog run
# make SIM=vcs run
# make SIM=vlog run (for Questa/ModelSim)
# make SIM=verilator run

# Notes for Verilator:
# - This expects your testbench is a SystemVerilog testbench module that Verilator supports (some SV features may not be supported).
# --trace enables waveform dumping support.
# --build auto-compiles the generated C++ simulation.
# You can add your own C++ testbench code if needed or integrate with DPI or cocotb later.

SIM ?= iverilog
SIM_OPTS ?= -g2012

# Top-level testbench module (for HDL simulators)
TOPLEVEL ?= your_ip_block_tb

# Verilator top-level C++ sim file name (default)
VERILATOR_TOP_CPP ?= Vyour_ip_block_tb.cpp

# Source files
SRCS = \
  ../rtl/top_wrapper.sv \
  ../rtl/your_ip_block.sv \
  ./sv_tb/your_ip_block_tb.sv

# Verilator options
VERILATOR_OPTS = --cc --exe --build --trace --top-module $(TOPLEVEL)

# Output files
SIM_EXEC = simv.out
VERILATOR_EXEC = obj_dir/V$(TOPLEVEL)

# Compilation commands by simulator
ifeq ($(SIM), iverilog)
  COMPILE = iverilog $(SIM_OPTS) -o $(SIM_EXEC) $(SRCS)
  RUN = vvp $(SIM_EXEC)
endif

ifeq ($(SIM), vlog)  # Questa/ModelSim
  COMPILE = vlog -sv $(SRCS)
  RUN = vsim -c -do "run -all; exit" $(TOPLEVEL)
endif

ifeq ($(SIM), vcs)
  COMPILE = vcs -full64 -sverilog $(SRCS) -o $(SIM_EXEC)
  RUN = ./$(SIM_EXEC)
endif

ifeq ($(SIM), verilator)
  COMPILE = verilator $(VERILATOR_OPTS) $(SRCS)
  RUN = ./$(VERILATOR_EXEC)
endif

.PHONY: all clean run

all: $(SIM_EXEC)

$(SIM_EXEC):
ifeq ($(SIM), verilator)
	@echo "Running Verilator to build C++ sim..."
	$(COMPILE)
else
	@echo "Compiling with $(SIM)..."
	$(COMPILE)
endif

run: all
	@echo "Running simulation with $(SIM)..."
	$(RUN)

clean:
	@echo "Cleaning simulation artifacts..."
	rm -rf $(SIM_EXEC) obj_dir coverage csrc *.log *.vpd *.wlf *.key ucli.key


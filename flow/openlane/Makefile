# flow/openlane/Makefile
# Makefile for running OpenLane flow on top_wrapper
#
# This sets up and runs the OpenLane flow for your design using the official OpenLane Docker CLI.
# It assumes:
# - You’re running OpenLane via Docker.
# - Your design files and config.json are located under flow/openlane/.
# - Your design’s top module is top_wrapper.

# Note: Automatically mounts project and PDK directories and works with official OpenLane Docker environment.

# Usage:
# cd flow/openlane
# make run     # runs OpenLane flow using your config.json
# make final   # collects final results (GDS, DEF, etc.) into a final/ dir
# make clean   # removes run artifacts


# Design name
DESIGN_NAME := top_wrapper

# Paths
FLOW_DIR := $(shell pwd)
OPENLANE_ROOT ?= $(HOME)/OpenLane
PDK := sky130A
PDK_ROOT ?= $(HOME)/pdks
CONFIG_FILE := config.json

# Docker image/tag (change if using a different version)
OPENLANE_DOCKER_IMAGE := openlane:latest

# Docker run settings
DOCKER_CMD := docker run -it --rm \
	-v $(OPENLANE_ROOT):/openlane \
	-v $(PDK_ROOT):/pdks \
	-v $(FLOW_DIR):/project \
	-e PDK=$(PDK) \
	-e PDK_ROOT=/pdks \
	-e DESIGN_NAME=$(DESIGN_NAME) \
	-u $(shell id -u):$(shell id -g) \
	$(OPENLANE_DOCKER_IMAGE)

.PHONY: run clean final

## Run the OpenLane flow
run:
	$(DOCKER_CMD) bash -c \
		"cd /openlane && \
		 flow.tcl -design /project -override_config_file /project/$(CONFIG_FILE)"

## Copy GDS, DEF, and netlist outputs to a local final/ directory
final:
	mkdir -p final
	cp -v runs/$(DESIGN_NAME)/results/final/gds/*.gds       final/ || true
	cp -v runs/$(DESIGN_NAME)/results/final/def/*.def       final/ || true
	cp -v runs/$(DESIGN_NAME)/results/final/verilog/*.v     final/ || true
	cp -v runs/$(DESIGN_NAME)/results/final/spef/*.spef     final/ || true
	cp -v runs/$(DESIGN_NAME)/results/final/sdf/*.sdf       final/ || true
	cp -v runs/$(DESIGN_NAME)/results/final/lef/*.lef       final/ || true

## Clean all generated output
clean:
	rm -rf runs final

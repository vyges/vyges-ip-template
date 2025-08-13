# Example IP - Architecture Specification

## Overview

This document describes the architecture of the Example IP block, which serves as a template for developing new IP cores following Vyges standards and best practices. The example demonstrates a generic, configurable data processing module that can be customized for specific IP implementations.

## Block Information

- **Block Name**: `example`
- **Module Name**: `core`
- **Version**: 1.0.0
- **License**: Apache-2.0

## Architecture Overview

The `example` IP block implements a generic, configurable data processing module that demonstrates:

- **Parameterized Design**: Configurable data width, address width, and buffer depth
- **State Machine**: Well-defined operational states with clear transitions
- **Data Buffering**: FIFO-based data storage with overflow protection
- **Configuration Interface**: Runtime configurable parameters
- **Handshaking Protocol**: Valid/ready handshaking for data transfer
- **Security Validation**: Yosys-compatible assertions for verification

## Module Hierarchy

```
example/
├── rtl/
│   └── example_core.sv              # Main RTL module
├── integration/
│   └── example_wrapper.v            # Integration wrapper
├── tb/sv_tb/
│   └── tb_example.sv                # SystemVerilog testbench
└── docs/
    ├── example-architecture.md      # This file
    └── example-design_spec.md       # Detailed design specification
```

## Core Module: example_core

### Interface

The `example_core` provides three main interfaces:

1. **Control Interface**: Module enable, start, clear, and status signals
2. **Data Interface**: Input/output data with valid/ready handshaking
3. **Configuration Interface**: Runtime configuration and status monitoring

### Parameters

- `DATA_WIDTH`: Width of data input/output (default: 32 bits)
- `ADDR_WIDTH`: Width of configuration address (default: 8 bits)
- `BUFFER_DEPTH`: Depth of internal data buffer (default: 16 entries)

### State Machine

The module operates through five distinct states:

1. **ST_IDLE**: Initial state, waiting for start command
2. **ST_CONFIG**: Configuration phase, accepting setup parameters
3. **ST_PROCESS**: Data processing phase, accepting input data
4. **ST_OUTPUT**: Output phase, providing processed data
5. **ST_ERROR**: Error state, requires clear command to recover

## Example Implementation: Countdown Timer IP

As a concrete example, here's how the template could be implemented as a countdown timer:

### Block Diagram

```
             +--------------------+
clk --------->|                    |
rst_n ------->|  Countdown Timer   |
psel -------->|                    |
penable ----->|     APB Slave      |
pwrite ------>|                    |--> irq
paddr  ------>|                    |
pwdata ------>|                    |
              |                    |--> prdata
              +--------------------+
```

### APB Interface

| Signal     | Direction | Width  | Description                        |
|------------|-----------|--------|------------------------------------|
| `psel`     | input     | 1      | APB select                         |
| `penable`  | input     | 1      | APB enable                         |
| `pwrite`   | input     | 1      | APB write enable                   |
| `paddr`    | input     | 16     | APB address                        |
| `pwdata`   | input     | 32     | Write data                         |
| `prdata`   | output    | 32     | Read data                          |
| `pready`   | output    | 1      | Ready handshake                    |
| `irq`      | output    | 1      | Interrupt when count reaches zero |

### Registers

| Address   | Name          | Access | Description                         |
|-----------|---------------|--------|-------------------------------------|
| `0x00`    | `LOAD`        | W      | Set countdown value                 |
| `0x04`    | `VALUE`       | R      | Current countdown value             |
| `0x08`    | `CONTROL`     | RW     | Start, mode config, clear interrupt |
| `0x0C`    | `STATUS`      | R      | IRQ pending, done flag              |

### Timer Parameters

| Parameter   | Type | Default | Description                        |
|-------------|------|---------|------------------------------------|
| `WIDTH`     | int  | 16      | Bit-width of the countdown value   |
| `ONE_SHOT`  | bit  | 0       | 1 = one-shot mode, 0 = periodic     |

### Timer Modes

- **Periodic Mode**: Automatically reloads the `LOAD` value on expiry.
- **One-Shot Mode**: Stops counting after reaching zero and sets `irq`.

## Integration Wrapper: example_wrapper

The `example_wrapper` provides:

- **Interface Consistency**: Maintains consistent signal naming conventions
- **Parameter Passing**: Forwards all parameters to the core module
- **Integration Support**: Easy integration into larger designs

## Testbench: tb_example

The testbench provides comprehensive verification:

- **Reset Testing**: Verifies proper reset behavior
- **Configuration Testing**: Tests configuration interface functionality
- **Data Processing**: Validates data flow and processing
- **Buffer Operations**: Tests FIFO functionality and overflow handling
- **Error Handling**: Verifies error detection and recovery
- **Integration Testing**: End-to-end functionality verification

## Design Principles

### 1. Naming Conventions

- **Inputs**: End with `_i` suffix
- **Outputs**: End with `_o` suffix
- **Active-low signals**: Use `_n` suffix (e.g., `reset_n_i`)

### 2. Reset Strategy

- **Active-low reset**: All flip-flops use `reset_n_i`
- **Synchronous reset**: Reset applied on clock edge
- **Complete initialization**: All registers properly initialized

### 3. Clock Domain

- **Single clock domain**: All logic operates on `clk_i`
- **Synchronous design**: No combinational loops or hazards

### 4. Security and Validation

- **Yosys-compatible assertions**: Uses `YOSYS` define for synthesis
- **Bounds checking**: Validates buffer pointers and counts
- **Reset compliance**: Ensures proper reset behavior

## Performance Characteristics

- **Clock Frequency**: Target 100 MHz operation
- **Latency**: Configurable based on buffer depth
- **Throughput**: One data word per clock cycle (when not stalled)
- **Resource Usage**: Configurable based on parameters

## Verification Strategy

### 1. Functional Coverage

- **State coverage**: All states and transitions covered
- **Data flow coverage**: Input/output scenarios covered
- **Configuration coverage**: Parameter combinations tested

### 2. Assertion-Based Verification

- **Reset behavior**: Ensures proper initialization
- **Buffer bounds**: Prevents pointer overflow
- **State consistency**: Validates state machine operation

### 3. Simulation Support

- **Multiple simulators**: Verilator and Icarus support
- **Waveform generation**: VCD output for debugging
- **Comprehensive testing**: All functionality verified

## Customization Guidelines

### 1. For IP Developers

- **Replace template functionality**: Implement your specific IP logic
- **Maintain naming conventions**: Keep `_i`/`_o` suffixes
- **Update parameters**: Add IP-specific parameters as needed
- **Extend interfaces**: Add required signals while maintaining consistency

### 2. File Naming

- **RTL files**: Use `block-name_module-name.sv` format (e.g., `fft_memory.sv`)
- **Testbench files**: Use `tb_block-name_module-name.sv` format (e.g., `tb_fft_memory.sv`)
- **Wrapper files**: Use `block-name_module-name_wrapper.v` format (e.g., `fft_memory_wrapper.v`)

### 3. Documentation

- **Update this file**: Reflect your IP's specific architecture
- **Create design spec**: Detailed implementation specification
- **Maintain consistency**: Follow established patterns

## Vyges Naming Convention

### **Repository vs Block vs Module**

- **Repository Name**: Descriptive (e.g., `fast-fourier-transform-ip`)
- **Block Name**: Short identifier (e.g., `fft`)
- **Module Name**: Functionality (e.g., `memory`, `controller`, `processor`)
- **RTL Filename**: `block-name_module-name.sv` (e.g., `fft_memory.sv`)

### **Example Customization**

For a UART controller IP:
- **Repository**: `uart-controller-ip`
- **Block**: `uart`
- **Module**: `controller`
- **RTL File**: `uart_controller.sv`
- **Wrapper**: `uart_controller_wrapper.v`
- **Testbench**: `tb_uart_controller.sv`

For a countdown timer IP:
- **Repository**: `countdown-timer-ip`
- **Block**: `timer`
- **Module**: `countdown`
- **RTL File**: `timer_countdown.sv`
- **Wrapper**: `timer_countdown_wrapper.v`
- **Testbench**: `tb_timer_countdown.sv`

## Future Enhancements

### 1. Planned Features

- **Clock domain crossing**: Support for multiple clock domains
- **Advanced protocols**: AXI, APB, or custom bus interfaces
- **Power management**: Clock gating and power-down modes

### 2. Scalability

- **Parameter expansion**: Additional configuration options
- **Interface flexibility**: Configurable interface protocols
- **Performance optimization**: Pipelining and parallel processing

## Notes

- Reset (`rst_n`) clears the counter and control logic.
- The IRQ signal is level-high and should be cleared via a CONTROL register write.
- All modules follow Vyges IP development standards for consistency and maintainability.

## Conclusion

The `example` IP block provides a solid foundation for developing new IP cores while maintaining consistency with Vyges standards. By following the established patterns and conventions, developers can create high-quality, maintainable IP blocks that integrate seamlessly into larger designs.

The countdown timer example demonstrates how the template can be adapted for specific IP implementations while maintaining the overall structure and standards.

For questions or support, refer to the Vyges documentation or contact the development team.

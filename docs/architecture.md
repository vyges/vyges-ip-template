# Architecture: Countdown Timer IP

## Overview

This document describes the internal architecture, APB interface, and design details of the `your_ip_block` 16-bit countdown timer. The module is parameterizable and supports both **periodic** and **one-shot** modes.

---

## Block Diagram

```

```
             +--------------------+
```

clk --------->|                    |
rst\_n ------->|  Countdown Timer   |
psel -------->|                    |
penable ----->|     APB Slave      |
pwrite ------>|                    |--> irq
paddr  ------>|                    |
pwdata ------>|                    |
\|                    |--> prdata
+--------------------+

```

---

## Parameters

| Parameter   | Type | Default | Description                        |
|-------------|------|---------|------------------------------------|
| `WIDTH`     | int  | 16      | Bit-width of the countdown value   |
| `ONE_SHOT`  | bit  | 0       | 1 = one-shot mode, 0 = periodic     |

---

## APB Interface

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

---

## Registers

| Address   | Name          | Access | Description                         |
|-----------|---------------|--------|-------------------------------------|
| `0x00`    | `LOAD`        | W      | Set countdown value                 |
| `0x04`    | `VALUE`       | R      | Current countdown value             |
| `0x08`    | `CONTROL`     | RW     | Start, mode config, clear interrupt |
| `0x0C`    | `STATUS`      | R      | IRQ pending, done flag              |

---

## Internal Modules

- **Timer Core**: Decrements internal counter every clock cycle.
- **Control Logic**: Handles start/restart logic and IRQ generation.
- **APB Interface**: Implements APB3 slave protocol with `pready` and `prdata`.

---

## Modes

- **Periodic Mode**: Automatically reloads the `LOAD` value on expiry.
- **One-Shot Mode**: Stops counting after reaching zero and sets `irq`.

---

## Notes

- Reset (`rst_n`) clears the counter and control logic.
- The IRQ signal is level-high and should be cleared via a CONTROL register write.

---

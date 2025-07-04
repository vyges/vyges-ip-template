# Waveform Examples: Countdown Timer IP

This document captures key waveform behaviors observed in simulation to verify correct functionality.

---

## 1. Timer Load and Start (Write to LOAD)

**Scenario**: Timer is initialized and starts countdown after `LOAD` register is written.

```

| Time(ns) | clk | rst\_n | psel | penable | pwrite | paddr  | pwdata     | pready | irq | Notes              |
| -------- | --- | ------ | ---- | ------- | ------ | ------ | ---------- | ------ | --- | ------------------ |
| 0        | 0   | 0      | 0    | 0       | 0      | -      | -          | 0      | 0   | Reset active       |
| 100      | 1   | 1      | 1    | 1       | 1      | 0x0000 | 0x000000FF | 1      | 0   | Write LOAD=0xFF    |
| 110      | 1   | 1      | 0    | 0       | 0      | -      | -          | 0      | 0   | Start countdown    |
| ...      | ... | 1      | -    | -       | -      | -      | -          | -      | 0   | VALUE decrements   |
| XXX      | 1   | 1      | 0    | 0       | 0      | -      | -          | -      | 1   | IRQ raised on zero |

```

---

## 2. Read VALUE register while counting

**Scenario**: Poll current timer value via APB read.

```

* APB read to address 0x0004 shows decreasing count value every cycle.

```

---

## 3. One-Shot Mode Behavior

**Scenario**: Timer expires once and stops in one-shot mode.

- Set `ONE_SHOT=1`
- Write to LOAD
- Verify `irq` is raised once
- Confirm `VALUE` stays at zero after IRQ
- No further `irq` until reloaded

---

## 4. Periodic Mode Behavior

**Scenario**: Timer continuously reloads and generates periodic `irq`.

- Set `ONE_SHOT=0`
- Write to LOAD
- Observe `irq` triggered repeatedly after countdown
- Confirm VALUE resets to LOAD after each expiry

---

## 5. Reset Behavior

**Scenario**: Asserting `rst_n = 0` immediately clears timer state.

- `VALUE` resets
- `irq` clears
- No APB access during reset

---

## Notes

- All waveforms can be visualized in GTKWave, ModelSim, or open-source VCD viewers.
- Use APB transaction log to correlate waveform timing with register access.

---


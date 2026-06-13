
---

# Static Branch Predictor (BTFNT)

```md
# Static Branch Predictor using BTFNT Strategy

## Objective

The objective of this assignment is to design and implement a Static Branch Predictor for a 5-stage RV32I pipelined processor.

Branch prediction helps reduce the performance penalty caused by control hazards.

---

## Introduction

Whenever a branch instruction is encountered, the processor must decide whether the branch will be taken or not taken.

Waiting until the branch condition is resolved introduces pipeline stalls and reduces performance.

Branch prediction attempts to predict the branch outcome before it is actually resolved.

---

## Types of Branch Prediction

### Static Prediction

Prediction decision is fixed and does not change during execution.

Examples:

- Always Taken
- Always Not Taken
- BTFNT (Backward Taken Forward Not Taken)

---

### Dynamic Prediction

Prediction is based on runtime history.

Examples:

- 1-bit predictor
- 2-bit predictor
- Branch History Table (BHT)
- Tournament predictor

---

## Implemented Predictor

### BTFNT

Backward Taken Forward Not Taken

This method assumes:

- Backward branches are usually loop branches.
- Loop branches are typically taken.
- Forward branches are usually conditional branches and are less likely to be taken.

---

## Prediction Rule

If branch offset is negative:

```text
Predict TAKEN

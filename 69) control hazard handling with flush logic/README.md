# Control Hazard Handling using Flush Logic in 5-Stage RV32I Pipeline

## Objective

The objective of this assignment is to implement and integrate control hazard handling in a 5-stage pipelined RV32I processor.

Control hazards occur when branch instructions change the normal sequential flow of instruction execution. Instructions fetched after a branch may become invalid if the branch is taken.

To resolve this issue, flush logic has been implemented.

---

## Pipeline Stages

1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execute (EX)
4. Memory Access (MEM)
5. Write Back (WB)

---

## Problem Statement

Consider the following branch instruction:

```assembly
BEQ x1, x2, LABEL

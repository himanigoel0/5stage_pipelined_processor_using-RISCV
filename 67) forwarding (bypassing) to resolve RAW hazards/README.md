# Forwarding Unit for Resolving RAW Data Hazards in a 5-Stage Pipelined RISC-V Processor

## Objective

The objective of this project is to design and implement a Forwarding Unit (Bypassing Unit) to resolve Read After Write (RAW) data hazards in a 5-stage pipelined RISC-V processor without introducing unnecessary pipeline stalls.

---

# Introduction

Pipelining improves processor throughput by allowing multiple instructions to execute simultaneously in different stages of execution.

A standard 5-stage RISC-V pipeline consists of:

1. IF  - Instruction Fetch
2. ID  - Instruction Decode / Register Read
3. EX  - Execute
4. MEM - Memory Access
5. WB  - Write Back

Although pipelining increases performance, it introduces data hazards when instructions depend on results produced by earlier instructions.

One solution is stalling the pipeline. However, stalling reduces performance because useful work is delayed.

A better solution is Forwarding.

---

# What is Forwarding?

Forwarding (also called Bypassing) is a technique in which the result produced by an instruction is directly sent to a later instruction before it is written back to the register file.

Instead of waiting for the WB stage, the data is forwarded from intermediate pipeline stages.

---

# Read After Write (RAW) Hazard

Consider the following instruction sequence:

```assembly
ADD x3, x2, x5
SUB x4, x3, x2
```

Instruction 1:

```assembly
ADD x3, x2, x5
```

produces:

```text
x3 = x2 + x5
```

Instruction 2:

```assembly
SUB x4, x3, x2
```

requires the value of x3.

---

# Pipeline Execution Without Forwarding

| Cycle | ADD | SUB |
| ----- | --- | --- |
| 1     | IF  |     |
| 2     | ID  | IF  |
| 3     | EX  | ID  |
| 4     | MEM | EX  |
| 5     | WB  | MEM |
| 6     |     | WB  |

At Cycle 4:

```text
SUB needs x3
```

but

```text
ADD has not yet written x3 back to the register file.
```

This creates a RAW hazard.

---

# Solution Using Stalling

The Hazard Detection Unit resolves the hazard by introducing bubbles.

Pipeline:

| Cycle | ADD | SUB   |
| ----- | --- | ----- |
| 1     | IF  |       |
| 2     | ID  | IF    |
| 3     | EX  | ID    |
| 4     | MEM | Stall |
| 5     | WB  | Stall |
| 6     |     | ID    |
| 7     |     | EX    |
| 8     |     | MEM   |
| 9     |     | WB    |

Correct execution is achieved, but performance is reduced due to the inserted stall cycles.

---

# Solution Using Forwarding

Observe that the ADD instruction computes its result during the EX stage.

At Cycle 3:

```text
ALU Result = 120
```

Instead of waiting until WB, this result can be directly supplied to the ALU inputs of the next instruction.

Pipeline:

| Cycle | ADD | SUB                 |
| ----- | --- | ------------------- |
| 1     | IF  |                     |
| 2     | ID  | IF                  |
| 3     | EX  | ID                  |
| 4     | MEM | EX (Forwarded Data) |
| 5     | WB  | MEM                 |
| 6     |     | WB                  |

No stall cycles are required.

---

# Forwarding Concept

Without forwarding:

```text
ADD
  ↓
Register File
  ↓
SUB
```

With forwarding:

```text
ADD EX Result
      │
      ▼
SUB EX Input
```

The data bypasses the register file entirely.

---

# Forwarding Unit

The forwarding unit continuously compares:

### Current Instruction

Located in the ID/EX pipeline register:

```text
ID/EX.rs1
ID/EX.rs2
```

### Previous Instruction

Located in the EX/MEM pipeline register:

```text
EX/MEM.rd
EX/MEM.RegWrite
```

---

# Forwarding Conditions

Forward ALU Input A if:

```text
EX/MEM.RegWrite = 1

AND

EX/MEM.rd ≠ 0

AND

EX/MEM.rd = ID/EX.rs1
```

Forward ALU Input B if:

```text
EX/MEM.RegWrite = 1

AND

EX/MEM.rd ≠ 0

AND

EX/MEM.rd = ID/EX.rs2
```

---

# Why rd ≠ 0?

Register x0 in RISC-V is hardwired to zero.

Its value never changes regardless of any write attempts.

Example:

```assembly
ADD x0, x2, x5
```

Even though the ALU computes a result, x0 remains zero.

Therefore forwarding from x0 is unnecessary and should be ignored.

---

# Forwarding Unit Logic

Verilog implementation:

```verilog
always @(*) begin

    forwardA = 0;
    forwardB = 0;

    if(exmem_regwrite &&
       exmem_rd != 0 &&
       exmem_rd == idex_rs1)
        forwardA = 1;

    if(exmem_regwrite &&
       exmem_rd != 0 &&
       exmem_rd == idex_rs2)
        forwardB = 1;

end
```

---

# ALU Input Multiplexers

Normal ALU operation:

```text
ALU Input A = Register File Output 1
ALU Input B = Register File Output 2
```

After forwarding:

```text
ALU Input A
      │
      ├── Register File Data
      └── Forwarded EX/MEM Result

ALU Input B
      │
      ├── Register File Data
      └── Forwarded EX/MEM Result
```

The forwarding control signals select the appropriate source.

---

# Example

Instruction Sequence:

```assembly
ADD x3, x2, x5
SUB x4, x3, x2
```

Assume:

```text
x2 = 20
x5 = 100
```

Execution:

```text
ADD Result = 120
```

Forwarding Unit detects:

```text
EX/MEM.rd = 3

ID/EX.rs1 = 3
```

Therefore:

```text
forwardA = 1
```

The value 120 is directly forwarded to the ALU input of SUB.

Result:

```text
SUB = 120 - 20 = 100
```

No stall cycles are required.

---

# Hardware Signals Used

Inputs:

```text
idex_rs1
idex_rs2

exmem_rd
exmem_regwrite
```

Outputs:

```text
forwardA
forwardB
```

Additional Hardware:

```text
2-to-1 Multiplexer for ALU Input A
2-to-1 Multiplexer for ALU Input B
```

---

# Advantages

* Eliminates unnecessary pipeline stalls.
* Improves processor throughput.
* Reduces execution latency.
* Increases pipeline efficiency.

---

# Limitations

Forwarding cannot solve all hazards.

Example:

```assembly
LW x3, 0(x1)
ADD x4, x3, x2
```

The data from LW becomes available only after the MEM stage.

Therefore forwarding alone is insufficient.

A Hazard Detection Unit is still required to handle Load-Use Hazards.

---

# Relationship Between Hazard Detection and Forwarding

Hazard Detection Unit:

```text
Detect Dependency
        ↓
Insert Stall
```

Forwarding Unit:

```text
Detect Dependency
        ↓
Bypass Data
```

Modern processors use both techniques together:

```text
Forwarding Unit
+
Hazard Detection Unit
```

to achieve both correctness and high performance.

---

# Conclusion

A Forwarding Unit was designed to resolve RAW data hazards in a 5-stage pipelined RISC-V processor. The unit compares source registers of the current instruction with destination registers of previous instructions and forwards the required data directly to the ALU inputs whenever a dependency is detected. This eliminates many unnecessary pipeline stalls and significantly improves processor performance while maintaining correct program execution.

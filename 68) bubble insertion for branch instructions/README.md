# Branch Bubble Insertion for Control Hazard Resolution in a 5-Stage Pipelined RISC-V Processor

## Objective

The objective of this project is to implement a Branch Bubble Insertion (Flush) mechanism to resolve control hazards caused by branch instructions in a 5-stage pipelined RISC-V processor.

---

# Introduction

Pipelining improves processor throughput by allowing multiple instructions to execute simultaneously in different pipeline stages.

A typical RISC-V pipeline consists of:

1. IF - Instruction Fetch
2. ID - Instruction Decode
3. EX - Execute
4. MEM - Memory Access
5. WB - Write Back

While pipelining improves performance, it introduces hazards that can lead to incorrect execution if not properly handled.

One such hazard is the Control Hazard.

---

# What is a Control Hazard?

A control hazard occurs when the processor encounters a branch instruction and does not yet know whether the branch will be taken or not.

Example:

```assembly
BEQ x1, x2, LABEL
ADD x5, x6, x7
SUB x8, x9, x10
```

The processor continues fetching instructions sequentially before the branch decision is known.

If the branch is eventually taken, the fetched ADD and SUB instructions are incorrect.

---

# Pipeline Execution Without Flush

| Cycle | BEQ | ADD | SUB |
| ----- | --- | --- | --- |
| 1     | IF  |     |     |
| 2     | ID  | IF  |     |
| 3     | EX  | ID  | IF  |
| 4     | MEM | EX  | ID  |
| 5     | WB  | MEM | EX  |

Assume:

```text
BEQ evaluates TRUE
```

The ADD and SUB instructions should never have entered the pipeline.

However, they have already been fetched and partially executed.

This leads to incorrect program execution.

---

# Solution: Bubble Insertion

When a branch is taken, all incorrectly fetched instructions must be removed from the pipeline.

This is accomplished by replacing them with NOP instructions.

Example:

Before Flush:

```text
BEQ
ADD
SUB
```

After Flush:

```text
BEQ
NOP
NOP
```

These NOP instructions are called Bubbles.

---

# Branch Flush Mechanism

When:

```text
branch_taken = 1
```

the processor performs the following operations:

### Flush IF/ID Register

The instruction currently in the decode stage is replaced with a NOP.

```verilog
instr_out <= 32'h00000013;
```

---

### Flush ID/EX Register

All control signals are cleared.

```verilog
regwrite = 0;
memread  = 0;
memwrite = 0;
branch   = 0;
jump     = 0;
```

This converts the instruction into a NOP.

---

# Branch Flush Unit

Inputs:

```text
branch_taken
```

Outputs:

```text
flush_ifid
flush_idex
```

Logic:

```verilog
assign flush_ifid = branch_taken;
assign flush_idex = branch_taken;
```

---

# Example

Program:

```assembly
BEQ x1,x1,LABEL
ADD x5,x6,x7
SUB x8,x9,x10

LABEL:
AND x3,x4,x5
```

Since:

```text
x1 == x1
```

the branch is taken.

The ADD and SUB instructions are invalid.

The flush mechanism inserts bubbles:

```text
BEQ
NOP
NOP
AND
```

Result:

Only valid instructions execute.

---

# Hardware Signals Used

Inputs:

```text
branch_taken
```

Outputs:

```text
flush_ifid
flush_idex
```

Pipeline Registers Modified:

```text
IF/ID Register
ID/EX Register
```

---

# Difference Between Stall and Flush

| Stall                           | Flush                    |
| ------------------------------- | ------------------------ |
| Holds instruction               | Removes instruction      |
| Used for Data Hazards           | Used for Control Hazards |
| Freezes PC                      | Redirects PC             |
| Instruction remains in pipeline | Instruction becomes NOP  |

---

# Advantages

* Prevents execution of incorrect instructions.
* Ensures correct branch handling.
* Simple implementation.
* Forms the basis for branch prediction mechanisms.

---

# Limitations

* Wastes pipeline cycles whenever a branch is taken.
* Reduces overall processor performance.
* Multiple bubbles may be introduced.

---

# Future Improvements

Branch Prediction can be added to reduce the number of bubbles inserted due to branch instructions.

Predicting branch outcomes correctly reduces flushes and improves processor throughput.

---

# Conclusion

A Branch Bubble Insertion mechanism was implemented to resolve control hazards in a 5-stage pipelined RISC-V processor. When a branch is taken, the IF/ID and ID/EX pipeline registers are flushed by inserting NOP instructions, preventing incorrectly fetched instructions from executing. This ensures correct program execution and serves as a foundation for advanced branch handling techniques such as branch prediction.

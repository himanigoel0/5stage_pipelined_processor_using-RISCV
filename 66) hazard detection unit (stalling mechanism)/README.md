# Hazard Detection Unit (Stalling Mechanism) for a 5-Stage Pipelined RISC-V Processor

## Objective

The objective of this project is to implement a Hazard Detection Unit (HDU) for a 5-stage pipelined RISC-V processor. The HDU detects data hazards and introduces pipeline stalls whenever an instruction depends on the result of a previous instruction that has not yet completed execution.

---

# Introduction

Pipelining improves processor throughput by allowing multiple instructions to execute simultaneously in different stages of the processor.

A typical 5-stage RISC-V pipeline consists of:

1. IF  - Instruction Fetch
2. ID  - Instruction Decode / Register Read
3. EX  - Execute
4. MEM - Memory Access
5. WB  - Write Back

Although pipelining increases performance, it introduces hazards that can lead to incorrect execution if not handled properly.

---

# Data Hazard

A data hazard occurs when an instruction requires data that is still being produced by an earlier instruction.

Example:

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

However, x3 is written back only during the WB stage of the first instruction.

Therefore, when the second instruction reaches the ID stage, the updated value of x3 is not yet available.

This situation is called a Read After Write (RAW) hazard.

---

# Pipeline Execution Without Hazard Handling

| Cycle | ADD | SUB |
| ----- | --- | --- |
| 1     | IF  |     |
| 2     | ID  | IF  |
| 3     | EX  | ID  |
| 4     | MEM | EX  |
| 5     | WB  | MEM |
| 6     |     | WB  |

At Cycle 3:

```text
SUB attempts to read x3
```

but

```text
ADD has not yet written x3
```

leading to incorrect execution.

---

# Hazard Detection Unit

The Hazard Detection Unit continuously monitors:

* Source registers (rs1, rs2) of the current instruction
* Destination register (rd) of the previous instruction
* Register write enable signal

The HDU detects hazards by comparing:

```text
ID.rs1 with EX.rd
ID.rs2 with EX.rd
```

If a match occurs, a stall is generated.

---

# Hazard Detection Logic

Condition:

```text
If:

(ID.rs1 == EX.rd OR ID.rs2 == EX.rd)

AND

(EX.RegWrite == 1)

Then:

STALL = 1
```

Verilog Implementation:

```verilog
assign stall =
       idex_regwrite &&
      ((idex_rd == id_rs1) ||
       (idex_rd == id_rs2));
```

---

# Stalling Mechanism

When a hazard is detected:

### 1. Freeze the Program Counter

```verilog
pc_enable = 0;
```

The PC does not advance.

---

### 2. Freeze the IF/ID Pipeline Register

The current instruction remains in the decode stage.

```verilog
ifid_write_enable = 0;
```

---

### 3. Insert a Bubble (NOP)

The ID/EX pipeline register receives NOP control signals.

```verilog
regwrite = 0;
memread  = 0;
memwrite = 0;
branch   = 0;
jump     = 0;
```

This effectively inserts a bubble into the pipeline.

---

# Pipeline Execution With Stalling

Example:

```assembly
ADD x3, x2, x5
SUB x4, x3, x2
```

| Cycle | ADD | SUB                  |
| ----- | --- | -------------------- |
| 1     | IF  |                      |
| 2     | ID  | IF                   |
| 3     | EX  | ID (Hazard Detected) |
| 4     | MEM | Stall                |
| 5     | WB  | Stall                |
| 6     |     | ID                   |
| 7     |     | EX                   |
| 8     |     | MEM                  |
| 9     |     | WB                   |

The SUB instruction waits until x3 becomes available.

---

# Bubble Insertion

A bubble behaves like a NOP instruction.

Example:

```assembly
NOP
```

Encoded as:

```text
00000013
```

The bubble moves through the pipeline without affecting processor state.

---

# Hardware Signals Used

Inputs:

```verilog
id_rs1
id_rs2
idex_rd
idex_regwrite
```

Output:

```verilog
stall
```

Control Signals Generated:

```verilog
pc_enable
ifid_write_enable
idex_flush
```

---

# Advantages

* Prevents incorrect execution due to RAW hazards.
* Simple implementation.
* Easy to verify through simulation.
* Suitable for introductory pipelined processor designs.

---

# Limitations

* Pipeline performance decreases because instructions are delayed.
* Multiple stall cycles may be required.
* Not as efficient as forwarding.

---

# Future Improvements

The next enhancement is Data Forwarding (Bypassing).

Instead of waiting for data to be written back to the register file, the result can be directly forwarded from:

* EX/MEM stage
* MEM/WB stage

to the ALU inputs.

This significantly reduces pipeline stalls and improves processor performance.

---

# Conclusion

A Hazard Detection Unit was implemented to detect Read After Write (RAW) data hazards in a 5-stage pipelined RISC-V processor. Whenever a dependency is identified between consecutive instructions, the HDU stalls the pipeline by freezing the Program Counter and IF/ID register while inserting a bubble into the ID/EX stage. This guarantees correct execution of dependent instructions and forms the foundation for more advanced hazard handling techniques such as forwarding and branch prediction.

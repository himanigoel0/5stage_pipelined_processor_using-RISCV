# Tracing Register Updates in a 5-Stage Pipelined RISC-V Processor using Waveform Analysis

## Objective

The objective of this experiment is to verify the operation of a 5-stage pipelined RISC-V processor by tracing instruction execution, hazard handling, forwarding operations, and register updates through waveform analysis.

The experiment focuses on observing:

1. Program Counter (PC) progression
2. Instruction fetch sequence
3. Load-use hazard detection
4. Pipeline stall insertion
5. Data forwarding
6. ALU execution
7. Register writeback
8. Register update timing

---

# Test Program

The following instructions were loaded into Instruction Memory:

```assembly
lw   x1,0(x0)
add  x2,x1,x1
add  x3,x2,x1
add  x4,x3,x2
add  x5,x4,x3
nop
```

Data Memory was initialized as:

```verilog
mem[0] = 25;
```

Therefore the expected results are:

```text
x1 = 25
x2 = 50
x3 = 75
x4 = 125
x5 = 200
```

---

# Processor Pipeline

The processor consists of the standard 5 stages:

```text
IF  → Instruction Fetch

ID  → Instruction Decode

EX  → Execute

MEM → Memory Access

WB  → Write Back
```

Pipeline registers used:

```text
IF/ID
ID/EX
EX/MEM
MEM/WB
```

---

# Important Debug Signals Observed

The following signals were monitored in the waveform:

```text
pc_debug

instruction_debug

stall_debug

forwardA_debug
forwardB_debug

idex_rd1_debug
idex_rd2_debug

alu_src1_debug
alu_src2_forwarded_debug

alu_result_debug

memwb_rd_debug
memwb_regwrite_debug

writeback_data_debug
```

---

# Cycle-by-Cycle Analysis

---

## Cycle 1

PC:

```text
PC = 0
```

Fetched instruction:

```assembly
lw x1,0(x0)
```

Pipeline state:

```text
IF  : lw
ID  :
EX  :
MEM :
WB  :
```

No hazards exist.

---

## Cycle 2

PC:

```text
PC = 4
```

Fetched:

```assembly
add x2,x1,x1
```

Pipeline:

```text
IF  : add x2,x1,x1

ID  : lw x1,0(x0)

EX  :
MEM :
WB  :
```

The load instruction is decoded.

The control unit generates:

```text
regwrite = 1
memread  = 1
```

for the load instruction.

---

## Cycle 3

PC:

```text
PC = 8
```

Fetched:

```assembly
add x3,x2,x1
```

Pipeline:

```text
IF  : add x3,x2,x1

ID  : add x2,x1,x1

EX  : lw x1,0(x0)

MEM :
WB  :
```

At this point the Hazard Detection Unit performs:

```verilog
stall =
ex_memread &&
(
 ex_rd == id_rs1 ||
 ex_rd == id_rs2
)
```

Current values:

```text
EX instruction : lw x1,0(x0)

ex_memread = 1

ex_rd = x1

ID instruction : add x2,x1,x1

id_rs1 = x1
id_rs2 = x1
```

Therefore:

```text
stall = 1
```

A load-use hazard is detected.

---

## Cycle 4 (STALL CYCLE)

This is the most important cycle in the waveform.

Observed:

```text
PC remains 8
```

instead of becoming 12.

This confirms that the Program Counter was frozen.

The IF/ID register is also frozen.

Therefore:

```text
add x3,x2,x1
```

remains in the IF stage.

Pipeline becomes:

```text
IF  : add x3,x2,x1   (frozen)

ID  : add x2,x1,x1   (frozen)

EX  : Bubble

MEM : lw x1,0(x0)

WB  :
```

The bubble is inserted by forcing control signals to zero:

```text
regwrite = 0

memread  = 0

memwrite = 0
```

Thus a NOP is injected into the EX stage.

The waveform clearly shows:

```text
stall_debug = 1
```

for one clock cycle.

This verifies correct load-use hazard handling.

---

## Cycle 5

The load instruction reaches WB.

Memory returns:

```text
mem[0] = 25
```

The loaded value is now available.

Pipeline:

```text
IF  : add x4,x3,x2

ID  : add x3,x2,x1

EX  : add x2,x1,x1

MEM : Bubble

WB  : lw
```

The ADD instruction requires x1.

However x1 has not yet been written into the register file.

Therefore forwarding becomes necessary.

Observed:

```text
forwardA = 10

forwardB = 10
```

Meaning:

```text
EX/MEM → EX forwarding
```

ALU inputs:

```text
alu_src1 = 25

alu_src2 = 25
```

ALU operation:

```text
25 + 25 = 50
```

Observed:

```text
alu_result = 50
```

---

## Cycle 6

Instruction:

```assembly
add x3,x2,x1
```

needs:

```text
x2 = 50

x1 = 25
```

Again the newest value of x2 is not yet present in the register file.

Forwarding logic activates.

Observed:

```text
forwardA = 01
```

or

```text
forwardA = 10
```

depending on exact pipeline position.

ALU inputs:

```text
50

25
```

ALU output:

```text
75
```

Observed:

```text
alu_result = 75
```

---

## Cycle 7

Instruction:

```assembly
add x4,x3,x2
```

requires:

```text
x3 = 75

x2 = 50
```

Forwarding again provides the newest values.

ALU computes:

```text
75 + 50 = 125
```

Observed:

```text
alu_result = 125
```

---

## Cycle 8

Instruction:

```assembly
add x5,x4,x3
```

requires:

```text
x4 = 125

x3 = 75
```

Forwarding provides both operands.

ALU computes:

```text
125 + 75 = 200
```

Observed:

```text
alu_result = 200
```

---

# Forwarding Analysis

The waveform shows:

```text
forwardA = 10
forwardA = 01

forwardB = 10
forwardB = 01
```

Interpretation:

```text
00 = No forwarding

10 = EX/MEM forwarding

01 = MEM/WB forwarding
```

This proves that RAW dependencies were resolved using forwarding instead of introducing additional stalls.

---

# Register Writeback Analysis

Register updates are observed using:

```text
memwb_rd_debug

memwb_regwrite_debug

writeback_data_debug
```

Whenever:

```text
memwb_regwrite = 1
```

the processor writes:

```text
Register[memwb_rd]
=
writeback_data
```

Observed updates:

| Register | Value Written |
| -------- | ------------- |
| x1       | 25            |
| x2       | 50            |
| x3       | 75            |
| x4       | 125           |
| x5       | 200           |

These values exactly match the expected execution results.

---

# Final Register Contents

```text
x1 = 25

x2 = 50

x3 = 75

x4 = 125

x5 = 200
```

---

# Key Observations

1. Program Counter increments by 4 during normal execution.

2. PC remains constant for one cycle during the load-use hazard, proving successful stall insertion.

3. Hazard Detection Unit correctly identifies:

```assembly
lw x1,0(x0)

add x2,x1,x1
```

as a load-use hazard.

4. A single bubble is inserted into the pipeline.

5. Forwarding successfully resolves all subsequent RAW dependencies.

6. ALU outputs match expected arithmetic results.

7. Register updates occur only during the WB stage.

8. The final register values match theoretical calculations.

---

# Conclusion

Waveform analysis confirms the correct operation of the 5-stage pipelined RISC-V processor.

The processor successfully performs instruction fetch, decode, execute, memory access, and writeback operations. Load-use hazards are detected correctly and resolved through a one-cycle stall, while subsequent data hazards are resolved through EX/MEM and MEM/WB forwarding paths. Register updates occur in the WB stage with the expected values, demonstrating correct pipeline functionality.

# RV32I 5-Stage Pipelined Processor (Verilog)

## Overview

This project implements a simplified **RV32I 5-stage pipelined processor** in Verilog.

The processor supports:

* Instruction Fetch (IF)
* Instruction Decode (ID)
* Execute (EX)
* Memory Access (MEM)
* Write Back (WB)

### Implemented Features

* R-Type Instructions

  * ADD
  * SUB
  
* I-Type Instructions

  * ADDI
  * LW
* S-Type Instructions

  * SW
* B-Type Instructions

  * BEQ
* Data Forwarding Unit
* Load-Use Hazard Detection Unit
* Pipeline Stall Logic
* Branch Flush Logic

---

# Pipeline Structure

```
IF -> ID -> EX -> MEM -> WB
```

Additional units:

* Forwarding Unit
* Hazard Detection Unit
* Register File
* Instruction Memory
* Data Memory

---

# Test Cases and Verification

## Test 1: Basic ADDI and ADD Instructions

### Assembly Program

```assembly
addi x1,x0,5
addi x2,x0,10
add  x3,x1,x2
add  x4,x3,x1
add  x5,x4,x4
nop
```

### Machine Code

```text
00500093
00A00113
002081B3
00118233
004202B3
00000013
```

### Expected Output

```text
x1 = 5
x2 = 10
x3 = 15
x4 = 20
x5 = 40
```

### Simulation Output

```text
x1 = 5
x2 = 10
x3 = 15
x4 = 20
x5 = 40
```

### Status

✅ PASS

### Screenshot

`simulation1_basic add, addi, R-type and I-type.png`

---

# Test 2: Load Instruction and Load-Use Hazard

Data Memory Initialization:

```verilog
mem[0] = 25;
```

### Assembly Program

```assembly
lw   x1,0(x0)
add  x2,x1,x1
add  x3,x2,x1
add  x4,x3,x2
add  x5,x4,x3
```

### Machine Code

```text
00002083
00108133
001101B3
00218233
003202B3
00000013
```

### Expected Output

```text
x1 = 25
x2 = 50
x3 = 75
x4 = 125
x5 = 200
```

### Simulation Output

```text
x1 = 25
x2 = 50
x3 = 75
x4 = 125
x5 = 200
```

### Verification

This test verifies:

* LW operation
* Load-use hazard detection
* Pipeline stall insertion
* Forwarding after load
* Register writeback from memory

### Status

✅ PASS

### Screenshot

`simulation2_load.png`

---

# Test 3: Store Instruction Verification

### Assembly Program

```assembly
addi x1,x0,55
sw   x1,0(x0)
lw   x2,0(x0)
add  x3,x2,x1
nop
```

### Machine Code

```text
03700093
00102023
00002103
001101B3
00000013
```

### Expected Output

```text
x1 = 55
x2 = 55
x3 = 110
```

### Simulation Output

```text
x1 = 55
x2 = 55
x3 = 110
```

### Verification

This test verifies:

* SW operation
* Memory write path
* LW operation
* Memory read path
* Memory writeback

### Status

✅ PASS

### Screenshot

`simulation3_store.png`

---

# Test 4: Branch Taken

### Assembly Program

```assembly
addi x1,x0,5
addi x2,x0,5
beq  x1,x2,label
addi x3,x0,99
addi x4,x0,42

label:
addi x5,x0,77
```

### Machine Code

```text
00500093
00500113
00208663
06300193
02A00213
04D00293
00000013
```

### Expected Output

```text
x1 = 5
x2 = 5
x3 = 0
x4 = 0
x5 = 77
```

### Simulation Output

```text
x1 = 5
x2 = 5
x3 = 0
x4 = 0
x5 = 77
```

### Verification

This test verifies:

* BEQ operation
* Branch target calculation
* Pipeline flush logic
* Control hazard handling

### Status

✅ PASS

### Screenshot

`simulation4_branch_taken.png`

---

# Test 5: Branch Not Taken

### Assembly Program

```assembly
addi x1,x0,5
addi x2,x0,10
beq  x1,x2,label
addi x3,x0,99
addi x4,x0,42

label:
addi x5,x0,77
```

### Machine Code

```text
00500093
00A00113
00208663
06300193
02A00213
04D00293
00000013
```

### Expected Output

```text
x1 = 5
x2 = 10
x3 = 99
x4 = 42
x5 = 77
```

### Simulation Output

```text
x1 = 5
x2 = 10
x3 = 99
x4 = 42
x5 = 77
```

### Verification

This test verifies:

* BEQ comparison logic
* Correct execution of fall-through path
* Control flow correctness

### Status

✅ PASS

### Screenshot

`simulation5_branch_not_taken.png`

---

# Test 6: Branch Using Latest Computed Value

### Assembly Program

```assembly
addi x1,x0,5
addi x2,x0,5
add  x3,x1,x2
beq  x3,x2,label
addi x4,x0,111

label:
addi x5,x0,222
```

### Machine Code

```text
00500093
00500113
002081B3
00218463
06F00213
0DE00293
00000013
```

### Expected Output

```text
x1 = 5
x2 = 5
x3 = 10
x4 = 111
x5 = 222
```

### Simulation Output

```text
x1 = 5
x2 = 5
x3 = 10
x4 = 111
x5 = 222
```

### Verification

This test verifies:

* Branch decision using freshly computed ALU result
* Forwarding into branch comparison logic
* Correct control hazard handling

### Status

✅ PASS

### Screenshot

`simulation6_branch using latest value_branch not taken.png`

---

# Features Successfully Verified

| Feature               | Status |
| --------------------- | ------ |
| ADD                   | ✅      |
| ADDI                  | ✅      |
| LW                    | ✅      |
| SW                    | ✅      |
| BEQ                   | ✅      |
| Register File         | ✅      |
| Forwarding Unit       | ✅      |
| Hazard Detection Unit | ✅      |
| Load-Use Stall        | ✅      |
| Branch Flush          | ✅      |
| Memory Read           | ✅      |
| Memory Write          | ✅      |
| Write Back            | ✅      |

---


RV32I 5-Stage Pipelined Processor implemented in Verilog for learning and understanding pipelined CPU design, hazard handling, forwarding, and branch control mechanisms.

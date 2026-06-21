# Running a RISC-V Fibonacci Program from Memory

## Objective

To verify that the RV32I 5-stage pipelined processor can execute a complete RISC-V program stored in instruction memory by generating the Fibonacci sequence.

---

## Fibonacci Sequence

The Fibonacci sequence is generated using the recurrence relation:

```text
F(n) = F(n-1) + F(n-2)
```

Example:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21 ...
```

---

## Program Description

The Fibonacci program was stored in instruction memory (IMEM) and executed by the processor.

Initial values:

```assembly
addi x1, x0, 0
addi x2, x0, 1
```

Successive Fibonacci numbers were generated using ADD instructions:

```assembly
add x3, x1, x2
add x4, x3, x2
add x5, x4, x3
add x6, x5, x4
add x7, x6, x5
add x8, x7, x6
add x9, x8, x7
```

The program terminates using:

```assembly
ecall
```

---

## Assembly Program

```assembly
addi x1, x0, 0
addi x2, x0, 1

add  x3, x1, x2
add  x4, x3, x2
add  x5, x4, x3
add  x6, x5, x4
add  x7, x6, x5
add  x8, x7, x6
add  x9, x8, x7

ecall
```

---

## Machine Code Loaded into IMEM

```text
00000093
00100113
002081B3
00218233
003202B3
00428333
005303B3
00638433
007404B3
00000073
```

---

## Expected Register Values

| Register | Value |
|----------|--------|
| x1 | 0 |
| x2 | 1 |
| x3 | 1 |
| x4 | 2 |
| x5 | 3 |
| x6 | 5 |
| x7 | 8 |
| x8 | 13 |
| x9 | 21 |

---

## Simulation Output

```text
x1 = 0
x2 = 1
x3 = 1
x4 = 2
x5 = 3
x6 = 5
x7 = 8
x8 = 13
x9 = 21
```

---

## Verification

The simulation results exactly match the expected Fibonacci sequence:

```text
0, 1, 1, 2, 3, 5, 8, 13, 21
```

This verifies that:

- Instructions are correctly fetched from instruction memory.
- The control unit correctly decodes RISC-V instructions.
- The ALU performs arithmetic operations correctly.
- Register writeback functions correctly.
- The 5-stage pipeline executes a complete RISC-V program successfully.
- Program execution terminates correctly using ECALL.

---

## Conclusion

A complete Fibonacci program was successfully executed from instruction memory on the RV32I 5-stage pipelined processor. The generated register values matched the expected Fibonacci sequence, demonstrating correct instruction fetch, decode, execute, memory access, and writeback operations across the pipeline stages.

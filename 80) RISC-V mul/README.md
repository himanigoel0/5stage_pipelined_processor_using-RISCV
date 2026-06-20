# Integer Multiplication using RISC-V MUL Instruction

## Objective

To extend the existing 5-stage pipelined RV32I processor with support for the RISC-V MUL instruction and verify correct execution through simulation and waveform analysis.

---

## Background

The base RV32I ISA does not include multiplication instructions.

Integer multiplication is provided through the RISC-V M Extension.

The MUL instruction performs signed integer multiplication and writes the lower 32 bits of the product to the destination register.

Operation:

```text
rd = rs1 × rs2
```

Example:

```assembly
mul x3, x1, x2
```

If:

```text
x1 = 20
x2 = 5
```

Then:

```text
x3 = 100
```

---

## Processor Modifications

### Control Unit

The MUL instruction uses:

```text
opcode = 0110011
funct7 = 0000001
funct3 = 000
```

Support was added inside the R-Type decode logic.

```verilog
{7'b0000001,3'b000}: alu_control = 4'b1011; // MUL
```

---

### ALU

A new ALU operation was added.

```verilog
4'b1011: begin
    result = num1 * num2;
end
```

The ALU performs signed integer multiplication and stores the lower 32 bits of the result.

---

## Verification Program

### Register Initialization

```text
x1 = 20
x2 = 5
x4 = 10
```

---

### Machine Code

```text
022081B3
024182B3
00128333
00000013
```

---

### Assembly Equivalent

```assembly
mul x3, x1, x2
mul x5, x3, x4
add x6, x5, x1
nop
```

---

## Expected Execution

### Instruction 1

```assembly
mul x3, x1, x2
```

Calculation:

```text
20 × 5 = 100
```

Result:

```text
x3 = 100
```

---

### Instruction 2

```assembly
mul x5, x3, x4
```

Calculation:

```text
100 × 10 = 1000
```

Result:

```text
x5 = 1000
```

---

### Instruction 3

```assembly
add x6, x5, x1
```

Calculation:

```text
1000 + 20 = 1020
```

Result:

```text
x6 = 1020
```

---

## Simulation Results

Observed register values:

```text
x1 = 20
x2 = 5
x3 = 100
x4 = 10
x5 = 1000
x6 = 1020
x7 = 0
```

---

## Waveform Analysis

### First Multiplication

```assembly
mul x3, x1, x2
```

Waveform:

```text
num1 = 20
num2 = 5
product = 100
```

Verified:

```text
20 × 5 = 100
```

PASS

---

### Second Multiplication

```assembly
mul x5, x3, x4
```

Waveform:

```text
num1 = 100
num2 = 10
product = 1000
```

Verified:

```text
100 × 10 = 1000
```

PASS

---

### Addition

```assembly
add x6, x5, x1
```

Waveform:

```text
num1 = 1000
num2 = 20
product = 1020
```

Verified:

```text
1000 + 20 = 1020
```

PASS

---

## Forwarding Verification

The second MUL instruction immediately depends on the result of the first MUL instruction.

```assembly
mul x3, x1, x2
mul x5, x3, x4
```

The value of x3 is required before it has been written back to the register file.

The correct value:

```text
x5 = 1000
```

confirms that the forwarding unit successfully forwarded the result of the first MUL instruction.

---

Similarly:

```assembly
mul x5, x3, x4
add x6, x5, x1
```

The ADD instruction immediately depends on x5.

The correct value:

```text
x6 = 1020
```

confirms successful forwarding of the MUL result to the ADD instruction.

---

## Verification Summary

| Instruction | Expected Result | Observed Result | Status |
|------------|----------------|----------------|---------|
| MUL x3,x1,x2 | 100 | 100 | PASS |
| MUL x5,x3,x4 | 1000 | 1000 | PASS |
| ADD x6,x5,x1 | 1020 | 1020 | PASS |

---

## Conclusion

Support for the RISC-V MUL instruction was successfully integrated into the 5-stage pipelined RV32I processor.

Simulation and waveform analysis verified:

- Correct MUL instruction decoding
- Correct ALU multiplication operation
- Correct register writeback
- Successful forwarding of multiplication results
- Correct execution of dependent instructions
- Proper integration with the existing pipeline

Therefore, integer multiplication using the RISC-V MUL instruction has been successfully implemented and verified.

# LUI and AUIPC Instruction Support in a 5-Stage Pipelined RV32I Processor

## Objective

To add support for the U-Type instructions:

- LUI (Load Upper Immediate)
- AUIPC (Add Upper Immediate to PC)

and verify their functionality using simulation and waveform analysis.

---

## Theory

### LUI

LUI loads a 20-bit immediate into the upper 20 bits of the destination register.

Operation:

```text
rd = imm << 12
```

Example:

```assembly
lui x1, 0x12345
```

Result:

```text
x1 = 0x12345000
```

---

### AUIPC

AUIPC adds the upper immediate value to the current PC.

Operation:

```text
rd = PC + (imm << 12)
```

Example:

```assembly
auipc x2, 0x10
```

If:

```text
PC = 4
```

Then:

```text
x2 = 4 + (0x10 << 12)
   = 4 + 65536
   = 65540
```

---

## Modifications Performed

### Immediate Generator

Added support for U-Type immediates:

```verilog
7'b0110111, 7'b0010111:
    imm = {instruction[31:12],12'b0};
```

---

### Control Unit

Added new opcodes:

#### LUI

```verilog
7'b0110111: begin
    regwrite = 1;
    alu_control = 4'b1001;
end
```

#### AUIPC

```verilog
7'b0010111: begin
    regwrite = 1;
    alu_control = 4'b1010;
end
```

---

### ALU

Added new operations:

#### LUI

```verilog
4'b1001:
    result = num2;
```

#### AUIPC

```verilog
4'b1010:
    result = num1 + num2;
```

---

### Datapath Changes

For AUIPC, the ALU must use PC instead of rs1.

```verilog
assign alu_src1 =
       (idex_opcode == 7'b0010111) ? idex_pc :
       (forwardA == 2'b10) ? exmem_alu_result :
       (forwardA == 2'b01) ? wb_data :
                             idex_rd1;
```

U-Type instructions were also added to the immediate-selection logic:

```verilog
assign uses_imm =
       (idex_opcode == 7'b0010011) ||
       (idex_opcode == 7'b0000011) ||
       (idex_opcode == 7'b0100011) ||
       (idex_opcode == 7'b0110111) ||
       (idex_opcode == 7'b0010111);
```

---

## Verification Program

### Machine Code

```text
123450B7
00010117
002081B3
00000013
```

### Assembly Equivalent

```assembly
lui   x1, 0x12345
auipc x2, 0x10
add   x3, x1, x2
nop
```

---

## Expected Results

### Instruction 1

```assembly
lui x1, 0x12345
```

```text
x1 = 0x12345000
x1 = 305418240
```

---

### Instruction 2

```assembly
auipc x2, 0x10
```

```text
x2 = 0x10004
x2 = 65540
```

---

### Instruction 3

```assembly
add x3, x1, x2
```

```text
x3 = 305418240 + 65540
x3 = 305483780
```

```text
x3 = 0x12355004
```

---

## Simulation Results

Observed register values:

![simulation](screenshots/TCL_console_output)

---

## Verification

| Register | Expected | Observed | Status |
|-----------|-----------|-----------|---------|
| x1 | 305418240 | 305418240 | PASS |
| x2 | 65540 | 65540 | PASS |
| x3 | 305483780 | 305483780 | PASS |

---

## Forwarding Verification

The AUIPC instruction is immediately followed by:

```assembly
add x3, x1, x2
```

At this point, the AUIPC result has not yet been written back to the register file.

The correct value obtained for x3 confirms that the forwarding unit successfully forwarded the AUIPC result to the Execute stage.

Therefore, forwarding functionality remains correct after integrating U-Type instructions.

---

## Debugging Observation

During initial testing, the machine code:

```text
001081B3
```

was mistakenly used.

This instruction decodes to:

```assembly
add x3, x1, x1
```

instead of:

```assembly
add x3, x1, x2
```

As a result:

```text
x3 = 610836480
```

was observed.

Waveform analysis showed that both ALU operands contained the value of x1, confirming that the processor datapath was functioning correctly and that the issue originated from incorrect instruction encoding.

The instruction was corrected to:

```text
002081B3
```

after which the expected result was obtained.

---

## Conclusion

Support for LUI and AUIPC instructions was successfully integrated into the 5-stage pipelined RV32I processor.

Simulation results verified:

- Correct U-Type immediate generation
- Correct execution of LUI
- Correct execution of AUIPC
- Correct ALU operation
- Correct register writeback
- Successful forwarding of AUIPC results
- Proper integration with the existing pipeline

Hence, LUI and AUIPC support has been successfully implemented and verified.

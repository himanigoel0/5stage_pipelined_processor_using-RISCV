# Implement Memory-Mapped I/O (MMIO) Control

## Objective

To implement Memory-Mapped I/O (MMIO) in the RV32I 5-stage pipelined processor and demonstrate both GPIO input and GPIO output operations using dedicated memory-mapped addresses.

---

## Introduction

Memory-Mapped I/O (MMIO) is a technique in which peripherals are assigned specific memory addresses. The processor interacts with these peripherals using standard load (`LW`) and store (`SW`) instructions instead of dedicated I/O instructions.

In this experiment:

- Address `0xF0` is assigned to a GPIO Output Register.
- Address `0xF1` is assigned to a GPIO Input Register.

This allows the processor to read external input values and control output devices such as LEDs through normal memory operations.

---

## Memory Map

| Address | Function |
|----------|----------|
| 0xF0 (240) | GPIO Output Register |
| 0xF1 (241) | GPIO Input Register |

---

## MMIO Implementation

### GPIO Output Write Logic

```verilog
always @(posedge clk) begin

    if(memwrite) begin

        if(addr == 32'd240)
            gpio_reg <= write_data[7:0];

        else
            mem[addr] <= write_data;

    end

end
```

When the processor performs:

```assembly
sw xN,240(x0)
```

the value is written to the GPIO register instead of normal data memory.

---

### GPIO Input Read Logic

```verilog
always @(*) begin

    if(memread) begin

        if(addr == 32'd241)
            read_data = {24'b0,gpio_in};

        else
            read_data = mem[addr];

    end

    else
        read_data = 32'b0;

end
```

When the processor performs:

```assembly
lw xN,241(x0)
```

the GPIO input value is returned instead of RAM data.

---

## Test Program

### Assembly Code

```assembly
# Read GPIO Input
lw   x5,241(x0)

# Copy input
addi x6,x5,0

# Increment input
addi x7,x5,1

# Write original value to GPIO Output
sw   x5,240(x0)

# Read GPIO Input again
lw   x5,241(x0)

# Increment input
addi x5,x5,1

# Write incremented value to GPIO Output
sw   x5,240(x0)

ecall
```

---

## Machine Code

```text
0F102283
00028313
00128393
0E502823
0F102283
00128293
0E502823
00000073
```

---

## Test Conditions

The GPIO input was initialized in the testbench as:

```verilog
gpio_in = 8'b10110011;
```

which corresponds to:

```text
179 decimal
```

---

## Expected Execution

### First MMIO Transaction

The processor reads:

```text
gpio_in = 179
```

using:

```assembly
lw x5,241(x0)
```

Result:

```text
x5 = 179
x6 = 179
x7 = 180
```

The original value is then written to the GPIO output register:

```assembly
sw x5,240(x0)
```

Result:

```text
GPIO Output = 179
LED Output  = 179
```

---

### Second MMIO Transaction

The processor again reads:

```text
gpio_in = 179
```

and performs:

```assembly
addi x5,x5,1
```

Result:

```text
x5 = 180
```

The incremented value is written to the GPIO output register:

```assembly
sw x5,240(x0)
```

Result:

```text
GPIO Output = 180
LED Output  = 180
```

---

## Waveform Analysis

Observed waveform:

```text
gpio_in  : 179
gpio_out : 0 → 179 → 180
led      : 0 → 179 → 180
```

### Explanation

Initially, all outputs remain zero because the instructions are still propagating through the 5-stage pipeline.

```text
IF → ID → EX → MEM → WB
```

After the first store instruction reaches the Memory stage, the value read from the GPIO input register is written to the GPIO output register.

```text
GPIO Output : 0 → 179
LED Output  : 0 → 179
```

The second MMIO transaction reads the input again, increments the value by one, and writes it back.

```text
GPIO Output : 179 → 180
LED Output  : 179 → 180
```

This confirms successful MMIO input, processor computation, and MMIO output operation.

---

## Verification

The following functionalities were successfully verified:

- MMIO GPIO Input Read
- MMIO GPIO Output Write
- Load Instruction (LW)
- Store Instruction (SW)
- Arithmetic Operation (ADDI)
- Data Transfer through MMIO
- Processor-to-Peripheral Communication
- Peripheral-to-Processor Communication

Observed Results:

```text
gpio_in  = 179
gpio_out = 180
led      = 180
```

which matches the expected behavior.

---

## Applications

Memory-Mapped I/O is widely used in:

- GPIO Interfaces
- UART Communication
- Timers and Counters
- Interrupt Controllers
- Sensors
- Embedded Systems
- FPGA-Based SoCs
- Microcontrollers

---

## Conclusion

Memory-Mapped I/O was successfully implemented in the RV32I 5-stage pipelined processor. Dedicated memory locations were assigned for GPIO input and GPIO output operations. The processor successfully read external input data through address `0xF1`, performed arithmetic processing, and wrote the processed result to the GPIO output register at address `0xF0`. Waveform results verified correct MMIO input handling, processor computation, and MMIO output control, demonstrating a complete processor-peripheral communication mechanism.

# Instruction Memory Initialization from File

## Objective

The objective of this assignment is to initialize the instruction memory of the RISC-V processor from an external file and verify its operation through simulation.

---

## Theory

In a processor, instructions are stored in memory and fetched during execution. Instead of hardcoding instructions inside the Verilog module, an external file can be used to store machine code instructions.

Verilog provides the system task `$readmemh()` to load hexadecimal data from a text file into a memory array during simulation.

This approach allows different programs to be tested without modifying the hardware description.

---

## Implementation

The instruction memory consists of 256 locations, each 32 bits wide.

During initialization:

1. All memory locations are filled with NOP instructions (`32'h00000013`).
2. The contents of `program5.txt` are loaded into memory using `$readmemh()`.
3. Instructions are fetched using the Program Counter (PC) value.

### Instruction Memory Code

```verilog
initial begin
    for(i = 0; i < 256; i = i+1)
        imem[i] = 32'h00000013;

    $readmemh("program5.txt", imem);
end

always @(*) begin
    instruction = imem[address >> 2];
end

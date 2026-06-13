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
`timescale 1ns / 1ps

module imem_32(
    input [31:0] address,
    output reg [31:0] instruction
);

    reg [31:0] imem [0:255];
    integer i;

    initial begin
        for(i = 0; i < 256; i = i + 1)
            imem[i] = 32'h00000013;

        $readmemh("program5.txt", imem);
    end

    always @(*) begin
        instruction = imem[address >> 2];
    end

endmodule
```

---

## Testbench

A testbench was created to verify instruction fetching from different memory locations.

### Testbench Code

```verilog
`timescale 1ns / 1ps

module imem_tb();

    reg [31:0] address;
    wire [31:0] instruction;

    imem_32 uut(
        .address(address),
        .instruction(instruction)
    );

    initial begin
        address = 0;   #10;
        address = 4;   #10;
        address = 8;   #10;
        address = 12;  #10;
        address = 16;  #10;
        address = 20;  #10;
        address = 200; #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t Address=%0d Instruction=%h",
                 $time, address, instruction);
    end

endmodule
```

---

## Program File

Example contents of `program5.txt`:

```text
00500093
00A00113
002081B3
00000013
00000013
```

---

## Simulation Results

The simulation waveform showed that:

- Instructions were successfully loaded from `program5.txt`.
- Correct instructions were fetched for addresses 0, 4 and 8.
- Uninitialized memory locations returned the NOP instruction (`0x00000013`).
- Address translation using `address >> 2` correctly mapped byte addresses to word locations.

---

## Advantages

- Easy program modification without changing Verilog code.
- Faster testing of multiple instruction sequences.
- Better scalability for larger programs.
- Similar to real processor memory loading mechanisms.

---

## Conclusion

Instruction memory initialization from an external file was successfully implemented using `$readmemh()`. Simulation verified correct loading and fetching of instructions from memory, demonstrating a flexible and realistic instruction loading mechanism for the RISC-V processor.

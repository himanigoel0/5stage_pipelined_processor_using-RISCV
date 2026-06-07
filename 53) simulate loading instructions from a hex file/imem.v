`timescale 1ns / 1ps

// We will be making 16 bit wide imem because we have 8 registers in our regfile, 3 registers needed to access rs, rt
// So, rs = 3bit, rt = 3bit, rd = 3bit, operation = 4bit, opcode = 2bit. total bit = 16 enough for now
// We have 8 bit pc, so 256 instructions are possible.
// basically, opcode stores the shift type here.
// format = operation | rs | rt | rd | opcode
// assuming the MSB to be 0 initially since we need only 15 bits for now.

module imem(
    input [7:0] address,
    output reg [15:0] instruction
);
    // we get instr address from pc and we give out instr as o/p

    reg [15:0] imem [0:255];
    integer i;
    
    initial begin
//        imem[0] = 16'h0264;     // and operation
//        imem[1] = 16'h0A64;     // or
//        imem[2] = 16'h1264;     // add
//        imem[3] = 16'h1A64;     // sub
//        imem[4] = 16'h2264;     // xor
//        imem[5] = 16'h2A64;     // slt
//        imem[6] = 16'h3264;     // nor
//        imem[7] = 16'h3A64;     // shift left logical
//        imem[8] = 16'h3A65;     // shift left arithmetic
//        imem[9] = 16'h3A66;     // shift right logical
//        imem[10] = 16'h3A67;    // shift right arithmetic
//        imem[11] = 16'h4264;    // multiplication

        $readmemh("program.txt", imem);
        for (i = 12; i < 256; i = i+1) imem[i] = 0;
    end
    
    always @(*) begin
        instruction = imem[address];
    end
    
    

endmodule

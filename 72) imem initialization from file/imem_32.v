`timescale 1ns / 1ps

module imem_32(
    input [31:0] address,
    output reg [31:0] instruction
);
    reg [31:0] imem [0:255];
    integer i;
    
    initial begin
        for(i = 0; i < 256; i = i+1) imem[i] = 32'h00000013;
        $readmemh("program5.txt", imem);
        // because this is basically addi x0, x0, 0; this is basically NOP operation.
    end
    
    always @(*) begin
        instruction = imem[address >> 2];
        // because pc increments in multiples of 4: 0, 4, 8, 12...
        // so, we shift it right by 2 units (divide by 4) so that we dont miss any instruction.
        // bascially we will now be accessing instr at pc = 0, 4, 8...
        // so when we make a datapath, we connect address port to pc
    end

endmodule
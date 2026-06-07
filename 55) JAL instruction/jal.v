`timescale 1ns / 1ps

// J-type instruction format (JAL)
// opcode is 110 1111

//31                         12 11    7 6      0
//+----------------------------+-------+--------+
//|          immediate         |  rd   | opcode |
//+----------------------------+-------+--------+

// assuming instruction to be 4 byte wide.
// JAL performs a jump and link operation.
// The address of the next sequential instruction (PC+4) is stored in rd as the return address, 
// allowing the program to return after a function call.

module jal(
    input [31:0] instruction,
    input [31:0] pc,
    output reg [31:0] pc_out,
    output reg [31:0] link_addr,
    output signed [31:0] offset
);

    wire [6:0] opcode     = instruction[6:0];
    wire [4:0] rd         = instruction[11:7];
    wire [19:0] immediate = instruction[31:12];
    
    assign offset   = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], {1'b0}};
    
    always @(*) begin
        if (opcode == 7'b1101111) begin
            pc_out = pc + offset;
        end
        else pc_out = pc + 4;
        link_addr = pc + 4;
    end

endmodule

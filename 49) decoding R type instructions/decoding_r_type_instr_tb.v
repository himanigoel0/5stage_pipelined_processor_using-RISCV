`timescale 1ns / 1ps

module decoding_r_type_instr_tb();

    reg [15:0] instruction;

    wire [3:0] operation;
    wire [2:0] rs;
    wire [2:0] rt;
    wire [2:0] rd;
    wire [1:0] opselect;

    decoding_r_type_instr uut(
        .instruction(instruction),
        .operation(operation),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .opselect(opselect)
    );

    initial begin
        #00; instruction = 16'h0264;   // AND
        #10; instruction = 16'h0A64;   // OR
        #10; instruction = 16'h1264;   // ADD
        #10; instruction = 16'h1A64;   // SUB
        #10; instruction = 16'h2264;   // XOR
        #10; instruction = 16'h2A64;   // SLT
        #10; instruction = 16'h3264;   // NOR
        #10; instruction = 16'h3A64;   // SHIFT LEFT LOGICAL
        #10; instruction = 16'h3A65;   // SHIFT LEFT ARITHMETIC
        #10; instruction = 16'h3A66;   // SHIFT RIGHT LOGICAL
        #10; instruction = 16'h3A67;   // SHIFT RIGHT ARITHMETIC
        #10; $finish;
    end

endmodule

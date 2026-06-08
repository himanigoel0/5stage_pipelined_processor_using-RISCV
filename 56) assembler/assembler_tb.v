`timescale 1ns / 1ps

`timescale 1ns / 1ps

module assembler_tb();

    reg [3:0] instr;
    reg [4:0] rd;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [11:0] imm;

    wire [31:0] machine_code;

    assembler uut(
        .instr(instr),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm(imm),
        .machine_code(machine_code)
    );

    initial begin

        // =========================
        // R-TYPE INSTRUCTIONS
        // =========================

        // ADD x5,x2,x3
        instr = 4'd0;
        rd = 5'd5;
        rs1 = 5'd2;
        rs2 = 5'd3;
        imm = 0;
        #10;

        // SUB x5,x2,x3
        instr = 4'd1;
        #10;

        // AND x5,x2,x3
        instr = 4'd2;
        #10;

        // OR x5,x2,x3
        instr = 4'd3;
        #10;

        // XOR x5,x2,x3
        instr = 4'd4;
        #10;

        // SLT x5,x2,x3
        instr = 4'd5;
        #10;

        // =========================
        // I-TYPE INSTRUCTIONS
        // =========================

        // ADDI x5,x2,10
        instr = 4'd6;
        imm = 12'd10;
        #10;

        // ADDI x5,x2,-5
        instr = 4'd6;
        imm = 12'hFFB;
        #10;

        // ORI x5,x2,15
        instr = 4'd7;
        imm = 12'd15;
        #10;

        // ORI x5,x2,-1
        instr = 4'd7;
        imm = 12'hFFF;
        #10;

        // SLTI x5,x2,20
        instr = 4'd8;
        imm = 12'd20;
        #10;

        // SLTI x5,x2,-10
        instr = 4'd8;
        imm = 12'hFF6;
        #10;

        // =========================
        // JAL
        // =========================

        // JAL x1,24
        instr = 4'd9;
        rd = 5'd1;
        imm = 12'd24;
        #10;

        // JAL x1,-20
        instr = 4'd9;
        imm = 12'hFEC;
        
        #10; $finish;

    end

endmodule

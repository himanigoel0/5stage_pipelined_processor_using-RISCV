`timescale 1ns / 1ps

module immediate_gen_tb();

    reg [31:0] instruction;
    wire signed [31:0] imm;
    
    immediate_gen uut (instruction, imm);
    
    initial begin

        // ==================================
        // I-Type : ADDI x1,x0,10
        // imm = 10
        // ==================================
        instruction = 32'h00A00093;
        #10;
        $display("ADDI  Imm = %0d", imm);

        // ==================================
        // I-Type : ADDI x1,x0,-5
        // imm = -5
        // ==================================
        instruction = 32'hFFB00093;
        #10;
        $display("ADDI(-5) Imm = %0d", imm);

        // ==================================
        // S-Type : SW x3,8(x0)
        // imm = 8
        // ==================================
        instruction = 32'h00302423;
        #10;
        $display("SW Imm = %0d", imm);

        // ==================================
        // B-Type : BEQ x1,x1,+8
        // imm ≈ 8
        // ==================================
        instruction = 32'h00108463;
        #10;
        $display("BEQ Imm = %0d", imm);

        // ==================================
        // J-Type : JAL x1,+8
        // imm ≈ 8
        // ==================================
        instruction = 32'h008000EF;
        #10;
        $display("JAL Imm = %0d", imm);

        $finish;

    end


endmodule

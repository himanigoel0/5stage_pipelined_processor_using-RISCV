`timescale 1ns / 1ps

module addi_ori_slti_tb();

    reg [31:0] instruction;
    reg signed [31:0] rs1_value;
    wire signed [31:0] result;

    addi_ori_slti uut(
        .instruction(instruction),
        .rs1_value(rs1_value),
        .result(result)
    );

    initial begin

        // ADDI TESTS (opcode=0010011, funct3=000)

        // addi x1,x2,10  => 20+10 = 30
        instruction = {12'd10, 5'd2, 3'b000, 5'd1, 7'b0010011};
        rs1_value = 20;
        #10;

        // addi x1,x2,-5 => 20+(-5)=15
        instruction = {12'hFFB, 5'd2, 3'b000, 5'd1, 7'b0010011};
        rs1_value = 20;
        #10;

        // addi x1,x2,-10 => -20+(-10)=-30
        instruction = {12'hFF6, 5'd2, 3'b000, 5'd1, 7'b0010011};
        rs1_value = -20;
        #10;

        // addi x1,x2,0 => 15
        instruction = {12'd0, 5'd2, 3'b000, 5'd1, 7'b0010011};
        rs1_value = 15;
        #10;


        // ORI TESTS (opcode=0010011, funct3=110)

        // 00100101 OR 00001111
        instruction = {12'h00F, 5'd2, 3'b110, 5'd1, 7'b0010011};
        rs1_value = 32'h25;
        #10;

        // 0 OR 15
        instruction = {12'h00F, 5'd2, 3'b110, 5'd1, 7'b0010011};
        rs1_value = 0;
        #10;

        // all ones immediate (-1)
        instruction = {12'hFFF, 5'd2, 3'b110, 5'd1, 7'b0010011};
        rs1_value = 32'h12345678;
        #10;


        // SLTI TESTS (opcode=0010011, funct3=010)

        // 10 < 20 => 1
        instruction = {12'd20, 5'd2, 3'b010, 5'd1, 7'b0010011};
        rs1_value = 10;
        #10;

        // 20 < 10 => 0
        instruction = {12'd10, 5'd2, 3'b010, 5'd1, 7'b0010011};
        rs1_value = 20;
        #10;

        // -20 < 10 => 1
        instruction = {12'd10, 5'd2, 3'b010, 5'd1, 7'b0010011};
        rs1_value = -20;
        #10;

        // 10 < -20 => 0
        instruction = {12'hFEC, 5'd2, 3'b010, 5'd1, 7'b0010011};
        rs1_value = 10;
        #10;

        // -20 < -10 => 1
        instruction = {12'hFF6, 5'd2, 3'b010, 5'd1, 7'b0010011};
        rs1_value = -20;
        #10;

        // -10 < -20 => 0
        instruction = {12'hFEC, 5'd2, 3'b010, 5'd1, 7'b0010011};
        rs1_value = -10;
        
        #10; $finish;

    end

endmodule
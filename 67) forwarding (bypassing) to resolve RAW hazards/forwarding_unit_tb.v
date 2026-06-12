`timescale 1ns / 1ps

module forwarding_unit_tb();

    reg [4:0] idex_rs1;
    reg [4:0] idex_rs2;

    reg [4:0] exmem_rd;
    reg exmem_regwrite;

    wire forwardA;
    wire forwardB;

    forwarding_unit uut(

        .idex_rs1(idex_rs1),
        .idex_rs2(idex_rs2),

        .exmem_rd(exmem_rd),
        .exmem_regwrite(exmem_regwrite),

        .forwardA(forwardA),
        .forwardB(forwardB)

    );

    initial begin

        // =====================================
        // Case 1 : No forwarding required
        // =====================================
        idex_rs1 = 5'd2;
        idex_rs2 = 5'd5;

        exmem_rd = 5'd3;
        exmem_regwrite = 1;

        #10;

        // Expected:
        // forwardA = 0
        // forwardB = 0


        // =====================================
        // Case 2 : Forward to ALU input A
        // =====================================
        idex_rs1 = 5'd3;
        idex_rs2 = 5'd5;

        exmem_rd = 5'd3;
        exmem_regwrite = 1;

        #10;

        // Expected:
        // forwardA = 1
        // forwardB = 0


        // =====================================
        // Case 3 : Forward to ALU input B
        // =====================================
        idex_rs1 = 5'd2;
        idex_rs2 = 5'd7;

        exmem_rd = 5'd7;
        exmem_regwrite = 1;

        #10;

        // Expected:
        // forwardA = 0
        // forwardB = 1


        // =====================================
        // Case 4 : Forward both inputs
        // =====================================
        idex_rs1 = 5'd8;
        idex_rs2 = 5'd8;

        exmem_rd = 5'd8;
        exmem_regwrite = 1;

        #10;

        // Expected:
        // forwardA = 1
        // forwardB = 1


        // =====================================
        // Case 5 : Regwrite disabled
        // =====================================
        idex_rs1 = 5'd3;
        idex_rs2 = 5'd3;

        exmem_rd = 5'd3;
        exmem_regwrite = 0;

        #10;

        // Expected:
        // forwardA = 0
        // forwardB = 0


        // =====================================
        // Case 6 : x0 register
        // =====================================
        idex_rs1 = 5'd0;
        idex_rs2 = 5'd0;

        exmem_rd = 5'd0;
        exmem_regwrite = 1;

        #10;

        // Expected:
        // forwardA = 0
        // forwardB = 0


        $finish;

    end

endmodule
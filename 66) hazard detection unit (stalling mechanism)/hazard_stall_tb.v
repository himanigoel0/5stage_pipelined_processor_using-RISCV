`timescale 1ns / 1ps

module hazard_stall_tb();

    reg [4:0] id_rs1;
    reg [4:0] id_rs2;

    reg [4:0] ex_rd;
    reg ex_regwrite;

    wire stall;

    hazard_stall uut(
        .id_rs1(id_rs1),
        .id_rs2(id_rs2),
        .ex_rd(ex_rd),
        .ex_regwrite(ex_regwrite),
        .stall(stall)
    );

    initial begin

        // ==========================
        // Case 1: No hazard
        // ==========================
        id_rs1 = 5'd2;
        id_rs2 = 5'd5;
        ex_rd = 5'd3;
        ex_regwrite = 1;

        #10;

        // Expected:
        // stall = 0

        // ==========================
        // Case 2: Hazard via rs1
        // ==========================
        id_rs1 = 5'd3;
        id_rs2 = 5'd5;
        ex_rd = 5'd3;
        ex_regwrite = 1;

        #10;

        // Expected:
        // stall = 1

        // ==========================
        // Case 3: Hazard via rs2
        // ==========================
        id_rs1 = 5'd1;
        id_rs2 = 5'd7;
        ex_rd = 5'd7;
        ex_regwrite = 1;

        #10;

        // Expected:
        // stall = 1

        // ==========================
        // Case 4: regwrite = 0
        // ==========================
        id_rs1 = 5'd3;
        id_rs2 = 5'd4;
        ex_rd = 5'd3;
        ex_regwrite = 0;

        #10;

        // Expected:
        // stall = 0

        // ==========================
        // Case 5: ex_rd = x0
        // ==========================
        id_rs1 = 5'd0;
        id_rs2 = 5'd2;
        ex_rd = 5'd0;
        ex_regwrite = 1;

        #10;

        // Expected:
        // stall = 0

        $finish;

    end

endmodule
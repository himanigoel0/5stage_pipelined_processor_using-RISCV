`timescale 1ns / 1ps

module branch_predictor_static_tb();

    reg [31:0] imm;
    reg branch;

    wire predict_taken;

    branch_predictor_static dut(

        .imm(imm),
        .branch(branch),

        .predict_taken(predict_taken)

    );

    initial begin

        // not a branch
        branch = 0;
        imm    = 0;
        #10;

        // forward branch
        branch = 1;
        imm    = 32'd16;
        #10;

        // backward branch
        imm = -32'd8;
        #10;

        // backward branch
        imm = -32'd20;
        #10;

        // forward branch
        imm = 32'd40;
        #10;

        $finish;

    end

endmodule
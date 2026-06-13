`timescale 1ns / 1ps

// assuming BTFNT: backward taken forward not taken

module branch_predictor_static(

    input [31:0] imm,
    input branch,

    output reg predict_taken

);

always @(*) begin

    if(branch) begin

        // negative offset = backward branch
        if(imm[31] == 1'b1)
            predict_taken = 1'b1;

        else
            predict_taken = 1'b0;

    end

    else
        predict_taken = 1'b0;

end

endmodule
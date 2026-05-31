`timescale 1ns / 1ps

module encoder_4x2(
    input [3:0] A,
    output reg [1:0] Y
);

    // assuming the highest priority to MSB.
    // we need to use casex instead of case here, because we also have dont care x.
    always @(*) begin
        casex (A)
            4'b0001: Y = 2'b00;
            4'b001x: Y = 2'b01;
            4'b01xx: Y = 2'b10;
            4'b1xxx: Y = 2'b11;
            default: Y = 2'b00;
        endcase
    end
    
    // Another method to do this:
//    always @(*) begin
//        if (A[3])
//            Y = 2'b11;
//        else if (A[2])
//            Y = 2'b10;
//        else if (A[1])
//            Y = 2'b01;
//        else if (A[0])
//            Y = 2'b00;
//        else
//            Y = 2'b00;
//    end

// We are checking the highest priority bit first, then checking others.

endmodule

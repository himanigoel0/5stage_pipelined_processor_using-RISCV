`timescale 1ns / 1ps

module mux_4x1_behavioral(
    input A, B, C, D, 
    input [1:0] sel,
    output reg Y
);
// Since we need to use behavioral code, we will use always block and so output will be reg type.

    always @(*) begin
        case (sel)
            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            2'b11: Y = D;
        endcase
    end
    
endmodule

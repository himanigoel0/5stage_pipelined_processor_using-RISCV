`timescale 1ns / 1ps

/* WORKING:
   Suppose we are multiplying 1011*1010. The, the multiplier is B = 1010 and multiplicand is A = 1011.
   If B[0] = 0, then dont do anything. if B[0] = 1, then add A to Product initialised to 0.
   Then shift A left by 1 bit, if B[1] = 0, dont do anything, else update P by A+P.
   Continue this...
*/

module signed_multiplication(
    input [7:0] A, B,       // A is the multiplicand and B is the mutiplier.
    output reg [15:0] product
);
    reg sign;
    reg [15:0] unsigned_product;
    reg [7:0] absA, absB;

    // combinational, 1 cycle product.
    // now the method is that we use the absolute values to get an unsigned product.
    // then, if final sign bit is 1, then final product will be 2s complement of unsigned procust, 
    // else it remains the same.
    always @(*) begin
    
        sign = A[7] ^ B[7];
    
        absA = (A[7] ? (~A + 1) : A);
        absB = (B[7] ? (~B + 1) : B);
   
        unsigned_product = (absB[0] ? ({8'b0,absA} << 0) : 0)
                          +(absB[1] ? ({8'b0,absA} << 1) : 0)
                          +(absB[2] ? ({8'b0,absA} << 2) : 0)
                          +(absB[3] ? ({8'b0,absA} << 3) : 0)
                          +(absB[4] ? ({8'b0,absA} << 4) : 0)
                          +(absB[5] ? ({8'b0,absA} << 5) : 0)
                          +(absB[6] ? ({8'b0,absA} << 6) : 0)
                          +(absB[7] ? ({8'b0,absA} << 7) : 0);
       
        product = sign ? (~unsigned_product + 1): unsigned_product;
        // The true mathematical product can fit within 16 bits
        // 255*255 (8 bits each) require 16 bits maximum
                          
    end

endmodule

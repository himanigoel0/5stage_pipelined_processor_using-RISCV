`timescale 1ns / 1ps

module binary_to_gray_4bit(
    input [3:0] B,
    output [3:0] G
);

    // to convert binary to gray, preserve the MSB. Then, 2nd MSB of G = (MSB of B) xor (2nd MSB of B) and so on..
    assign G[3] = B[3];
    assign G[2] = B[3] ^ B[2];
    assign G[1] = B[2] ^ B[1];
    assign G[0] = B[1] ^ B[0];
    
endmodule

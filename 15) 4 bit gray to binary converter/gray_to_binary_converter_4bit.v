`timescale 1ns / 1ps

module gray_to_binary_converter_4bit(
    input [3:0] G,
    output [3:0] B
);

    // to convert gray to binary:
    // preserve MSB, then 2nd MSB of binary = 2nd MSB of gray xor MSB of B
    
    assign B[3] = G[3];
    assign B[2] = B[3] ^ G[2];
    assign B[1] = B[2] ^ G[1];
    assign B[0] = B[1] ^ G[0];
    
endmodule

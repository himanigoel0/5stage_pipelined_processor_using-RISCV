`timescale 1ns / 1ps

module parity_generator_and_checker(
    input [3:0] D,
    input P_in,
    output P, E
);

    // assuming 4 bit parity generator (P) and even parity detector error bit (E)
    // xor outputs 1 when there are odd number of 1s in the Data.
    // so, we take parity bit generated as xor of all the bits.
    // if the number has odd number of 1s, then P = 1, and the entire number with P becomes even now.
    // if error bit E = 0, then the number of 1s = even, else odd.
    // we check the error of input parity bit.
    
    xor (P, D[3], D[2], D[1], D[0]);
    xor (E, P_in, D[3], D[2], D[1], D[0]);
    

endmodule

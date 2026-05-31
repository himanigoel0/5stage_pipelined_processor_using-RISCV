`timescale 1ns / 1ps

module half_adder_1_bit(
    input A, B,
    output sum, cout
);

    xor (sum, A, B);
    and (cout, A, B);
    
endmodule

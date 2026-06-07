`timescale 1ns / 1ps

// R type instruction format: unused | operation | rs | rt | rd | opselect
//                              1          4        3    3    3       2    => total 16 bits

module decoding_r_type_instr(
    input [15:0] instruction,
    
    output [3:0] operation,
    output [2:0] rs, rt, rd,
    output [1:0] opselect
);

    assign operation = instruction[14:11];
    assign rs        = instruction[10:8];
    assign rt        = instruction[7:5];
    assign rd        = instruction[4:2];
    assign opselect  = instruction[1:0];
    
    // we are doing arithmetic on register number 2 & 3, writing back to register number 1.
    
endmodule

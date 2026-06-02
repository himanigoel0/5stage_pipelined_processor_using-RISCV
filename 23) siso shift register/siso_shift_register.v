`timescale 1ns / 1ps

module siso_shift_register(
    input clk, rst, serial_in,
    output serial_out
);

    reg [3:0] Q;
    
    // bits shift right to output
    // Because we are using non-blocking assignments (<=), 
    // all RHS values are taken from the old state, so the shifting works perfectly.
    
    // another way to implement is Q <= {serial_in, Q[3:1]}; this will lead to shifting compactly.
    always @(posedge clk or posedge rst) begin
        if (rst) Q <= 4'b0000;
        else begin
            Q[3] <= serial_in;
            Q[2] <= Q[3];
            Q[1] <= Q[2];
            Q[0] <= Q[1];
        end
    end
    
    assign serial_out = Q[0];

endmodule

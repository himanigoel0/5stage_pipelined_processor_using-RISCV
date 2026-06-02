`timescale 1ns / 1ps

module decade_counter_mod10(
    input clk, rst,
    output reg [3:0] Q
);

    initial Q <= 4'b0000;   // initialise to 0, else will be undefined until posedge occurs
    
    always @(posedge clk) begin
        if (rst) Q <= 4'b0000;
        else if (Q == 4'd9) Q <= 4'b0000;
        else Q <= Q + 1;
    end
    // for mod 10 counter, we count from 0 to 9.

endmodule

`timescale 1ns / 1ps

module dff_asynchronous_rst(
    input D, rst, clk,
    output reg Q
);

// since we need asynchrnous reset, we also specify rst in the sensitivity list so that whenever rst 
// is activated, the dff resets instead that it activates with clk only.
    always @(posedge clk or posedge rst) begin
        if (rst) Q <= 1'b0;
        else Q <= D;
    end
    
endmodule

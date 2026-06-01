`timescale 1ns / 1ps

module binary_counter_synch(
    input clk, rst,
    output reg [3:0] Q
);

// we can make synch up counter using TFF also, or just simply increment the value
// but we have already made TFF with asynchrnous reset, so we dont use it here.
// do the increment logic.

// since we dont have rst in the sensitivity list, this is synchronous rst, that occurs only on the clk edge.

    // initialise Q to 0, because we have synch rst (at posedge clk only) 
    // so it will be undefined before the first clk edge hits
    initial Q <= 4'b0000;
    
    always @(posedge clk) begin
        if (rst)
            Q <= 4'b0000;
        else
            Q <= Q + 1;
    end

endmodule

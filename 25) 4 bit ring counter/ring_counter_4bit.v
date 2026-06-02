`timescale 1ns / 1ps

module ring_counter_4bit(
    input clk, rst,
    output reg [3:0] counter
);

    always @(posedge clk or posedge rst) begin
        if (rst) counter <= 4'b0001;
        else if (counter == 4'b1000) counter <= 4'b0001;
        else counter <= (counter << 1);
    end
    // we prefer the feedback form
    // we could also do counter <= {counter[2:0], counter[3]};
    
endmodule

// APPLICATIONS: 
// Sequence generation
// Timing control circuits
// Traffic light controllers
// FSM state generation
// LED chasers/running lights

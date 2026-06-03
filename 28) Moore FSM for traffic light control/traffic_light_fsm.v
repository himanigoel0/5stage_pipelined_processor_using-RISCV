`timescale 1ns / 1ps

// ASSUMPTIONS
// we have 2 roads, road A and road B (crossing each other).
// we are implementing a traffic light for their intersection point.
// when we have reset, then road A has green light and road B has reg light.
// we have a timer so that green and red stay for 5 clk cycles, yellow stays for 2 clk cycles.
// the traffic light transitions from green to yellow to red, or red to green.

module traffic_light_fsm(
    input clk , rst,
    output reg ga, ya, ra,
    output reg gb, yb, rb
);
    // ga output means the green light is active at road A... and so on
    reg [1:0] present_state, next_state;
    reg [2:0] timer;
    
    parameter state1 = 2'b00;    // A green, B red
    parameter state2 = 2'b01;    // A yellow, B red
    parameter state3 = 2'b10;    // A red, B green
    parameter state4 = 2'b11;    // A red, B yellow
    
    parameter green_time = 3'd4;
    parameter yellow_time = 3'd1;
    
    // NEXT STATE LOGIC
    always @(*) begin
        next_state = present_state;     // default initialisation
        
        if (present_state == state1 && timer == green_time) next_state = state2;
        else if (present_state == state2 && timer == yellow_time) next_state = state3;
        else if (present_state == state3 && timer == green_time) next_state = state4;
        else if (present_state == state4 && timer == yellow_time) next_state = state1;
        
    end
    
    // SEQUENTIAL LOGIC
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            timer <= 0;
            present_state <= state1;
        end
        else begin 
            // reset the timer to 0 if we enter next state.
            if (present_state != next_state) timer <= 0;
            else timer <= timer + 1;
            present_state <= next_state;
        end
    end
    
    // OUTPUT LOGIC
    always @(*) begin
        if (present_state == state1) begin
            ga = 1; ya = 0; ra = 0;
            gb = 0; yb = 0; rb = 1;
        end
        else if (present_state == state2) begin
            ga = 0; ya = 1; ra = 0;
            gb = 0; yb = 0; rb = 1;
        end
        else if (present_state == state3) begin
            ga = 0; ya = 0; ra = 1;
            gb = 1; yb = 0; rb = 0;
        end
        else if (present_state == state4) begin
            ga = 0; ya = 0; ra = 1;
            gb = 0; yb = 1; rb = 0;
        end
    end
    
endmodule

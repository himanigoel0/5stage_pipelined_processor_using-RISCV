`timescale 1ns / 1ps

// ASSUMPTIONS: 
// MOORE machine.
// we have only one product. Its price is rs 15.
// our machine accepts coins of denomination 5 and 10 only.
// we can accept only 1 coin at a time.
// maximum amount that can be accepted is rs 20.

module vending_machine_fsm(
    input clk, rst, 
    input insert5,
    input insert10,
    input cancel,
    output reg dispense,
    output reg change
);
    
    parameter rst_state = 3'b000;
    parameter rs5 = 3'b001;
    parameter rs10 = 3'b010;
    parameter rs15 = 3'b011;
    parameter rs20 = 3'b100;
    
    reg [2:0] present_state, next_state;
    
    // NEXT STATE LOGIC:
    always @(*) begin
        next_state = present_state;     // default assignment
//      if (rst) next_state = rst_state;
        if (cancel) next_state = rst_state;
        else if (present_state == rst_state && insert5) next_state = rs5;
        else if (present_state == rst_state && insert10) next_state = rs10; 
        else if (present_state == rs5 && insert5) next_state = rs10;
        else if (present_state == rs5 && insert10) next_state = rs15;
        else if (present_state == rs10 && insert5) next_state = rs15;
        else if (present_state == rs10 && insert10) next_state = rs20;
        else if (present_state == rs15) next_state = rst_state; 
        else if (present_state == rs20) next_state = rst_state; 
    end
   
    // SEQUENTIAL LOGIC
    always @(posedge clk or posedge rst) begin
        if (rst) present_state <= rst_state;
        else present_state <= next_state;
    end
     
    
    // OUTPUT LOGIC:
    always @(*) begin
        // we get change (5 rs by default) only when we are at the rs10 state and we still get 10rs input
        if (present_state == rst_state) begin
            dispense = 0;
            change = 0;
        end
        else if (present_state == rs5) begin
            dispense = 0;
            change = 0;
        end
        else if (present_state == rs10) begin
            dispense = 0;
            change = 0;
        end
        else if (present_state == rs15) begin
            dispense = 1;
            change = 0;
        end
        else if (present_state == rs20) begin
            dispense = 1;
            change = 1;
        end
    end

endmodule

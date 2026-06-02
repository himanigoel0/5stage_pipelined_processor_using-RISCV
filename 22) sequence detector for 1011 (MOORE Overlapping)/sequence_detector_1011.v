`timescale 1ns / 1ps

// MOORE overlapping sequence detector: 

module sequence_detector_1011(
    input rst, clk, x,
    output y
);
    reg [2:0] present_state, next_state;
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    
    
    // NEXT STATE LOGIC:
    always @(*) begin
    
        next_state = A; // initialise to prevent latches.
        
        if (present_state == A) begin
            if (x == 0) next_state = A;
            else if (x == 1) next_state = B;
        end
        
        if (present_state == B) begin
            if (x == 0) next_state = C;
            else if (x == 1) next_state = B;
        end
        
        if (present_state == C) begin
            if (x == 0) next_state = A;
            else if (x == 1) next_state = D;
        end
        
        if (present_state == D) begin
            if (x == 0) next_state = C;
            else if (x == 1) next_state = E;
        end
        
        if (present_state == E) begin
            if (x == 0) next_state = C;
            else if (x == 1) next_state = B;
        end
    end
    
    
    // SEQUENTIAL LOGIC:
    // using asynchronous rst to prevent uninitialised output.
    always @(posedge clk or posedge rst) begin
        if (rst) present_state <= A;
        else present_state <= next_state;
    end
    
    //  OUTPUT LOGIC:
    assign y = (present_state == E);
    

endmodule

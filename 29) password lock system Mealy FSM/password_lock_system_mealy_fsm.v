`timescale 1ns / 1ps

// ASSUMPTION:
// my password is 1011.

module password_lock_system_mealy_fsm(
    input clk, rst, 
    input pswd_bit,
    output reg unlock
);
    reg [1:0] present_state, next_state;
    
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    
    // NEXT STATE LOGIC
    always @(*) begin
        next_state = present_state;
        
        if (present_state == A) begin
            case(pswd_bit)
                1'b0: next_state = A;
                1'b1: next_state = B;
            endcase
        end
        
        else if (present_state == B) begin
            case(pswd_bit)
                1'b0: next_state = C;
                1'b1: next_state = B;
            endcase
        end
        
        else if (present_state == C) begin
            case(pswd_bit)
                1'b0: next_state = A;
                1'b1: next_state = D;
            endcase
        end
        
        else if (present_state == D) begin
            case(pswd_bit)
                1'b0: next_state = C;
                1'b1: next_state = B;
            endcase
        end
    end
    
    // SEQUENTIAL LOGIC:
    always @(posedge clk or posedge rst) begin
        if (rst) present_state <= A;
        else present_state <= next_state;
    end
    
    // OUTPUT LOGIC:
    always @(*) begin
        if (present_state == D && pswd_bit == 1) unlock = 1;
        else unlock = 0;
    end

endmodule

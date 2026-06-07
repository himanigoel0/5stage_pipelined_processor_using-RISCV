`timescale 1ns / 1ps

module beq_tb();

    reg [7:0] pc;
    reg signed [7:0] num1, num2;
    reg signed [3:0] offset;
    
    wire [7:0] next_pc;
    
    beq uut (pc, num1, num2, offset, next_pc);
    
    initial begin
        // Branch taken
        pc = 8'd10;
        num1 = 20;
        num2 = 20;
        offset = 4;
        #10;
        // expected next_pc = 15 (10+1+4)
    
        // Branch not taken
        pc = 8'd10;
        num1 = 20;
        num2 = 30;
        offset = 4;
        #10;
        // expected next_pc = 11
    
        // Backward branch
        pc = 8'd20;
        num1 = 5;
        num2 = 5;
        offset = -3;
        #10;
        // expected next_pc = 18 (20+1-3)
    
        // Zero offset
        pc = 8'd50;
        num1 = 7;
        num2 = 7;
        offset = 0;
        #10;
        // expected next_pc = 51
        
        $finish;
    end

endmodule

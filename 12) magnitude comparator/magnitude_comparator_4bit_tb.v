`timescale 1ns / 1ps

module magnitude_comparator_4bit_tb();
    reg [7:0] A, B;
    wire et, lt, gt;
    
    magnitude_comparator_4bit uut (.A(A), .B(B), .et(et), .lt(lt), .gt(gt));
    
    initial begin
        // testing et
        A = 8'd25; B = 8'd25;
        #10; A = 8'd55; B = 8'd55;
        #10; A = 8'd77; B = 8'd77;
        
        // testing gt
        #10; A = 8'd78; B = 8'd25;
        #10; A = 8'd50; B = 8'd40;
        #10; A = 8'd78; B = 8'd8;
        
        // testing lt
        #10; A = 8'd78; B = 8'd125;
        #10; A = 8'd15; B = 8'd20;
        #10; A = 8'd58; B = 8'd99;
        
        #10; $finish;
    end
    
endmodule

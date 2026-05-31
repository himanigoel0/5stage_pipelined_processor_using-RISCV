`timescale 1ns / 1ps

module comparator_8bitt(
    input signed [7:0] A, B,
    output reg et, lt, gt
);

    always @(*) begin
        if (A[7] == 0 && B[7] == 0) begin   
            if (A > B) begin
                gt = 1; 
                lt = 0;
                et = 0;
            end
            else if (A < B) begin
                gt = 0; 
                lt = 1;
                et = 0;
            end
            else if (A == B) begin
                gt = 0; 
                lt = 0;
                et = 1;
            end
        end  
        
        else if (A[7] == 1 && B[7] == 1) begin
            if (A > B) begin
                gt = 1; 
                lt = 0;
                et = 0;
            end
            else if (A < B) begin
                gt = 0; 
                lt = 1;
                et = 0;
            end
            else if (A == B) begin
                gt = 0; 
                lt = 0;
                et = 1;
            end
        end  
        
        else if (A[7] == 0 && B[7] == 1) begin
            gt = 1;
            lt = 0;
            et = 0;
        end
        
        else if (A[7] == 1 && B[7] == 0) begin
            gt = 0;
            lt = 1;
            et = 0;
        end
        
    end
    
endmodule

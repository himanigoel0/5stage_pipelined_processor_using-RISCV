`timescale 1ns / 1ps

module comparator_8bit(
    input [7:0] A, B,
    output reg gt, et, lt
);

    always @(*) begin
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

endmodule

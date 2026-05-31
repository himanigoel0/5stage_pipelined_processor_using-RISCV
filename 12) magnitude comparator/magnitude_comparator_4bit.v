`timescale 1ns / 1ps

module magnitude_comparator_4bit(
    input [7:0] A, B,
    output reg et, lt, gt
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
        else begin
            gt = 0;
            lt = 0;
            et = 1;
        end
end

// this is a magnitude comparator, no checking of sign bit, just compare the magnitudes
    
endmodule

`timescale 1ns / 1ps

module digital_clock_counter(
    input clk, rst,
    output [16:0] timer,
    output reg [4:0] HH,   // 0 to 23
    output reg [5:0] MM,   // 0 to 59
    output reg [5:0] SS   // 0 to 59
);
    
    always @(posedge clk or posedge rst) begin
    
        $monitor("%0d:%0d:%0d", HH, MM, SS);
        
        if (rst) begin
            SS <= 0;
            MM <= 0;
            HH <= 0;
        end
        else begin
            if (HH == 5'd23 && MM == 6'd59 && SS == 6'd59) begin
                SS <= 0;
                MM <= 0;
                HH <= 0;
            end
            else if (MM == 6'd59 && SS == 6'd59) begin
                SS <= 0;
                MM <= 0;
                HH <= HH + 1;
            end
            else if (SS == 6'd59) begin
                SS <= 0;
                MM <= MM + 1;
            end
            else SS <= SS + 1;
        end
    end
    
    assign timer = {HH, MM, SS};
    
endmodule

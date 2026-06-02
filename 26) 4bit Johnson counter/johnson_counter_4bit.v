`timescale 1ns / 1ps

module johnson_counter_4bit(
    input clk, rst,
    output reg [3:0] counter
);

// in ring counter, the last ff output (MSB) is fed as feedback to the first ff input (LSB)
// in johnson counter, the inverse of MSB is fed to LSB.

    always @(posedge clk or posedge rst) begin
        if (rst) counter <= 4'b0000;
        else counter <= {counter[2:0], ~counter[3]};
    end

endmodule

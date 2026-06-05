`timescale 1ns / 1ps

// A Program Counter (PC) is basically just a register that:
// 1) Stores current address/instruction location.
// 2) Increments every clock cycle.
// 3) Can be reset.
// 4) Can be disabled using enable.

module pc(
    input clk, rst, en,
    output reg [7:0] pc
);

    always @(posedge clk or posedge rst) begin
        if (rst) pc <= 0;
        else if (en) pc <= pc + 1;      // hold if not enable
    end
    
    // if pc = 255 and en = 1, then pc_next = 0, it wraps around.

endmodule

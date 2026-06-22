`timescale 1ns / 1ps

module riscv_top(
    input clk,
    input rst,
    input [7:0] gpio_in,
    output [7:0] gpio_out
);

    // Placeholder I/O connection   
    // Actual GPIO functionality will be added in the GPIO/MMIO tasks.
    reg [7:0] gpio;   
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            gpio <= 8'b0;
    end
          
    assign gpio_out = gpio;

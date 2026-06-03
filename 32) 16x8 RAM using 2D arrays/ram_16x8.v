`timescale 1ns / 1ps

// A memory cell always stores a binary value. To remove data, we overwrite it with another value.
// so we dont have some separate delete option.

module ram_16x8(
    input clk,
    input write_enable, 
    input [7:0] write_data,
    input [3:0] address,
    output reg [7:0] data
);
    
    // since we are making ram, we do the addresses from 0 to 15 so that we write in the order
    reg [7:0] ram [0:15];
    
    // initialise the ram
    integer i;
    initial begin
        for (i = 0; i <= 15; i = i+1) ram[i] = 8'h00;
    end
    
    always @(posedge clk) begin
        if (write_enable) ram[address] <= write_data;
    end
    
    always @(*) begin
        data = ram[address]; 
        // asynchronous read 
    end

endmodule

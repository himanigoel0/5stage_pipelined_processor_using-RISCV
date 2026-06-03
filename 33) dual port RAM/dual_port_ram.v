`timescale 1ns / 1ps

// in a dual port ram we have 2 independent ports for read and write
// synchronous write and asynchronous read.

module dual_port_ram(
    input clk,
    input  [3:0] write_address,
    input  [3:0] read_address,
    input  [7:0] write_data,
    input  write_enable,
    output reg [7:0] read_data
);

    reg [7:0] ram [0:15];
    
    integer i;
    initial begin
        for (i = 0; i < 16; i = i+1) ram[i] = 0;
    end

    always @(posedge clk) begin
        if (write_enable) ram[write_address] <= write_data;
    end
    
    always @(*) begin
        read_data = ram[read_address];
    end
    
endmodule

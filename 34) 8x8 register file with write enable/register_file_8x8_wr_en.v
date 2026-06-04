`timescale 1ns / 1ps

// A register file is basically a small collection of registers that can be individually accessed.
// 8x8 register file means there are 8 registers, each register stores 8 bits.
// making a register flie with 2 read ports and 1 write port.
// synchronous write and asynchronous read.

module register_file_8x8_wr_en(
    input clk,
    input wr_en,
    input [2:0] write_addr,
    input [7:0] write_data,
    input [2:0] read_addr1, read_addr2,       // 3 bits are enough to represent 8 register file locations.
    output [7:0] read_data1, read_data2 
);

    reg [7:0] rf [0:7];
    
    integer i;
    initial begin
        for (i = 0; i < 8; i = i+1) rf[i] = 0;
    end

    always @(posedge clk) begin
        if (wr_en) rf[write_addr] <= write_data;
    end
    
    assign read_data1 = rf[read_addr1];
    assign read_data2 = rf[read_addr2];

endmodule

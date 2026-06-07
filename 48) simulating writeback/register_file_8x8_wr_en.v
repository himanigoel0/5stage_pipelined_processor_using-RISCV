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
    output [7:0] read_data1, read_data2,
    
    output [7:0] r0,
    output [7:0] r1,
    output [7:0] r2,
    output [7:0] r3,
    output [7:0] r4,
    output [7:0] r5,
    output [7:0] r6,
    output [7:0] r7,
);

    reg [7:0] rf [0:7];
    
    integer i;
    initial begin
        rf[0] = 8'd5;
        rf[1] = 8'd10;
        rf[2] = 8'd20;
        rf[3] = 8'd30;
        rf[4] = 8'd2;
        rf[5] = 8'd7;
        rf[6] = 8'd1;
        rf[7] = 8'd0;
    end

    always @(posedge clk) begin
        if (wr_en) rf[write_addr] <= write_data;
    end
    
    assign read_data1 = rf[read_addr1];
    assign read_data2 = rf[read_addr2];
    
    assign r0 = rf[0];
    assign r1 = rf[1];
    assign r2 = rf[2];
    assign r3 = rf[3];
    assign r4 = rf[4];
    assign r5 = rf[5];
    assign r6 = rf[6];
    assign r7 = rf[7];

endmodule

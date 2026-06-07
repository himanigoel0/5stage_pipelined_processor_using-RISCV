`timescale 1ns / 1ps

// 32 registers, each 32 bits wide, 2 read ports, 1 write port
// we need 5 bits for the write address since we have 32 registers
// real risc has rf[0] = 0 forever.

module rf_32x32(
    input clk, wr_en,
    input [4:0] write_addr, read_addr1, read_addr2,
    input [31:0] write_data,
    
    output [31:0] read_data1, read_data2
);
    reg [31:0] rf [0:31];
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i+1) begin
            rf[i] = 0;
        end
    end

    always @(posedge clk) begin
        if (wr_en && write_addr != 5'd0) begin
            rf[write_addr] <= write_data;
        end
    end
    // since we dont have else wr_en = 0, the block doesnt execute and the prev values remain preserved.
    
    assign read_data1 = rf[read_addr1];
    assign read_data2 = rf[read_addr2];

endmodule

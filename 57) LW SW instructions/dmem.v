`timescale 1ns / 1ps

module dmem(
    input clk,
    input memwrite,
    input memread,
    input [31:0] addr,
    input [31:0] write_data,

    output reg [31:0] read_data
);

    reg [31:0] mem [0:255];
    integer i;

    initial begin
        for(i=0; i<256; i=i+1)
            mem[i] = 0;
    end

    // SW
    always @(posedge clk) begin
        if(memwrite)
            mem[addr] <= write_data;
    end

    // LW
    always @(*) begin
        if(memread)
            read_data = mem[addr];
        else
            read_data = 32'b0;
    end

endmodule
`timescale 1ns / 1ps

module lw_sw_tb();
    reg clk;
    reg [4:0] rs1, rs2, rd;
    reg signed [11:0] offset;
    reg lw, sw;
    
    wire [4:0] wb_addr;
    wire [31:0] wb_data;
    wire wb_en;
    wire [31:0] read_data1, read_data2;
    
    lw_sw uut(.clk(clk),
              .rs1(rs1),
              .rs2(rs2),
              .rd(rd),
              .offset(offset),
              .lw(lw),
              .sw(sw),
              .wb_addr(wb_addr),
              .wb_data(wb_data),
              .wb_en(wb_en),
              .read_data1(read_data1),
              .read_data2(read_data2)
              );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        // sw operation
        lw = 0; sw = 1; rs1 = 2; rs2 = 5; rd = 0; offset = 8; #50; 
        // lw operation
        lw = 1; sw = 0; rs1 = 2; rs2 = 0; rd = 3; offset = 8; #50; 
        // testing whether writeback actually happened
        rs1 = 3;    // observe read_data1 now, if 100, then successful.
        #20; $finish;
    end
    
endmodule

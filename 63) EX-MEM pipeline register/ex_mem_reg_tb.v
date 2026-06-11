`timescale 1ns / 1ps

module ex_mem_reg_tb();

    reg clk;
    reg rst;

    reg [31:0] alu_result_in;
    reg [31:0] read_data2_in;
    reg [4:0] rd_in;

    reg regwrite_in;
    reg memread_in;
    reg memwrite_in;

    wire [31:0] alu_result_out;
    wire [31:0] read_data2_out;
    wire [4:0] rd_out;

    wire regwrite_out;
    wire memread_out;
    wire memwrite_out;

    ex_mem_reg uut(

        .clk(clk),
        .rst(rst),

        .alu_result_in(alu_result_in),
        .read_data2_in(read_data2_in),
        .rd_in(rd_in),

        .regwrite_in(regwrite_in),
        .memread_in(memread_in),
        .memwrite_in(memwrite_in),

        .alu_result_out(alu_result_out),
        .read_data2_out(read_data2_out),
        .rd_out(rd_out),

        .regwrite_out(regwrite_out),
        .memread_out(memread_out),
        .memwrite_out(memwrite_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        rst = 1;

        alu_result_in = 32'd30;
        read_data2_in = 32'd20;
        rd_in = 5'd3;

        regwrite_in = 1;
        memread_in = 1;
        memwrite_in = 0;

        #10; rst = 0;
        #30; $finish;

    end

endmodule
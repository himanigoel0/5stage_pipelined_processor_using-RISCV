`timescale 1ns / 1ps

module id_ex_reg_tb();

    reg clk;
    reg rst;

    reg [31:0] pc_in;
    reg [31:0] read_data1_in;
    reg [31:0] read_data2_in;
    reg [31:0] imm_in;
    reg [4:0] rd_in;
    reg regwrite_in;
    reg memread_in;
    reg memwrite_in;
    reg branch_in;
    reg jump_in;
    reg [3:0] alu_control_in;

    wire [31:0] pc_out;
    wire [31:0] read_data1_out;
    wire [31:0] read_data2_out;
    wire [31:0] imm_out;
    wire [4:0] rd_out;

    wire regwrite_out;
    wire memread_out;
    wire memwrite_out;
    wire branch_out;
    wire jump_out;
    wire [3:0] alu_control_out;

    id_ex_reg uut(
        .clk(clk),
        .rst(rst),

        .pc_in(pc_in),
        .read_data1_in(read_data1_in),
        .read_data2_in(read_data2_in),
        .imm_in(imm_in),
        .rd_in(rd_in),

        .regwrite_in(regwrite_in),
        .memread_in(memread_in),
        .memwrite_in(memwrite_in),
        .branch_in(branch_in),
        .jump_in(jump_in),
        .alu_control_in(alu_control_in),

        .pc_out(pc_out),
        .read_data1_out(read_data1_out),
        .read_data2_out(read_data2_out),
        .imm_out(imm_out),
        .rd_out(rd_out),

        .regwrite_out(regwrite_out),
        .memread_out(memread_out),
        .memwrite_out(memwrite_out),
        .branch_out(branch_out),
        .jump_out(jump_out),
        .alu_control_out(alu_control_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        rst = 1;

        pc_in = 32'd100;
        read_data1_in = 32'd10;
        read_data2_in = 32'd20;
        imm_in = 32'd8;
        rd_in = 5'd3;
        regwrite_in = 1;
        memread_in = 1;
        memwrite_in = 0;
        branch_in = 0;
        jump_in = 0;
        alu_control_in = 4'b0000;

        #10;

        rst = 0;

        #30;

        $finish;

    end

endmodule
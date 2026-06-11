`timescale 1ns / 1ps

module id_ex_reg(

    input clk,
    input rst,

    // Data signals
    input [31:0] pc_in,
    input [31:0] read_data1_in,
    input [31:0] read_data2_in,
    input [31:0] imm_in,
    input [4:0] rd_in,

    // Control signals
    input regwrite_in,
    input memread_in,
    input memwrite_in,
    input branch_in,
    input jump_in,
    input [3:0] alu_control_in,

    // Outputs
    output reg [31:0] pc_out,
    output reg [31:0] read_data1_out,
    output reg [31:0] read_data2_out,
    output reg [31:0] imm_out,
    output reg [4:0] rd_out,
    output reg regwrite_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg branch_out,
    output reg jump_out,
    output reg [3:0] alu_control_out
);

    always @(posedge clk or posedge rst) begin
    
        if(rst)
            begin
                pc_out <= 0;
                read_data1_out <= 0;
                read_data2_out <= 0;
                imm_out <= 0;
                rd_out <= 0;
                regwrite_out <= 0;
                memread_out <= 0;
                memwrite_out <= 0;
                branch_out <= 0;
                jump_out <= 0;
                alu_control_out <= 0;
            end
        
            else
            begin
                pc_out <= pc_in;
                read_data1_out <= read_data1_in;
                read_data2_out <= read_data2_in;
                imm_out <= imm_in;
                rd_out <= rd_in;
                regwrite_out <= regwrite_in;
                memread_out <= memread_in;
                memwrite_out <= memwrite_in;
                branch_out <= branch_in;
                jump_out <= jump_in;
                alu_control_out <= alu_control_in;
            end
    
    end

endmodule
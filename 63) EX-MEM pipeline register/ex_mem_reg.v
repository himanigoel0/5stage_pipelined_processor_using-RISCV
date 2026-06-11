`timescale 1ns / 1ps

module ex_mem_reg(

    input clk,
    input rst,

    // Data signals
    input [31:0] alu_result_in,
    input [31:0] read_data2_in,     // specifically for sw instructions
    input [4:0] rd_in,              // for writeback

    // Control signals
    input regwrite_in,  // writeback
    input memread_in,   // lw
    input memwrite_in,  // sw

    // Outputs
    output reg [31:0] alu_result_out,
    output reg [31:0] read_data2_out,
    output reg [4:0] rd_out,

    output reg regwrite_out,
    output reg memread_out,
    output reg memwrite_out

);

    always @(posedge clk or posedge rst) begin
    
        if(rst)
            begin
                alu_result_out <= 0;
                read_data2_out <= 0;
                rd_out <= 0;
                regwrite_out <= 0;
                memread_out <= 0;
                memwrite_out <= 0;
            end
    
        else
            begin
                alu_result_out <= alu_result_in;
                read_data2_out <= read_data2_in;
                rd_out <= rd_in;
                regwrite_out <= regwrite_in;
                memread_out <= memread_in;
                memwrite_out <= memwrite_in;
            end
    
        end

endmodule
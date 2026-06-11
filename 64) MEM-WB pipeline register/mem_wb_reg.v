`timescale 1ns / 1ps

module mem_wb_reg(
    input clk, rst,
    // data signals:
    input [31:0] alu_result_in,     // for writeback of R-type data
    input [31:0] mem_data_read_in,  // for writeback of lw data
    input [4:0] rd_in,                 // the register in which writeback has to happen
    // control singal:
    input regwrite_in,     // for writeback in case of lw and R-type
    
    output reg [31:0] alu_result_out,
    output reg [31:0] mem_data_read_out,
    output reg [4:0] rd_out,
    output reg regwrite_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            alu_result_out <= 0;
            mem_data_read_out <= 0;
            rd_out <= 0;
            regwrite_out <= 0;
        end
        
        else begin
            alu_result_out <= alu_result_in;
            mem_data_read_out <= mem_data_read_in;
            rd_out <= rd_in;
            regwrite_out <= regwrite_in;
        end
    end

endmodule

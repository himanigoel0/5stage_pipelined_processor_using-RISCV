`timescale 1ns / 1ps

// till now all the if, id, ex, mem, wb everything was happening within a single clk cycle.
// now in pipeline, cycle 1 -> pc -> imem -> if/id reg
//                  cycle 2 -> if/id reg -> decoder

module if_id_reg(
    input clk,
    input rst,
    input [31:0] pc_in,
    input [31:0] instr_in,
    output reg [31:0] pc_out,
    output reg [31:0] instr_out
);

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            pc_out    <= 32'd0;
            instr_out <= 32'h00000013;      // NOP instruction
        end
        else begin
            pc_out    <= pc_in;
            instr_out <= instr_in;
        end
    end    

endmodule

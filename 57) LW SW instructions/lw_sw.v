`timescale 1ns / 1ps

// LW format: I-type
// 31           20 19   15 14  12 11    7 6      0
// +--------------+-------+------+-------+--------+
// | imm[11:0]    | rs1   |funct3|  rd   | opcode |
// +--------------+-------+------+-------+--------+
// opcode = 0000011
// funct3 = 010
// lw x2, x1(8) means x2 = mem[x1+8] (load from memory)

// SW format:
// 31      25 24   20 19   15 14  12 11     7 6      0
// +---------+-------+-------+------+---------+--------+
// | imm[11:5]| rs2  | rs1   |funct3|imm[4:0] | opcode |
// +---------+-------+-------+------+---------+--------+
// opcode = 0100011
// funct3 = 010
// sw x2, x1(8) means mem[x1+8] = x2 (store in memory)

`timescale 1ns / 1ps

module lw_sw(
    input clk,

    // decoded instruction fields
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input signed [11:0] offset,

    input lw,
    input sw,

    // write-back signals (used for lw)
    output [4:0] wb_addr,
    output [31:0] wb_data,
    output wb_en,
    
    output [31:0] read_data1,
    output [31:0] read_data2
);

    // ---------------------------------------------------------------------------------------
    // read data 1 and 2 are the Register File Signals (used to encode the register values)
    // ---------------------------------------------------------------------------------------

    rf_32x32 rf (
        .clk(clk),
        .wr_en(wb_en),
        .write_addr(wb_addr),
        .write_data(wb_data),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ----------------------
    // Effective Address
    // ----------------------

    wire [31:0] effective_addr;

    // we always do data[rs1] + offset in both the cases
    assign effective_addr = read_data1 + {{20{offset[11]}},offset};   // sign extend to make 32 bits.

    // ----------------------
    // Data Memory Signals
    // ----------------------

    wire [31:0] mem_read_data;

    dmem dm (
        .clk(clk),
        .memwrite(sw),      // write when we know that the mode is store
        .memread(lw),       // read when we know that the mode is load
        .addr(effective_addr),
        .write_data(read_data2),    // store value from rs2.
        .read_data(mem_read_data)   // read data from memory (output)
    );

    // ----------------------
    // Write Back
    // ----------------------

    assign wb_addr = rd;
    assign wb_data = mem_read_data; // write back in case of lw, the data outputted from dmem.
    assign wb_en = lw;

endmodule
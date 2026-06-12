`timescale 1ns / 1ps

module add_sub_pipeline(
    input clk,
    input rst,
    
    output [31:0] pc_debug,
    output [31:0] instruction_debug,

    output [31:0] read_data1_debug,
    output [31:0] read_data2_debug,

    output [31:0] alu_result_debug,

    output [31:0] writeback_data_debug
);

    //================================================
    // IF STAGE
    //================================================

    wire [31:0] pc;
    wire [31:0] instruction;

    pc_32 pc_inst(
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .next_pc(pc + 32'd4),
        .pc(pc)
    );

    imem_32 imem_inst(
        .address(pc),
        .instruction(instruction)
    );

    //================================================
    // IF/ID register
    //================================================

    wire [31:0] ifid_pc;
    wire [31:0] ifid_instr;

    if_id_reg ifid(
        .clk(clk),
        .rst(rst),
        .pc_in(pc),
        .instr_in(instruction),
        .pc_out(ifid_pc),
        .instr_out(ifid_instr)
    );

    //================================================
    // ID STAGE
    //================================================

    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [6:0] opcode;

    rv32i_decoder decoder(
        .instruction(ifid_instr),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode)
    );

    wire regwrite;
    wire memread;
    wire memwrite;
    wire branch;
    wire jump;
    wire [3:0] alu_control;

    control_unit_rv32i cu(
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode),

        .regwrite(regwrite),
        .memread(memread),
        .memwrite(memwrite),
        .branch(branch),
        .jump(jump),
        .alu_control(alu_control)
    );

    //================================================
    // WB DATA FROM MEM/WB
    //================================================

    wire [31:0] wb_data;
    wire [4:0] memwb_rd;
    wire memwb_regwrite;

    //================================================
    // REGISTER FILE
    //================================================

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    rf_32x32 rf(
        .clk(clk),
        .wr_en(memwb_regwrite),
        .write_addr(memwb_rd),
        .write_data(wb_data),

        .read_addr1(rs1),
        .read_addr2(rs2),

        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    //================================================
    // ID/EX
    //================================================

    wire [31:0] idex_pc;
    wire [31:0] idex_rd1;
    wire [31:0] idex_rd2;
    wire [31:0] idex_imm;

    wire [4:0] idex_rd;

    wire idex_regwrite;
    wire idex_memread;
    wire idex_memwrite;
    wire idex_branch;
    wire idex_jump;

    wire [3:0] idex_alu_control;
    wire [6:0] idex_opcode;

    id_ex_reg idex(
        .clk(clk),
        .rst(rst),

        .pc_in(ifid_pc),
        .read_data1_in(read_data1),
        .read_data2_in(read_data2),

        .imm_in(32'd0),
        .rd_in(rd),

        .regwrite_in(regwrite),
        .memread_in(memread),
        .memwrite_in(memwrite),
        .branch_in(branch),
        .jump_in(jump),

        .alu_control_in(alu_control),
        .opcode_in(opcode),

        .pc_out(idex_pc),
        .read_data1_out(idex_rd1),
        .read_data2_out(idex_rd2),

        .imm_out(idex_imm),
        .rd_out(idex_rd),

        .regwrite_out(idex_regwrite),
        .memread_out(idex_memread),
        .memwrite_out(idex_memwrite),
        .branch_out(idex_branch),
        .jump_out(idex_jump),

        .alu_control_out(idex_alu_control),
        .opcode_out(idex_opcode)
    );

    //================================================
    // EX STAGE
    //================================================

    wire [31:0] alu_result;
    wire carry;
    wire overflow;

    alu_32 alu(
        .num1(idex_rd1),
        .num2(idex_rd2),

        .alu_control(idex_alu_control),

        .result(alu_result),
        .carry(carry),
        .overflow(overflow)
    );

    //================================================
    // EX/MEM
    //================================================

    wire [31:0] exmem_pc;
    wire [31:0] exmem_imm;
    wire [31:0] exmem_alu_result;
    wire [31:0] exmem_rd2;

    wire [4:0] exmem_rd;

    wire exmem_regwrite;
    wire exmem_memread;
    wire exmem_memwrite;
    wire exmem_branch;
    wire exmem_jump;

    ex_mem_reg exmem(
        .clk(clk),
        .rst(rst),

        .pc_in(idex_pc),
        .imm_in(32'd0),

        .alu_result_in(alu_result),
        .read_data2_in(idex_rd2),

        .rd_in(idex_rd),

        .regwrite_in(idex_regwrite),
        .memread_in(idex_memread),
        .memwrite_in(idex_memwrite),
        .branch_in(idex_branch),
        .jump_in(idex_jump),

        .pc_out(exmem_pc),
        .imm_out(exmem_imm),

        .alu_result_out(exmem_alu_result),
        .read_data2_out(exmem_rd2),

        .rd_out(exmem_rd),

        .regwrite_out(exmem_regwrite),
        .memread_out(exmem_memread),
        .memwrite_out(exmem_memwrite),
        .branch_out(exmem_branch),
        .jump_out(exmem_jump)
    );

    //================================================
    // MEM/WB
    //================================================

    wire [31:0] memwb_alu_result;

    mem_wb_reg memwb(
        .clk(clk),
        .rst(rst),

        .alu_result_in(exmem_alu_result),
        .mem_data_read_in(32'd0),

        .rd_in(exmem_rd),

        .regwrite_in(exmem_regwrite),
        .memread_in(1'b0),

        .alu_result_out(memwb_alu_result),
        .mem_data_read_out(),

        .rd_out(memwb_rd),

        .regwrite_out(memwb_regwrite),
        .memread_out()
    );

    //================================================
    // WB
    //================================================

    assign wb_data = memwb_alu_result;
    assign pc_debug             = pc;
    assign instruction_debug    = ifid_instr;
    
    assign read_data1_debug     = idex_rd1;
    assign read_data2_debug     = idex_rd2;
    
    assign alu_result_debug     = alu_result;
    
    assign writeback_data_debug = wb_data;

endmodule
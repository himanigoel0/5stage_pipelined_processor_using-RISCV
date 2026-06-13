`timescale 1ns / 1ps

// this was initially made for add, sub logic only.
// after that, it was integrated with other instructions also.

module add_sub_pipeline(
    input clk,
    input rst,
    
    output reg [7:0] cycle_count,
    output reg [7:0] instruction_count,
    
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
    wire [31:0] ifid_pc;
    wire [31:0] ifid_instr;
    wire stall;
    wire [31:0] next_pc;
    wire branch_taken;
    wire [31:0] idex_pc;
    wire [31:0] idex_imm;
    
    assign next_pc =
       branch_taken ?
       (idex_pc + idex_imm) :
       (pc + 32'd4);

    pc_32 pc_inst(
        .clk(clk),
        .rst(rst),
        .en(~stall),
        .next_pc(next_pc),
        .pc(pc)
    );

    imem_32 imem_inst(
        .address(pc),
        .instruction(instruction)
    );

    //================================================
    // IF/ID register
    //================================================


    if_id_reg ifid(
        .clk(clk),
        .en(~stall),
        .rst(rst),
        .flush(flush),
        .pc_in(pc),
        .instr_in(instruction),
        .pc_out(ifid_pc),
        .instr_out(ifid_instr)
    );

    //================================================
    // ID STAGE
    //================================================
    
    wire signed [31:0] imm;
    
    immediate_gen imm_gen(
        .instruction(ifid_instr),
        .imm(imm)
    );

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
    
    wire [4:0] idex_rd;
    wire idex_regwrite;

    hazard_stall hdu(
    .id_rs1(rs1),
    .id_rs2(rs2),

    .ex_rd(idex_rd),
    .ex_memread(idex_memread),

    .stall(stall)
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

//    wire [31:0] idex_pc;
    wire [31:0] idex_rd1;
    wire [31:0] idex_rd2;
//    wire [31:0] idex_imm;

    wire [4:0] idex_rs1;
    wire [4:0] idex_rs2;

//    wire idex_memread;
    wire idex_memwrite;
    wire idex_branch;
    wire idex_jump;

    wire [3:0] idex_alu_control;
    wire [6:0] idex_opcode;
    
    wire [4:0] exmem_rd;

    wire exmem_regwrite;

    id_ex_reg idex(
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .flush(flush),

        .pc_in(ifid_pc),
        .read_data1_in(read_data1),
        .read_data2_in(read_data2),

        .imm_in(imm),
        .rd_in(rd),
        .rs1_in(rs1),
        .rs2_in(rs2),

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
        .rs1_out(idex_rs1),
        .rs2_out(idex_rs2),

        .regwrite_out(idex_regwrite),
        .memread_out(idex_memread),
        .memwrite_out(idex_memwrite),
        .branch_out(idex_branch),
        .jump_out(idex_jump),

        .alu_control_out(idex_alu_control),
        .opcode_out(idex_opcode)
    );
    
    wire [1:0] forwardA;
    wire [1:0] forwardB;
    
    forwarding_unit fu(
        .ex_rs1(idex_rs1),
        .ex_rs2(idex_rs2),
    
        .mem_rd(exmem_rd),
        .mem_regwrite(exmem_regwrite),
    
        .wb_rd(memwb_rd),
        .wb_regwrite(memwb_regwrite),
    
        .forwardA(forwardA),
        .forwardB(forwardB)
    );
    
    
    wire [31:0] alu_input2;

    assign alu_input2 =
           (idex_opcode == 7'b0010011 ||   // ADDI
            idex_opcode == 7'b0000011 ||   // LW
            idex_opcode == 7'b0100011) ?   // SW
            idex_imm : idex_rd2;

    //================================================
    // EX STAGE
    //================================================

    wire [31:0] alu_result;
    wire carry;
    wire overflow;
    wire [31:0] alu_src1;
    wire [31:0] alu_src2_forwarded;

    alu_32 alu(
        .num1(alu_src1),
        .num2(alu_src2_forwarded),

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

    wire exmem_memread;
    wire exmem_memwrite;
    wire exmem_branch;
    wire exmem_jump;

    ex_mem_reg exmem(
        .clk(clk),
        .rst(rst),

        .pc_in(idex_pc),
        .imm_in(idex_imm),

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
    
    
    assign alu_src1 =
           (forwardA == 2'b10) ? exmem_alu_result :
           (forwardA == 2'b01) ? wb_data :
                                 idex_rd1;
    
    assign alu_src2_forwarded =
           (forwardB == 2'b10) ? exmem_alu_result :
           (forwardB == 2'b01) ? wb_data :
                                 alu_input2;
    
//    wire branch_taken;

    assign branch_taken = idex_branch;
    assign flush = branch_taken;
    
    wire [31:0] mem_read_data;

    dmem dm(
        .clk(clk),
        .memwrite(exmem_memwrite),
        .memread(exmem_memread),
    
        .addr(exmem_alu_result),
        .write_data(exmem_rd2),
    
        .read_data(mem_read_data)
    );

    //================================================
    // MEM/WB
    //================================================

    wire [31:0] memwb_alu_result;
    wire [31:0] memwb_mem_data;
    wire memwb_memread;

    mem_wb_reg memwb(
        .clk(clk),
        .rst(rst),

        .alu_result_in(exmem_alu_result),
        .mem_data_read_in(mem_read_data),

        .rd_in(exmem_rd),

        .regwrite_in(exmem_regwrite),
        .memread_in(exmem_memread),

        .alu_result_out(memwb_alu_result),
        .mem_data_read_out(memwb_mem_data),

        .rd_out(memwb_rd),

        .regwrite_out(memwb_regwrite),
        .memread_out(memwb_memread)
    );

    //================================================
    // WB
    //================================================

    assign wb_data = memwb_memread ? memwb_mem_data : memwb_alu_result;
    
    
    // debug output signals:
    assign pc_debug             = pc;
    assign instruction_debug    = ifid_instr;
    
    assign read_data1_debug     = idex_rd1;
    assign read_data2_debug     = idex_rd2;
    
    assign alu_result_debug     = alu_result;
    
    assign writeback_data_debug = wb_data;
    
    // cycle count measurement logic:
    always @(posedge clk or posedge rst) begin
        if(rst)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
    end
    
    // counting the number of instructions:
    // using the retired instructions, or control logics generated, we are counting the number of instructions.
    wire instr_retired;
    
    assign instr_retired =
           memwb_regwrite ||   // ADD, SUB, ADDI, LW
           exmem_memwrite ||   // SW
           exmem_branch;       // BEQ
           
    always @(posedge clk or posedge rst) begin
        if(rst)
            instruction_count <= 0;
        else if(instr_retired)
            instruction_count <= instruction_count + 1;
    end

endmodule
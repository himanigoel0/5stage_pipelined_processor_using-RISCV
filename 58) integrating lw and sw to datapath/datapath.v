`timescale 1ns / 1ps

module datapath(
    input clk, 
    input rst,
    
    output [31:0] pc_debug,
    output [31:0] instruction_debug,
    output [31:0] read_data1_debug,
    output [31:0] read_data2_debug,
    output [31:0] alu_result_debug,
    output [31:0] mem_read_data_debug,
    output [31:0] writeback_data_debug
);

    // pc -> IMEM
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] next_pc;
    
    pc_32 pc_inst(
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .next_pc(next_pc),
        .pc(pc)
    );
    
    imem_32 imem_inst(
        .address(pc),
        .instruction(instruction)
    );
    
    // decoding the fields using decoder
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [6:0] opcode;
    
    rv32i_decoder dec(
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode)
    );
    
    // now the control unit will generate control signals
    wire regwrite;
    wire memread;
    wire memwrite;
    wire branch;
    wire jump;
    wire [3:0] alu_control;
    
    control_unit_rv32i cu(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .regwrite(regwrite),
        .memread(memread),
        .memwrite(memwrite),
        .branch(branch),
        .jump(jump),
        .alu_control(alu_control)
    );
    
    // now we extract the immediate out of the instruction
    wire signed [31:0] imm;

    immediate_gen imm_gen(
        .instruction(instruction),
        .imm(imm)
    );
    
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire [31:0] writeback_data;
    
    rf_32x32 rf(
        .clk(clk),
        .wr_en(regwrite),
        .write_addr(rd),
        .write_data(writeback_data),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    // now while we perform ALU operations, R-type needs read_data1 and read_data2,
    // but I-type needs read_data1 and imm. So now we need a mux.
    
    wire signed [31:0] alu_input2;
    
    assign alu_input2 =
            (opcode == 7'b0010011 ||   // ADDI ORI SLTI
             opcode == 7'b0000011 ||   // LW
             opcode == 7'b0100011) ?   // SW
                imm : read_data2;

    // now we can instantiate the ALU
    wire signed [31:0] alu_result;
    wire carry;
    wire overflow;
    
    alu_32 alu(
            .num1(read_data1),
            .num2(alu_input2),
            .alu_control(alu_control),
            .result(alu_result),
            .carry(carry),
            .overflow(overflow)
        );
        
    // now this same result signal can be used for R-type, I-type (as final result).
    // this can also be used by lw or sw as effective address.
    
    // now we can instantiate our dmem for lw and sw operations
    wire [31:0] mem_read_data;
    
    dmem dm(
        .clk(clk),
        .memwrite(memwrite),
        .memread(memread),
        .addr(alu_result),
        .write_data(read_data2),
        .read_data(mem_read_data)
    );
    
    // now for writeback we have three options, jal, lw and R-type. so we again need a mux
    assign writeback_data = jump ? (pc + 32'd4) : memread ? mem_read_data : alu_result;

    // for beq instructions
    wire branch_taken;
    assign branch_taken = branch && (read_data1 == read_data2);

    // next_pc logic
    assign next_pc = jump ? (pc + imm) : branch_taken ? (pc + imm) : (pc + 32'd4);
    
    
    assign pc_debug             = pc;
    assign instruction_debug    = instruction;
    assign read_data1_debug     = read_data1;
    assign read_data2_debug     = read_data2;
    assign alu_result_debug     = alu_result;
    assign mem_read_data_debug  = mem_read_data;
    assign writeback_data_debug = writeback_data;

endmodule

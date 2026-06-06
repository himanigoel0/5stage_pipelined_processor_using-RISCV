`timescale 1ns / 1ps

// now we will integrate all these pc, imem, control unit, rf, alu

module mini_cpu(
    input clk, rst,
    output [7:0] pc_debug,
    output [15:0] instr_debug,
    output [15:0] result_debug
    );
    
    wire [3:0] operation;
    wire regwrite;
    wire [3:0] alucontrol;
    wire signed [7:0] num1, num2;
    wire [1:0] opselect;
    wire [2:0] shift_amt;
    wire [15:0] result;
    wire carry, overflow;
    wire [7:0] pc_out;
    wire [15:0] instruction;
    wire [2:0] rs, rt, rd;
    
    // the control unit will be controlling the execute through alucontrol and writeback through regwrite

    assign operation    = instruction[14:11];
    assign rs           = instruction[10:8];
    assign rt           = instruction[7:5];
    assign rd           = instruction[4:2];
    assign opselect     = instruction[1:0];
    assign pc_debug     = pc_out;
    assign instr_debug  = instruction;
    assign result_debug = result;
    assign shift_amt    = 3'b001;

    pc pc_inst (.clk(clk),
                .rst(rst),
                .en(1'b1),
                .pc(pc_out)
                );
    
    imem imem_inst (.address(pc_out),
                    .instruction(instruction)
                    );
                    
    register_file_8x8_wr_en rf (.clk(clk),
                                .wr_en(regwrite),
                                .write_addr(rd),
                                .write_data(result[7:0]),
                                .read_addr1(rs),
                                .read_addr2(rt),
                                .read_data1(num1),
                                .read_data2(num2)
                            );
    
    control_unit cu (.operation(operation), 
                     .regwrite(regwrite),
                     .alucontrol(alucontrol)
                     );
                     
    alu uut1 (.num1(num1), 
              .num2(num2),
              .operation(alucontrol),
              .opselect(opselect),
              .shift_amt(shift_amt),
              .result(result),
              .carry(carry),
              .overflow(overflow)
              );
endmodule

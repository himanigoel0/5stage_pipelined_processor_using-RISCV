`timescale 1ns / 1ps

module hazard_stall(

    input clk,
    input [4:0] id_rs1,
    input [4:0] id_rs2,

    input [4:0] ex_rd,
    input ex_regwrite,

    output stall
);
    
    // hazard detection:
    assign stall =
            ex_regwrite &&
           ((ex_rd == id_rs1 && ex_rd != 0) ||
            (ex_rd == id_rs2 && ex_rd != 0));   
    // this ex_rd != 0 because 0th register is a special reserved register that is always 0, and it cant be written.
    
    
    
    
    
    // this is just a stall detectino module, these will be done later in bubble insertion logic:
            
//    // PC stall:
    
//    wire rst;
//    wire [31:0] pc;
    
//    pc_32 pc_inst(.clk(clk),
//                  .rst(rst),
//                  .en(~stall),    // if stall, then freeze the pc
//                  .next_pc(pc + 4),
//                  .pc(pc)
//              );
            
//    // IF/ID stall:
    
//    wire [31:0] instr_in; 
    
//    if_id_reg ifid (.clk(clk),
//                    .rst(rst),
//                    .en(~stall),
//                    .pc_in(pc),
//                    .instr_in(instr_in),
//                    .pc_out(pc_out),
//                    .instr_out(instr_out)
//                    );
                    
//    // bubble injection: send NOP in ID/EX
            
endmodule
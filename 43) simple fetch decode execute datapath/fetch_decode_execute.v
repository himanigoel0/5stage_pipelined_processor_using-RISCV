`timescale 1ns / 1ps

// FETCH  means PC -> imem -> instrn
// DECODE me bs bits ko extract krna h
// instruction format: unused | operation | rs  | rt | rd | opselect
//                       15   |   14:11   |10:8 | 7:5| 4:2|  1:0
// next register file se rs, rt, rd read krne and update krne h
// example:     0|000 0|010 |011|0 01|00 == 16'h0264
// now just the operation field will change, rs is 2nd, rt is 3rd, rd is 1st register

// Limitation:
// Register file is 8-bit wide.
// For multiplication, only lower 8 bits of the 16-bit result are written back.

module fetch_decode_execute(
    input clk, rst,
    input [2:0] shift_amt,
    output [15:0] result_out,
    
    output [7:0]  pc_debug,
    output [15:0] instruction_debug,
    output [3:0]  operation_debug,
    output [2:0]  rs_debug,
    output [2:0]  rt_debug,
    output [2:0]  rd_debug,
    output [7:0]  num1_debug,
    output [7:0]  num2_debug
);

    wire [7:0] pc_out;
    wire [15:0] instruction;
    wire [3:0] operation;
    wire [2:0] rs;
    wire [2:0] rt;
    wire [2:0] rd;
    wire [1:0] opcode;
    wire [15:0] result;
    wire carry, overflow;
    wire signed [7:0] num1, num2;
    
    // PC hmesha enable rkh ke pc se address of instr le lenge.
    // fir imem me se instr mil jaega using the pc.
    
    // ====================== FETCH =========================
    pc uut (.clk(clk), .rst(rst), .en(1'b1), .pc(pc_out));
    imem uut1 (.address(pc_out), .instruction(instruction));
    
    // ====================== DECODE ========================
    assign operation = instruction[14:11];
    assign rs = instruction[10:8];
    assign rt = instruction[7:5];
    assign rd = instruction[4:2];
    assign opcode = instruction[1:0];
    
    register_file_8x8_wr_en uut2 (.clk(clk),
                                  .wr_en(1'b1),
                                  .write_addr(rd),
                                  .write_data(result[7:0]),      // for now we store lower 8 bits only due to rf needs
                                  .read_addr1(rs),
                                  .read_addr2(rt),
                                  .read_data1(num1),
                                  .read_data2(num2)
                                 );
                                 
     // ====================== EXECUTE =======================
     alu uut3 (.num1(num1),
               .num2(num2),
               .operation(operation),
               .opselect(opcode),
               .shift_amt(shift_amt),
               .result(result),
               .carry(carry),
               .overflow(overflow)
              );
            
    assign result_out = result;
    
    assign pc_debug          = pc_out;
    assign instruction_debug = instruction;
    assign operation_debug   = operation;
    assign rs_debug          = rs;
    assign rt_debug          = rt;
    assign rd_debug          = rd;
    assign num1_debug        = num1;
    assign num2_debug        = num2;
    
endmodule

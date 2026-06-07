`timescale 1ns / 1ps

module opcode_decoder_rv32i_tb();
    reg [6:0] opcode;

    wire r_type;
    wire i_type;
    wire s_type;
    wire b_type;
    wire u_type;
    wire j_type;
    
    opcode_decoder_rv32i uut(
        opcode,
        r_type,
        i_type,
        s_type,
        b_type,
        u_type,
        j_type
    );
    
    initial begin
        opcode = 7'b0110011; #10;   // R
        opcode = 7'b0010011; #10;   // I
        opcode = 7'b0100011; #10;   // S
        opcode = 7'b1100011; #10;   // B
        opcode = 7'b0110111; #10;   // U
        opcode = 7'b1101111; #10;   // J
        $finish;
    
    end
endmodule

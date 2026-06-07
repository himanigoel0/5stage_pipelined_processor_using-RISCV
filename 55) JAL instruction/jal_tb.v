`timescale 1ns / 1ps

module jal_tb();

    reg [31:0] instruction;
    reg [31:0] pc;
    wire signed [31:0] offset;
    wire [31:0] pc_out;
    wire [31:0] link_addr;

    jal uut(
        .instruction(instruction),
        .pc(pc),
        .pc_out(pc_out),
        .link_addr(link_addr),
        .offset(offset)
    );

    initial begin

        // --------------------------
        // Not a JAL instruction
        // --------------------------
        pc = 32'd100;
        instruction = 32'h00000013;   // ADDI x0,x0,0
        #10;

        // --------------------------
        // JAL with small positive offset
        // offset = +24
        // --------------------------
        pc = 32'd100;
        instruction = 32'h0180006F;
        #10;

        // --------------------------
        // JAL with larger positive offset
        // --------------------------
        pc = 32'd200;
        instruction = 32'h0200006F;
        #10;

        // --------------------------
        // JAL from PC = 0
        // --------------------------
        pc = 32'd0;
        instruction = 32'h0040006F;
        #10;
        
        // --------------------------
        // negative offset 
        // --------------------------
        pc = 32'd100;
        instruction = 32'hFEDFF06F;
        #10;

        $finish;

    end

endmodule
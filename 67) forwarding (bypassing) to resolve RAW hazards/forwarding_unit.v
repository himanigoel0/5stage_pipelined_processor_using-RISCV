`timescale 1ns / 1ps

module forwarding_unit(

    input [4:0] idex_rs1,
    input [4:0] idex_rs2,

    input [4:0] exmem_rd,
    input exmem_regwrite,

    output reg forwardA,
    output reg forwardB

);

    always @(*) begin
    
        forwardA = 0;
        forwardB = 0;
    
        if(exmem_regwrite &&
           exmem_rd != 0 &&
           exmem_rd == idex_rs1)
            forwardA = 1;
    
        if(exmem_regwrite &&
           exmem_rd != 0 &&
           exmem_rd == idex_rs2)
            forwardB = 1;
    
    end

endmodule
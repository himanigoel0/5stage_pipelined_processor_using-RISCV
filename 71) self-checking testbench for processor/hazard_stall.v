module hazard_stall(

    input [4:0] id_rs1,
    input [4:0] id_rs2,

    input [4:0] ex_rd,
    input ex_memread,

    output stall
);
    
    assign stall = ex_memread && ((ex_rd == id_rs1 && ex_rd != 0) || (ex_rd == id_rs2 && ex_rd != 0));

endmodule
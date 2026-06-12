`timescale 1ns / 1ps

module branch_flush_unit(

    input branch_taken,
    output flush_ifid,
    output flush_idex
);

assign flush_ifid = branch_taken;
assign flush_idex = branch_taken;

endmodule
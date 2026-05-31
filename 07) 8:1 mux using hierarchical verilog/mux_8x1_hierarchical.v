`timescale 1ns / 1ps

module mux_8x1_hierarchical(
    input A, B, C, D ,E, F, G, H,
    input [2:0] sel,
    output Y
);
    wire y1, y2;

    mux_4x1_behavioral m1 (A, B, C, D, sel[1:0], y1);
    mux_4x1_behavioral m2 (E, F, G, H, sel[1:0], y2);
    mux_2x1_structural m3 (y1, y2, sel[2], Y);
    
    // we use 2 predefined 4:1 muxes and their outputs are fed into a 2:1 mux to get the desired output

endmodule

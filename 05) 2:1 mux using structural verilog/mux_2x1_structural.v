`timescale 1ns / 1ps

module mux_2x1_structural(
    input A, B, sel,
    output Y
);
    wire sel_bar;
    wire s1, s2;

    // Y = ~sel.A + sel.B using structual code:
    not (sel_bar, sel);
    and (s1, sel_bar, A);
    and (s2, sel, B);
    or (Y, s1, s2);

endmodule

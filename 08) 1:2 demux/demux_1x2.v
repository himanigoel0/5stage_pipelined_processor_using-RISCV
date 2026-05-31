`timescale 1ns / 1ps

module demux_1x2(
    input A,
    input sel,
    output Y1, Y2
);
    wire sel_bar;

    // if sel = 0, then Y1 = D
    // else if sel = 1, then Y2 = D
    // So, Y1 = sel_bar.D and Y2 = sel.D
    
    not (sel_bar, sel);
    and (Y1, sel_bar, A);
    and (Y2, sel, A);
    
endmodule

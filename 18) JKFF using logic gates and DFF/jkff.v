`timescale 1ns / 1ps

module jkff(
    input J, K, clk, rst,
    output Q
);
    wire D, w1, w2, Qbar, Kbar;

    not (Qbar, Q);
    not (Kbar, K);
    and (w1, Qbar, J);
    and (w2, Q, Kbar);
    or (D, w1, w2);
    
    dff_asynchronous_rst uut (.D(D), .clk(clk), .rst(rst), .Q(Q));
   
endmodule

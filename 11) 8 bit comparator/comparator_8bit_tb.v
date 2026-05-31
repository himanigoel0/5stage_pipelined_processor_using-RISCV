`timescale 1ns / 1ps

module comparator_8bit_tb();
    reg [7:0] A, B;
    wire gt, lt, et;
    
    comparator_8bitt uut (.A(A), .B(B), .gt(gt), .lt(lt), .et(et));
    
    initial begin
        // testing et
        A = 8'd25; B = 8'd25;
        #10; A = -8'd55; B = -8'd55;
        #10; A = 8'd77; B = 8'd77;
        
        // testing gt
        #10; A = 8'd78; B = 8'd25;
        #10; A = 8'd25; B = -8'd40;
        #10; A = -8'd8; B = -8'd58;
        
        // testing lt
        #10; A = 8'd78; B = 8'd125;
        #10; A = -8'd125; B = 8'd20;
        #10; A = -8'd58; B = -8'd29;
        
        #10; $finish;
    end

endmodule

`timescale 1ns / 1ps

module comparator_8bit_tb();
    reg [7:0] A, B;
    wire gt, lt, et;
    
    comparator_8bit uut (.A(A), .B(B), .gt(gt), .lt(lt), .et(et));
    
    initial begin
        // testing et
        A = 8'd25; B = 8'd25;
        #10; A = 8'd255; B = 8'd255;
        #10; A = 8'd58; B = 8'd58;
        
        // testing gt
        #10; A = 8'd78; B = 8'd25;
        #10; A = 8'd255; B = 8'd20;
        #10; A = 8'd58; B = 8'd8;
        
        // testing lt
        #10; A = 8'd78; B = 8'd125;
        #10; A = 8'd25; B = 8'd200;
        #10; A = 8'd58; B = 8'd89;
        
        #10; $finish;
    end

endmodule

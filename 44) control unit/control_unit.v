`timescale 1ns / 1ps

/* Currently the control unit decodes the instruction opcode and generates 
   RegWrite and ALUControl signals. Since the processor supports only ALU-type instructions, 
   ALUControl directly mirrors the operation field. */
   
   

module control_unit(
    input [3:0] operation,
    output reg regwrite,
    output reg [3:0] alucontrol
);

    always @(*) begin
        regwrite = 0;
        alucontrol = 0;
        
        case (operation)
            4'b0000: begin                      // AND operation
                        regwrite = 1;
                        alucontrol = 4'b0000;
                     end
            4'b0001: begin                      // OR operation
                        regwrite = 1;
                        alucontrol = 4'b0001;
                     end
            4'b0010: begin                      // ADD operation
                        regwrite = 1;
                        alucontrol = 4'b0010;
                     end
            4'b0011: begin                      // SUB operation
                        regwrite = 1;
                        alucontrol = 4'b0011;
                     end
            4'b0100: begin                      // XOR operation
                        regwrite = 1;
                        alucontrol = 4'b0100;
                     end
            4'b0101: begin                      // SLT operation
                        regwrite = 1;
                        alucontrol = 4'b0101;
                     end
            4'b0110: begin                      // NOR operation
                        regwrite = 1;
                        alucontrol = 4'b0110;
                     end
            4'b0111: begin                      // shift operation
                        regwrite = 1;
                        alucontrol = 4'b0111;
                     end
            4'b1000: begin                      // multiply operation
                        regwrite = 1;
                        alucontrol = 4'b1000;
                     end
            default: begin
                        regwrite = 0;
                        alucontrol = 4'b0000;
                    end
        endcase
    end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 02:20:11
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [18:0] R2,
    input [18:0] R3,
    input [3:0] ALUOp,
    output reg [18:0] R1,
    output reg Zero,
    output reg Carry,
    output reg Overflow
    );
    
always @(*)
    begin 
        case (ALUOp)
            4'b0000: R1 = R2 + R3;
            4'b0001: R1 = R2 - R3;
            4'b0010: R1 = R2 * R3;
            4'b0011: R1 = R2 / R3;
            4'b0100: R1 = R1 + 19'b0;
            4'b0101: R1 = R1 - 19'b0;
            4'b0110: R1 = R2 & R3;
            4'b0111: R1 = R2 | R3;
            4'b1000: R1 = R2 ^ R3;
            4'b1001: R1 = ~R2;
            default: R1 = 19'b0;
        endcase
  //zero flag
  Zero = (R1 == 19'b0) ? 1'b1 : 1'b0;
  //carry flag
  Carry = (ALUOp == 4'b0000 && (R2 + R3)>19'h7FFFF) ? 1'b1 : 1'b0;
  //overflow flag
  Overflow = (ALUOp == 4'b0000 && ((R2[18] == R3[18]) && (R1[18] != R2[18]))) ? 1'b1 : 1'b0;
  end 

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 02:49:19
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input clk,
    input [3:0] ReadReg1,
    input [3:0] ReadReg2,
    input [3:0] WriteReg,
    input [18:0] WriteData,
    input RegWrite,
    output [18:0] ReadData1,
    output [18:0] ReadData2
    );
    
    //Register file Array
    reg [18:0] registers [0:15];
     
     always @(posedge clk)
        begin 
            if (RegWrite)
                begin
                    registers[WriteReg]<= WriteData;
                end
            end
     assign ReadData1 = registers[ReadReg1];
     assign ReadData2 = registers[ReadReg2];
endmodule

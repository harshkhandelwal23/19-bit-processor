`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 15:51:49
// Design Name: 
// Module Name: IF_Stage
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


module IF_Stage(
    input clk,
    input reset,
    input [13:0] pc_in, //14-bit PC
    output reg [18:0] instruction_out,
    output reg [13:0] pc_out, //14-bit PC for next stage
    input [18:0] instruction_memory [0:16383] //instruction memory (16K x 19-bit)
    );
    
    always @(posedge clk or posedge reset)
        begin
             if (reset)
                begin
                pc_out <= 14'b0;
                instruction_out <= 19'b0;
                end 
             else 
                begin 
                instruction_out <= instruction_memory[pc_in];
                pc_out <= pc_in + 1;
                end
         end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 12:19:20
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,
    input reset,
    input [13:0]address,
    input [18:0] write_data,
    input mem_write_en,
    output [18:0] read_data
    );
    
    reg [18:0] memory [0:16383]; //16K x 19-bit data memory
    
    always @(posedge clk)
        begin 
            if (mem_write_en)
                memory[address]<=write_data;
        end
        
        assign read_data = memory[address];
endmodule

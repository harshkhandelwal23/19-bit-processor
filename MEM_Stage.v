`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 16:16:32
// Design Name: 
// Module Name: MEM_Stage
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


module MEM_Stage(
    input clk,
    input reset,
    input [4:0] opcode_in,
    input [18:0] alu_result_in,
    input [18:0] reg_data1_in,
    input [18:0] reg_data2_in,
    input [2:0] rd_in,
    inout [18:0] data_memory[0:16383],
    output reg [18:0] mem_data_out,
    output reg [2:0] rd_out
    );
    
    reg [18:0] memory_data;
    
    always @(posedge clk or posedge reset)
    begin
    if(reset)
    begin
    mem_data_out <= 19'b0;
    rd_out <= 3'b0;
    end
    else begin
    case (opcode_in)
    5'b01111: //LD
    memory_data <= data_memory[alu_result_in[13:0]];
    5'b10000: //ST
    data_memory[alu_result_in[13:0]] <= reg_data2_in;
    default:
    memory_data <= alu_result_in;
    endcase
    
    mem_data_out <= memory_data;
    rd_out <= rd_in;
    end
    end
endmodule

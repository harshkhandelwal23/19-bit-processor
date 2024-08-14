`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 15:57:46
// Design Name: 
// Module Name: ID_Stage
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


module ID_Stage(
    input clk,
    input reset,
    input [18:0] instruction_in,
    input [18:0] read_data1,
    input [18:0] read_data2,
    input [18:0] register file [0:7], //8 19-bit instruction
    output reg [4:0] opcode_out,
    output reg [18:0] reg_data1_out,
    output reg [18:0] reg_data2_out,
    output reg [2:0] rd_out,
    output reg [2:0] rs1_out,
    output reg [2:0] rs2_out
    );
    
    always @(posedge clk or posedge reset)
        begin
            if (reset)
            begin
                opcode_out <= 5'b0;
                reg_data1_out <= 19'b0;
                reg_data2_out <= 19'b0;
                rd_out <= 3'b0;
                rs1_out <= 3'b0;
                rs2_out  <= 3'b0;
            end
            else
            begin
                opcode_out <= instruction_in[18:14];
                rd_out <= instruction_in[13:11];
                rs1_out <= instruction_in[10:8];
                rs2_out <= instruction_in[7:5];
                reg_data1_out <= register_file[rs1_out];
                reg_data2_out  <= register_file[rs2_out];
            end
        end    
             
endmodule

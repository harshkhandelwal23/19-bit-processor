`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 16:53:31
// Design Name: 
// Module Name: WB_Stage
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


module WB_Stage(
    input clk,
    input reset,
    input [18:0] mem_data_in,
    input [2:0] rd_in,
    output reg [18:0] register_write_data,
    output reg [2:0] rd_out,
    output reg reg_write_en
    );
    always @(posedge clk or posedge reset)
    begin
    if (reset)
    begin
    register_write_data <= 19'b0;
    rd_out <= 3'b0;
    reg_write_en <= 1'b0;
    end
    else begin
    register_write_data <= mem_data_in;
    rd_out <= rd_in;
    reg_write_en <= 1'b1;
    end
    end
endmodule

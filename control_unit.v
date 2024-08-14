`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 10:56:43
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [18:0] instruction,
    input [18:0] reg1_data,
    input [18:0] reg2_data,
    input [18:0] pc,
    output reg [18:0] next_pc,
    output reg branch_taken,
    output reg [18:0] stack_pointer,
    output reg [18:0] stack [0:255] //stack memory for Call/ret
    );
     
     //decode the instruction
     wire [3:0] opcode = instruction [18:15]; //4bit opcode
     wire [14:0] address = instruction [14:0]; //15 bit address
     
     always @(*)
        begin 
            branch_taken = 1'b0;
            next_pc = pc + 19'd1;
            
            case(opcode) 
            4'b0000:
                begin //jmp addr
                next_pc = {4'b0,address};
                branch_taken = 1'b1;
                end
            4'b0010:
                begin //BEQ r1,r2,addr
                if (reg1_data == reg2_data)
                    begin
                        next_pc = {4'b0,address};
                        branch_taken = 1'b1;
                    end
                end
            4'b0011:
                begin //BNE r1,r2,addr
                    if (reg1_data == reg2_data)
                        begin
                            next_pc = {4'b0,address};
                            branch_taken = 1'b1;
                         end
                    end
            4'b0100:
                begin //call addr
                    stack[stack_pointer] = pc + 19'd1;
                    stack_pointer = stack_pointer - 1;
                    next_pc = {4'b0,address};
                    branch_taken = 1'b1;
                end
            4'b0101:
                begin //ret
                    stack_pointer = stack_pointer + 1;
                    next_pc = stack[satck_pointer];
                    branch_taken = 1'b1;
                end
                
                default:
                    begin 
                        branch_taken = 1'b0;
                    end
                endcase
             end         
endmodule

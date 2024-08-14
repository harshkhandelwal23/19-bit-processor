`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2024 10:22:01
// Design Name: 
// Module Name: SpecializedInstructions
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


module SpecializedInstructions(
    input clk,
    input [18:0] R1,
    input [18:0] R2,
    input [3:0] op_code,
    output reg [18:0] result,
    output reg done
    );
    
    //Memory module interface
    reg [18:0] memory [0:524287];
    
    //FFT Algorithm 
    function [18:0] fft(
    input [18:0] data
    );
        begin 
                fft = data + 19'b1; //Dummy FFT operation
        end
    endfunction
    
    //Encryption Algorithm
    function [18:0] encrypt(
    input [18:0] data
    );
        begin 
            encrypt = data ^ 19'b1010101010101010101; //XOR with A pattern for Sample encryption
        end
     endfunction
     
      //Decryption Algorithm
        function [18:0] decrypt(
        input [18:0] data
        );
            begin 
                decrypt = data ^ 19'b1010101010101010101; //Xor with that same pattern to decrypt
            end
         endfunction
     
     always @(posedge clk)
        begin
            done = 1'b0; //default done flag to 0
                case (op_code)
                4'b1100: 
                    begin //fft operation
                    result = fft(memory[R2]);
                    memory[R1] = result;
                    done = 1'b1;
                    end
                4'b1101:
                    begin //Encryption operation
                    result = encrypt(memory[R2]);
                    memory[R1] = result;
                    done = 1'b1;
                    end
                4'b1110:
                    begin //decryption operation
                    result = decrypt(memory[R2]);
                    memory[R1] = result;
                    done = 1'b1;
                    end
                    default:
                        begin
                            result = 19'b0;
                        end
             endcase
     end
                   
endmodule

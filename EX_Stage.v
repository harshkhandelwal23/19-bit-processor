module EX_Stage(
    input clk,
    input reset,
    input [4:0] opcode_in,
    input [18:0] reg_data1_in,
    input [18:9] reg_data2_in,
    input [2:0] rd_in,
    output reg [18:0] alu_result_out,
    output reg [2:0] rd_out
);

    wire [18:0] alu_result;
    wire zero_flag;
    wire overflow_flag;

    ALU alu(
        .opcode(opcode_in),
        .operand1(reg_data1_in),
        .operand2(reg_data2_in),
        .result(alu_result),
        .zero(zero_flag),
        .overflow(overflow_flag)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_result_out <= 19'b0;
            rd_out <= 3'b0;
        end else begin
            alu_result_out <= alu_result;
            rd_out <= rd_in;
        end
    end

endmodule

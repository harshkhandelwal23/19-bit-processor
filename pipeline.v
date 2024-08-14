module pipeline (
    input clk, 
    input reset, 
    output [18:0] pc_out, 
    output [18:0] alu_result_out
);
    // Intermediate signals
    wire [13:0] pc_if;
    wire [18:0] instruction_if;
    wire [13:0] next_pc_if;

    wire [18:0] instruction_id;
    wire [18:0] reg_data1_id, reg_data2_id;
    wire [4:0] opcode_id;
    wire [2:0] rd_id, rs1_id, rs2_id;

    wire [18:0] alu_result_ex;
    wire [2:0] rd_ex;

    wire [18:0] mem_data_mem;
    wire [2:0] rd_mem;

    wire [18:0] register_write_data_wb;
    wire [2:0] rd_wb;
    wire reg_write_en_wb;

    // Instruction Memory (for simplicity, it's just an example array)
    reg [18:0] instruction_memory [0:16383]; 

    // Data Memory (for simplicity, it's just an example array)
    reg [18:0] data_memory [0:16383]; 

    // Register File
    reg [18:0] register_file [0:7];

    // Instruction Fetch Stage
    IF_Stage IF (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_if),
        .instruction_out(instruction_if),
        .pc_out(next_pc_if),
        .instruction_memory(instruction_memory)
    );

    // Instruction Decode Stage
    ID_Stage ID (
        .clk(clk),
        .reset(reset),
        .instruction_in(instruction_if),
        .read_data1(reg_data1_id),
        .read_data2(reg_data2_id),
        .register_file(register_file),
        .opcode_out(opcode_id),
        .reg_data1_out(reg_data1_id),
        .reg_data2_out(reg_data2_id),
        .rd_out(rd_id),
        .rs1_out(rs1_id),
        .rs2_out(rs2_id)
    );

    // Execution Stage
    EX_Stage EX (
        .clk(clk),
        .reset(reset),
        .opcode_in(opcode_id),
        .reg_data1_in(reg_data1_id),
        .reg_data2_in(reg_data2_id),
        .rd_in(rd_id),
        .alu_result_out(alu_result_ex),
        .rd_out(rd_ex)
    );

    // Memory Access Stage
    MEM_Stage MEM (
        .clk(clk),
        .reset(reset),
        .opcode_in(opcode_id),
        .alu_result_in(alu_result_ex),
        .reg_data2_in(reg_data2_id),
        .rd_in(rd_ex),
        .data_memory(data_memory),
        .mem_data_out(mem_data_mem),
        .rd_out(rd_mem)
    );

    // Write Back Stage
    WB_Stage WB (
        .clk(clk),
        .reset(reset),
        .mem_data_in(mem_data_mem),
        .rd_in(rd_mem),
        .register_write_data(register_write_data_wb),
        .rd_out(rd_wb),
        .reg_write_en(reg_write_en_wb)
    );

    // Program Counter Update (PC logic)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_if <= 14'b0;
        end else begin
            pc_if <= next_pc_if;
        end
    end

    // Register Write-Back Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the register file
            integer i;
            for (i = 0; i < 8; i = i + 1) begin
                register_file[i] <= 19'b0;
            end
        end else if (reg_write_en_wb) begin
            register_file[rd_wb] <= register_write_data_wb;
        end
    end

    // Outputs
    assign pc_out = pc_if;
    assign alu_result_out = alu_result_ex;
endmodule
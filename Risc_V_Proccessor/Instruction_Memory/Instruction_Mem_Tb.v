`timescale 1ns/1ps

module instruction_mem_tb;

reg [31:0] pc;
wire [31:0] instruction;
reg [31:0] e_instruction;

instruction_mem uup (.pc(pc), .instruction(instruction));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, instruction_mem_tb);

// Test second instruction
pc = 32'd0; e_instruction = 32'h00500113; #10;
if (e_instruction == instruction)
    $display("Pass");
else
    $display("Fail! Result/Expected - Instruction:%0d/%0d", instruction, e_instruction);

// Test Second Instruction
pc = 32'd4; e_instruction = 32'h00A00193; #10;
if (e_instruction == instruction)
    $display("Pass");
else
    $display("Fail! Result/Expected - Instruction:%0d/%0d", instruction, e_instruction);

// Test third instruction
pc = 32'd8; e_instruction = 32'h002081B3; #10;
if (e_instruction == instruction)
    $display("Pass");
else
    $display("Fail! Result/Expected - Instruction:%0d/%0d", instruction, e_instruction);

// Test Jump (jump to 8th line)
pc = 32'd28; e_instruction = 32'h00419433; #10;
if (e_instruction == instruction)
    $display("Pass");
else
    $display("Fail! Result/Expected - Instruction:%0d/%0d", instruction, e_instruction);
    $finish;
end
endmodule

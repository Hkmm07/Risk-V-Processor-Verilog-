`timescale 1ns/1ps

module immediate_gen_tb;

reg [31:0] instruction;
reg [31:0] e_immediate;
wire [31:0] immediate;

immediate_gen uup (.instruction(instruction), .immediate(immediate));

// Opcodes 
localparam ADDI = 7'b0010011;
localparam LW = 7'b0000011;
localparam SW = 7'b0100011;
localparam BEQ = 7'b1100011;
localparam JAL = 7'b1101111;

// funct3
localparam F3_ADD = 3'b000;
localparam F3_MEM = 3'b010;

// Registers
localparam X0 = 5'b00000;
localparam X1 = 5'b00001;
localparam X2 = 5'b00010;
localparam X3 = 5'b00011;
localparam X4 = 5'b00100;
localparam X5 = 5'b00101;

// Imediates
localparam POSITIVE_5 = 12'h005;
localparam NEGATIVE_5 = 12'hFFB;
localparam MAX_POSITIVE = 12'h7FF;
localparam MAX_NEGATIVE = 12'h800;
localparam POSITIVE_8 = 12'h008;
localparam NEGATIVE_4 = 12'hFFC;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, immediate_gen_tb);

//ADDI Positive
instruction = {POSITIVE_5, X1, F3_ADD, X2, ADDI}; e_immediate = {32'h00000005}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);
end
endmodule

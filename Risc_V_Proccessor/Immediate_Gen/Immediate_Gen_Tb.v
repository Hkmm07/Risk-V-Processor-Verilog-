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
localparam NEGATIVE_8 = 12'hFF8;
localparam POSITIVE_4 = 12'h004;
localparam NEGATIVE_4 = 12'hFFC;
localparam POSITIVE_4B = 13'h004;
localparam NEGATIVE_4B = 13'h1FFC;
localparam POSITIVE_8J = 21'h00008;
localparam NEGATIVE_8J = 21'h1FFFF8;

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, immediate_gen_tb);

//ADDI Positive 5 (I Type)
instruction = {POSITIVE_5, X1, F3_ADD, X2, ADDI}; e_immediate = {32'h00000005}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//ADDI Negative 5 (I Type)
instruction = {NEGATIVE_5, X1, F3_ADD, X2, ADDI}; e_immediate = {32'hFFFFFFFB}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//ADDI Positive MAX (I Type)
instruction = {MAX_POSITIVE, X1, F3_ADD, X2, ADDI}; e_immediate = {32'h000007FF}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//ADDI Negative Max (I Type)
instruction = {MAX_NEGATIVE, X1, F3_ADD, X2, ADDI}; e_immediate = {32'hFFFFF800}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//LW Positive 8 (I Type)
instruction = {POSITIVE_8, X1, F3_MEM, X2, LW}; e_immediate = {32'h00000008}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//LW Negative 4 (I Type)
instruction = {NEGATIVE_4, X1, F3_MEM, X2, LW}; e_immediate = {32'hFFFFFFFC}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//SW Positive 8 (S Type)
instruction = {POSITIVE_8[11:5], X5, X1, F3_MEM, POSITIVE_8[4:0], SW}; e_immediate = {32'h00000008}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//SW Negative 4 (S Type)
instruction = {NEGATIVE_4[11:5], X5, X1, F3_MEM, NEGATIVE_4[4:0], SW}; e_immediate = {32'hFFFFFFFC}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//BEQ Positive 4 (B Type)
instruction = {POSITIVE_4B[12], POSITIVE_4B[10:5], X2, X1, F3_ADD, POSITIVE_4B[4:1], POSITIVE_4B[11], BEQ}; e_immediate = {32'h00000004}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

//BEQ Negative 4 (B Type)
instruction = {NEGATIVE_4B[12], NEGATIVE_4B[10:5], X2, X1, F3_ADD, NEGATIVE_4B[4:1], NEGATIVE_4B[11], BEQ}; e_immediate = {32'hFFFFFFFC}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

// JAL Positive 8 (J type)
instruction = {POSITIVE_8J[20], POSITIVE_8J[10:1], POSITIVE_8J[11], POSITIVE_8J[19:12], X1, JAL}; e_immediate = {32'h00000008}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);

// JAL Negative 8 (J type)
instruction = {NEGATIVE_8J[20], NEGATIVE_8J[10:1], NEGATIVE_8J[11], NEGATIVE_8J[19:12], X1, JAL}; e_immediate = {32'hFFFFFFF8}; #10;
if (immediate == e_immediate)
    $display("Pass");
else
    $display("Fail! Result/Expected - Immediate:%0d/%0d", immediate, e_immediate);
end
endmodule
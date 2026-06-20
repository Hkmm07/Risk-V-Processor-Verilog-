`timescale 1ns/1ps

module control_unit_tb;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;
reg [2:0] e_sel;
reg e_immediate, e_branch, e_mem_read, e_mem_write, e_reg_write, e_jal;
wire [2:0] sel;
wire alu_immediate, branch, mem_read, mem_write, reg_write, jal;

control_unit uup (.opcode(opcode), .funct3(funct3), .funct7(funct7), .alu_immediate(alu_immediate), 
.branch(branch), .mem_read(mem_read), .mem_write(mem_write), .reg_write(reg_write), .jal(jal));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, control_unit_tb);

//ADD
opcode = 7'b0110011; funct3 = 3'b000; funct7 = 0; e_sel = 3'b000; e_immediate = 0; e_branch = 0;
e_mem_read = 0; e_mem_write = 0; e_reg_write = 1; e_jal = 0; #10;
if ((sel == e_sel) & (alu_immediate == e_immediate) & (branch == e_branch) & (mem_read == e_mem_read)
 & (mem_write == e_mem_write) & (reg_write == e_reg_write) & (jal == e_jal))
    $display("Pass");
else
    $display("Fail! Result/Expected - Sel:%0d/%0d - Immediate:%0d/%0d - Branch:%0d/%0d - Mem_Read:%0d/%0d
     - Mem_Write:%0d/%0d - Reg_Write:%0d/%0d - Jal:%0d/%0d",
    sel, e_sel, alu_immediate, e_immediate, branch, e_branch, mem_read, e_mem_read, mem_write, e_mem_write,
     reg_write, e_reg_write, jal, e_jal);

//SUB
opcode = 7'b0110011; funct3 = 3'b000; funct7 = 1; e_sel = 3'b001; e_immediate = 0; e_branch = 0;
e_mem_read = 0; e_mem_write = 0; e_reg_write = 1; e_jal = 0; #10;
if ((sel == e_sel) & (alu_immediate == e_immediate) & (branch == e_branch) & (mem_read == e_mem_read)
 & (mem_write == e_mem_write) & (reg_write == e_reg_write) & (jal == e_jal))
    $display("Pass");
else
    $display("Fail! Result/Expected - Sel:%0d/%0d - Immediate:%0d/%0d - Branch:%0d/%0d - Mem_Read:%0d/%0d
     - Mem_Write:%0d/%0d - Reg_Write:%0d/%0d - Jal:%0d/%0d",
    sel, e_sel, alu_immediate, e_immediate, branch, e_branch, mem_read, e_mem_read, mem_write, e_mem_write,
     reg_write, e_reg_write, jal, e_jal);

//AND
opcode = 7'b0110011; funct3 = 3'b111; funct7 = 0; e_sel = 3'b010; e_immediate = 0; e_branch = 0;
e_mem_read = 0; e_mem_write = 0; e_reg_write = 1; e_jal = 0; #10;
if ((sel == e_sel) & (alu_immediate == e_immediate) & (branch == e_branch) & (mem_read == e_mem_read)
 & (mem_write == e_mem_write) & (reg_write == e_reg_write) & (jal == e_jal))
    $display("Pass");
else
    $display("Fail! Result/Expected - Sel:%0d/%0d - Immediate:%0d/%0d - Branch:%0d/%0d - Mem_Read:%0d/%0d
     - Mem_Write:%0d/%0d - Reg_Write:%0d/%0d - Jal:%0d/%0d",
    sel, e_sel, alu_immediate, e_immediate, branch, e_branch, mem_read, e_mem_read, mem_write, e_mem_write,
     reg_write, e_reg_write, jal, e_jal);

//XOR
opcode = 7'b0110011; funct3 = 3'b100; funct7 = 0; e_sel = 3'b011; e_immediate = 0; e_branch = 0;
e_mem_read = 0; e_mem_write = 0; e_reg_write = 1; e_jal = 0; #10;
if ((sel == e_sel) & (alu_immediate == e_immediate) & (branch == e_branch) & (mem_read == e_mem_read)
 & (mem_write == e_mem_write) & (reg_write == e_reg_write) & (jal == e_jal))
    $display("Pass");
else
    $display("Fail! Result/Expected - Sel:%0d/%0d - Immediate:%0d/%0d - Branch:%0d/%0d - Mem_Read:%0d/%0d
     - Mem_Write:%0d/%0d - Reg_Write:%0d/%0d - Jal:%0d/%0d",
    sel, e_sel, alu_immediate, e_immediate, branch, e_branch, mem_read, e_mem_read, mem_write, e_mem_write,
     reg_write, e_reg_write, jal, e_jal);
    
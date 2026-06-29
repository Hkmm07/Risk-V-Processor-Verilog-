`timescale 1ns/1ps

module top_module(
    input clk, reset);

wire alu_immediate, branch, mem_read, mem_write, reg_write, jal;
wire [6:0] opcode, funct7;
wire [2:0] sel, funct3;

//register file
wire [4:0] rs1, rs2, rd;
wire [31:0] write_data, read_data1, read_data2;

//instruction memory
wire [31:0] instruction;
// Mentioned Later: [31:0] pc

//immediate gen
wire [31:0] immediate;
//Already mentioned: [31:0] instructions

// programme counter
wire [31:0] pc, pc_next;
// Already mentioned: reset, clk


control_unit control_unit (
    .alu_immediate(alu_immediate),
    .branch(branch),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .jal(jal),
    .sel(sel),
    .funct7(funct7),
    .funct3(funct3),
    .opcode(opcode));

register_file register_file (
    .reg_write(reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2));

instruction_mem instruction_mem(
    .pc(pc),
    .instructions(instructions));

// following risc v unprivileged isa rv32i 2.1.4.2 integer register-register instructions diagram
assign opcode = instruction[6:0];
assign funct7 = instruction[31:25];
assign funct3 = instructions[14:12];
assign rs1 = instructions[19:15];
assign rs2 = instructions[24:20];
assign rd = instructions[11:7];

immediate_gen immediate_gen(
    .immediate(immediate),
    .instruction(instructions));

p_count pc(
    .pc(pc),
    .pc_next(pc_next),
    .reset(reset),
    .clk(clk));


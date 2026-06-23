`timescale 1ns/1ps

module immediate_gen(
    input [31:0] instruction,
    output reg [31:0] immediate
);

wire [6:0] opcode;
assign opcode = instruction[6:0];               //opcode used to distinguish between instruction type

localparam ADDI_OP = 7'b0010011;                //Lowkey remembered localparams existed gonna use these now as it makes the code easier to read
localparam LW_OP = 7'b0000011;
localparam SW_OP = 7'b0100011;
localparam BEQ_OP = 7'b1100011;
localparam JAL_OP = 7'b1101111;

always@(*) begin

case (opcode)
ADDI_OP: immediate = {{20{opcode[31]}}, opcode};
LW_OP: immediate = {{20{opcode[31]}}, opcode};
end
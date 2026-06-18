`timescale 1ns/1ps

module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] select,
    output reg [31:0] result,
    output zero,                                            // It seems to be refered to as "zero flag" in most examples
    output reg negative,
    output reg carry,
    output reg overflow
);

    reg [32:0] temporary;

always@(*) begin
    carry = 1'b0;                                           // Carry by default set to 0
    overflow = 1'b0;                                        // Overflow by default set to 0

    case(select)
    3'b000: begin                                           // Add
        temporary = {1'b0, a} + {1'b0, b};
        result = temporary[31:0];
        carry = temporary[32];
        overflow = (a[31] == b [31]) && (result[31] != a[31]);
    end
    3'b001: begin                                           // Sub
        temporary = {1'b0, a} - {1'b0, b};
        result = temporary[31:0];
        carry = temporary[32];
        overflow = (a[31] != b[31]) && (result[31] != a[31]);
    end
    3'b010: result = a & b;                                 // And
    3'b011: result = a ^ b;                                 // Or
    3'b100: result = a | b;                                 // Xor
    3'b101: result = a << b[4:0];                           // SLL    (a to the power b)
    3'b110: result = ($signed(a)) < ($signed(b));           // SLT    $signed used so that negative numbers dont result in errors
    default: result = 32'b0;
    endcase

    negative = result[31];
end

assign zero = (result == 32'b0);                            // Zero Flag
endmodule
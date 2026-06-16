`timescale 1ns/1ps

module alu(
    input [31:0] a,
    input [31:0] b,
    output [31:0] y
);

// INTENTIONAL BUG: Adding 1 extra
assign y = a + b + 32'd1;

endmodule
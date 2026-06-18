`timescale 1ns/1ps

module alu_tb;

reg [31:0] a, b;
reg [2:0] sel;
reg [31:0] e_result;
wire [31:0] result;
reg e_zero, e_negative, e_carry, e_overflow;
wire zero, neg, carry, overflow;


alu uut (.a(a), .b(b), .select(sel), .result(result), .zero(zero), .negative(neg), .carry(carry), .overflow(overflow));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);

    // Add tests
    // 5 + 10 = 15
a = 5; b = 10; e_result = 15; sel = 3'b000; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // 7 + (-7) = 0
a = 100; b = 321; e_result = 421; sel = 3'b000; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // 0 + 0 = 0
a = 0; b = 0; e_result = 0; sel = 3'b000; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // Sub tests
    // 15 - 10 = 5
a = 15; b = 10; e_result = 5; sel = 3'b001; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // 7 - (-7) = 0
a = 7; b = -7; e_result = 0; sel = 3'b001; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // 0 - 0 = 0
a = 0; b = 0; e_result = 0; sel = 3'b001; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // And tests
    // 010 & 110 = 010
a = 32'b010; b = 32'b110; e_result = 32'b010; sel = 3'b010; #10;
if (result == e_result)
    $display("Pass");
else
    $display("Fail: %0d (expected %0d)", result, e_result);

    // 
$finish;
end
endmodule


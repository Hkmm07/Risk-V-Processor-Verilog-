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
a = 5; b = 10; e_result = 15; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0; sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 7 + (-7) = 0
a = 7; b = -7; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 1; e_overflow = 0;  sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 2147483647 + 1 = -2147483648 (the overflow should flag the false negative)
a = 32'h7FFFFFFF; b = 32'd1; e_result = 32'h80000000; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 1; sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    //-2147483648 + (-2147483648) = 0 (overflow should flag, it appears as zero as -4294967296 is a 33 bit signed integer)
a = 32'h80000000; b = 32'h80000000; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 1; e_overflow = 1;  sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    //4294967295 + 4294967295 = 4294967294 (This is another instance of it carrying to the 33 bit, carry should flag)
a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; e_result = 32'hFFFFFFFE; e_zero = 0; e_negative = 1; e_carry = 1; e_overflow = 0;  sel = 3'b000; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // Sub tests
    // 15 - 10 = 5
a = 15; b = 10; e_result = 5; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 7 - 7 = 0
a = 7; b = 7; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 5 - 10 = -5
a = 5; b = 10; e_result = -5; e_zero = 0; e_negative = 1; e_carry = 1; e_overflow = 0;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 2147483648 - 1 = 2147483647
a = 32'h80000000; b = 1; e_result = 32'h7FFFFFFF; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 1;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 2147483647 - 2147483648 = -1
a = 32'h7FFFFFFF; b = 32'h80000000; e_result = 32'hFFFFFFFF; e_zero = 0; e_negative = 1; e_carry = 1; e_overflow = 1;  sel = 3'b001; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);


    // And tests
    // (1111000011110000.....) & (0000111100001111.....) = 0 (F in hexidecimal is 1111 in binary)
a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b010; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // (11111111.....) & (11111111.....) = (11111111.....) (Negative flags as 32'hFFFFFFFF is -1 when its signed)
a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; e_result = 32'hFFFFFFFF; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 0;  sel = 3'b010; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // All hex letters that are & with 0 become 0, if they are & with F (1111) they stay the same (also quite proud of the "A BAD CAFE" idea) 
a = 32'hABADCAFE; b = 32'hF000FFFF; e_result = 32'hA000CAFE; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 0;  sel = 3'b010; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // OR Tests
    // (1111000011110000.....) | (0000111100001111.....) = (11111111.....) (32'hFFFFFFFF is signed so negative flag)
a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; e_result = 32'hFFFFFFFF; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 0;  sel = 3'b011; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow); 
    
    // 0 | 0 = 0
a = 0; b = 0; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b011; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 0 | 1 = 1
a = 0; b = 1; e_result = 1; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b011; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);
    
    // XOR Tests
    // Identical binary values xored together cancel out
a = 32'hACEFACED; b = 32'hACEFACED; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b100; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // (11111111....) ^ 0 = (11111111....)
a = 32'hFFFFFFFF; b = 0; e_result = 32'hFFFFFFFF; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 0;  sel = 3'b100; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // SLL Tests (In these comments ^ means to the power)
    // (Personal reminder SLL functions as a(2^b) not a^b)
    // 1 << 4 = 16 ( 1(2^4)=16 )
a = 1; b = 4; e_result = 16; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b101; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);
    
    // 1 << 0 = 1 ( 1(2^0)=1 )
a = 1; b = 0; e_result = 1; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b101; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 1 << 31 = 2147483648 ( 1(2^31)=2147483648 )
a = 1; b = 31; e_result = 32'h80000000; e_zero = 0; e_negative = 1; e_carry = 0; e_overflow = 0;  sel = 3'b101; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 32'h80000000 << 1 = 0 (in this instance rather than going to the 33rd bit, it is limited to 32 bits, hence the 33rd bit "falls of the end")
a = 32'h80000000; b = 1; e_result = 0; e_zero = 1; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b101; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);

    // 1 << 64 = 1 ( 1(2^64)=1)
a = 1; b = 64; e_result = 1; e_zero = 0; e_negative = 0; e_carry = 0; e_overflow = 0;  sel = 3'b101; #10;
if ((result == e_result) & (zero == e_zero) & (neg == e_negative) & (carry == e_carry) & (overflow == e_overflow))
    $display("Pass");
else
    $display("Fail! Result/Expected - Result:%0d/%0d - Zero:%0d/%0d - Neg:%0d/%0d - Carry:%0d/%0d - Overflow:%0d/%0d",
    result, e_result, zero, e_zero, neg, e_negative, carry, e_carry, overflow, e_overflow);
$finish;
end
endmodule


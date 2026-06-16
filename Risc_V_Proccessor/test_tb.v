`timescale 1ns/1ps

module alu_tb;

reg [31:0] a, b;
reg [31:0] expected_y;
wire [31:0] y;

alu uut (.a(a), .b(b), .y(y));

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, alu_tb);

    // Test 1: 10 + 5 = 15
    a = 32'd10; b = 32'd5; expected_y = 32'd15; #10;
    if (y == expected_y)
        $display("✓ PASS: %0d + %0d = %0d", a, b, y);
    else
        $display("✗ FAIL: %0d + %0d = %0d (expected %0d)", a, b, y, expected_y);

    // Test 2: 100 + 200 = 300
    a = 32'd100; b = 32'd200; expected_y = 32'd300; #10;
    if (y == expected_y)
        $display("✓ PASS: %0d + %0d = %0d", a, b, y);
    else
        $display("✗ FAIL: %0d + %0d = %0d (expected %0d)", a, b, y, expected_y);

    // Test 3: 0 + 0 = 0
    a = 32'd0; b = 32'd0; expected_y = 32'd0; #10;
    if (y == expected_y)
        $display("✓ PASS: %0d + %0d = %0d", a, b, y);
    else
        $display("✗ FAIL: %0d + %0d = %0d (expected %0d)", a, b, y, expected_y);

    $finish;
end

endmodule
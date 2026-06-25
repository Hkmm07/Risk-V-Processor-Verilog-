`timescale 1ns/1ps

module p_count(
    input clk, reset,
    input [31:0] pc_next,
    output reg [31:0] pc
);

always@(posedge clk) begin
    if (reset) pc <= 32'b0;
    else pc <= pc_next;
end
endmodule
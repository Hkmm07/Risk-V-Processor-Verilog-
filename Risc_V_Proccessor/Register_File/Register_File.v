`timescale 1ns/1ps

module register_file(
    input clk,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data,
    input reg_write,
    output reg [31:0] read_data1, read_data2
);

reg [31:0] reg_array [31:0];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        reg_array[i] = 32'd0;
end

always@(*) begin
    read_data1 = (rs1 == 5'd0) ? 32'd0 : reg_array[rs1];
    read_data2 = (rs2 == 5'd0) ? 32'd0 : reg_array[rs2];
end

always@(posedge clk) begin
    if ((reg_write == 1) & (rd != 5'd0 )) begin     //Rd cant be 0 as that is the location of x0 which should always remain 0, hence dont write to it
        reg_array[rd] <= write_data;
    end
end
endmodule
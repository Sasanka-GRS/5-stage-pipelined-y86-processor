`timescale 1ns / 1ps
module ADD(a,b,y,carry_bit);
input [63:0] a;
input [63:0] b;
output [63:0] y;
output carry_bit;

wire init;
assign init = 0;
wire [14:0] c;

Adder_4 one (.a(a[3:0]),.b(b[3:0]),.c_in(init),.sum(y[3:0]),.c_out(c[0])); 
Adder_4 two (.a(a[7:4]),.b(b[7:4]),.c_in(c[0]),.sum(y[7:4]),.c_out(c[1]));
Adder_4 three (.a(a[11:8]),.b(b[11:8]),.c_in(c[1]),.sum(y[11:8]),.c_out(c[2]));
Adder_4 four (.a(a[15:12]),.b(b[15:12]),.c_in(c[2]),.sum(y[15:12]),.c_out(c[3]));
Adder_4 five (.a(a[19:16]),.b(b[19:16]),.c_in(c[3]),.sum(y[19:16]),.c_out(c[4]));
Adder_4 six (.a(a[23:20]),.b(b[23:20]),.c_in(c[4]),.sum(y[23:20]),.c_out(c[5]));
Adder_4 seven (.a(a[27:24]),.b(b[27:24]),.c_in(c[5]),.sum(y[27:24]),.c_out(c[6]));
Adder_4 eight (.a(a[31:28]),.b(b[31:28]),.c_in(c[6]),.sum(y[31:28]),.c_out(c[7]));
Adder_4 nine (.a(a[35:32]),.b(b[35:32]),.c_in(c[7]),.sum(y[35:32]),.c_out(c[8])); 
Adder_4 ten (.a(a[39:36]),.b(b[39:36]),.c_in(c[8]),.sum(y[39:36]),.c_out(c[9]));
Adder_4 eleven (.a(a[43:40]),.b(b[43:40]),.c_in(c[9]),.sum(y[43:40]),.c_out(c[10]));
Adder_4 twelve (.a(a[47:44]),.b(b[47:44]),.c_in(c[10]),.sum(y[47:44]),.c_out(c[11]));
Adder_4 thirteen (.a(a[51:48]),.b(b[51:48]),.c_in(c[11]),.sum(y[51:48]),.c_out(c[12]));
Adder_4 fourteen (.a(a[55:52]),.b(b[55:52]),.c_in(c[12]),.sum(y[55:52]),.c_out(c[13]));
Adder_4 fifteen (.a(a[59:56]),.b(b[59:56]),.c_in(c[13]),.sum(y[59:56]),.c_out(c[14]));
Adder_4 sixteen (.a(a[63:60]),.b(b[63:60]),.c_in(c[14]),.sum(y[63:60]),.c_out(carry_bit));

endmodule
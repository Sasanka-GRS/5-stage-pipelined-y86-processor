module Adder_4 (a,b,c_in,sum,c_out);
input [3:0] a,b;
input c_in;
output [3:0] sum;
output c_out;

wire [3:0] c;

Adder_2 zero (.a(a[0]),.b(b[0]),.c_in(c_in),.sum(sum[0]),.c_out(c[0]));
Adder_2 one (.a(a[1]),.b(b[1]),.c_in(c[0]),.sum(sum[1]),.c_out(c[1]));
Adder_2 two (.a(a[2]),.b(b[2]),.c_in(c[1]),.sum(sum[2]),.c_out(c[2]));
Adder_2 three (.a(a[3]),.b(b[3]),.c_in(c[2]),.sum(sum[3]),.c_out(c_out)); 

endmodule
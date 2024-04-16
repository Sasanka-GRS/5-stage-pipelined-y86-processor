`timescale 1ns / 1ps
module SUB(a,b,y,carry_bit);
input [63:0] a;
input [63:0] b;
output [63:0] y;
output carry_bit;

wire [63:0] b1;
 
Compliment_2 negative (.a(b),.y(b1));

ADD for_subtract (.a(a),.b(b1),.y(y),.carry_bit(carry_bit));

endmodule
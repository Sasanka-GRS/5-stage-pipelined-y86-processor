module Adder_2 (a,b,c_in,sum,c_out);
input a,b,c_in;
output sum,c_out;

wire ab,bc,ac;
and(ab,a,b);
and(ac,a,c_in);
and(bc,b,c_in);

or(c_out,ab,bc,ac);
xor(sum,a,b,c_in);

endmodule
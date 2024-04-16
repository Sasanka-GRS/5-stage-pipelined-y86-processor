module Compliment_2 (a,y);
input [63:0] a;
output [63:0] y;

wire [63:0] temp;
wire [63:0] step1;
wire [63:0] temp1;
wire carry_bit;
assign temp = 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111;
assign temp1 = 64'b1;

XOR step_one (.a(a),.b(temp),.y(step1));
ADD temporary (.a(step1), .b(temp1) , .y(y), .carry_bit(carry_bit));

endmodule
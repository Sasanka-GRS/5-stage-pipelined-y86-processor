`timescale 1ns / 1ps
module ALU_test;
	reg [63:0] a;
	reg [63:0] b;
    reg [1:0] control;
	reg signed [63:0] a1;
	reg signed [63:0] b1;

	wire signed [63:0] y;
    wire carry_bit;

	ALU uut (
		.x(a), 
		.y(b),
        .control(control), 
		.res(y),
        .carry_bit(carry_bit)
	);

	initial begin
		$dumpfile("ALU_test.vcd");
     	$dumpvars(0,ALU_test);
		
		//general case
		a = 20; assign a1 = a;
		b = 10; assign b1 = b;
        control = 3;

		#100;

		//Testing the same cases with different controls (1)
		#100 control = 0;
		//Testing the same cases with different controls (2)
		#100 control = 2;
		//Testing the same cases with different controls (3)
		#100 control = 3;
		//Testing for other random cases
		#100 control = 1; a=64'b1111_1111_1000_1111_1101_1110_1111_1111;assign a1 = a; b=64'b0111_1111_1111_1101_1111_1110_1111_1011;assign b1 = b;
        //Testing for other random cases
        #100 b=5;assign b1 = b; control = 3;
		//Testing for other random cases
		#100 a=64'b1111_1111_1000_1111_1101_1110_1111_1111;assign a1 = a; b=64'b0111_1111_1111_1101_1111_1110_1111_1011;assign b1 = b; control = 0;
		//general case
		#100 a=17;assign a1 = a; b=1;assign b1 = b; control = 3;
		//erroraneous case (error handling) when control is none of 0,1,2 or 3, it automatically takes the modulus with 4 (%4) and does operation normally
		#100 a=16;assign a1 = a; b=15;assign b1 = b; control = -1;
		//erroraneous case (error handling) when control is none of 0,1,2 or 3, it automatically takes the modulus with 4 (%4) and does operation normally
		#100 a=-4;assign a1 = a; b=-20;assign b1 = b; control = -3;
        #100;      

	end
		initial begin 
		$monitor("a = %b (decimal-%d) b = %b (decimal-%d) sum = %b (decimal-%d)\n carry_bit = %b control = %b (decimal-%d)\n",a,a1,b,b1,y,y,carry_bit,control,control);
		end
      
endmodule
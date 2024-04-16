`timescale 1ns / 1ps
module ALU(x,y,control,res,carry_bit, mem1, mem2,cc, ZF, SF, OF);
input [63:0] x;
input [63:0] y;
input [1:0] control;
input mem1;
output reg [63:0] res;
output carry_bit;
output reg mem2,ZF,SF,OF;
output reg [2:0] cc;

wire [63:0] andop,xorop,addop,subop;

AND andxy (x,y,andop);
XOR xorxy (x,y,xorop);
ADD addition (x,y,addop,carry_bit);
SUB subtraction (x,y,subop,carry_bit);

always @ (posedge mem1)
begin
    mem2 = 0;
    case (control)
        0: res = x+y;
        1: res = x-y;
        2: res = x&y;
        3: res = x^y;
        default: res = 0;
    endcase
    if(res == 0)
    begin
        ZF = 1;
        cc = 4;
    end
    else if((x>0 && y>0 && control == 0 && res<0)||(x>0 && y<0 && control == 1 && res<0))
    begin
        SF = 1;
        OF = 1;
        cc = 3;
    end
    else if(x<0 && y<0 && control == 0 && res>0)
    begin
        OF = 1;
        cc = 1;
    end
    else if(res<0)
    begin
        SF = 1;
        cc = 2;
    end
    else
    begin
        SF = 0;
        ZF = 0;
        OF = 0;
        cc = 0;
    end
    mem2 = 1;
end

endmodule
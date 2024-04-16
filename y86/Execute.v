`timescale 1ns / 1ps
module execute (icode, ifun, valC, valA, valB, valE, cnd, exec, mem, cc);

    input [3:0] icode, ifun;
    input [63:0] valC, valA, valB;
    input start, exec;
    output [63:0] valE;
    output reg mem, cnd;
    output [2:0] cc;

    reg [1:0] ALU_select;
    reg [63:0] ALU_A;
    reg [63:0] ALU_B;
    reg mem1;

    wire set_cc,mem2,ZF,SF,OF;

    ALU a(ALU_A,ALU_B,ALU_select,valE,overflow,mem1,mem2,cc,ZF,SF,OF);
    
    always @ (posedge mem2)
    begin
        mem = 0;
        if(icode == 2 && ifun == 0)
            cnd = 1;
        else if(icode == 2 && ifun == 1)
            cnd = (SF^OF)|ZF;
        else if(icode == 2 && ifun == 2)
            cnd = SF^OF;
        else if(icode == 2 && ifun == 3)
            cnd = ZF;
        else if(icode == 2 && ifun == 4)
            cnd = ~ZF;
        else if(icode == 2 && ifun == 5)
            cnd = ~(SF^OF);
        else if(icode == 2 && ifun == 6)
            cnd = ~(SF^OF)&~ZF;
        else if(icode == 7 && ifun == 0)
                cnd = 1;
        else if(icode == 7 && ifun == 1)
            cnd = (SF^OF)|ZF;
        else if(icode == 7 && ifun == 2)
            cnd = SF^OF;
        else if(icode == 7 && ifun == 3)
            cnd = ZF;
        else if(icode == 7 && ifun == 4)
            cnd = ~ZF;
        else if(icode == 7 && ifun == 5)
            cnd = ~(SF^OF);
        else if(icode == 7 && ifun == 6)
            cnd = ~(SF^OF)&~ZF;
        else
            cnd = 0;
        $display("CC = %b%b%b\n cnd = %b\n", ZF, SF, OF, cnd);
        mem = 1;
    end

    always @ (posedge exec)
    begin
        mem1 = 0;
        if(icode == 6)
        begin   
            ALU_select = ifun;
            ALU_A = valA;
            ALU_B = valB;
        end
        else if(icode == 10 || icode == 8)
        begin
            ALU_select = 1;
            ALU_A = valB;
            ALU_B = 8;
        end
        else if(icode == 11 || icode == 9)
        begin
            ALU_select = 0;
            ALU_A = valB;
            ALU_B = 8;
        end
        else if(icode == 2)
        begin
            ALU_select = 1;
            ALU_B = 0;
            ALU_A = valA;
        end
        else if(icode == 3)
        begin
            ALU_select = 0;
            ALU_A = 0;
            ALU_B = valC;
        end
        else if(icode == 4 || icode == 5)
        begin
            ALU_select = 0;
            ALU_A = valC;
            ALU_B = valB;
        end
        mem1 = 1;
    end

endmodule
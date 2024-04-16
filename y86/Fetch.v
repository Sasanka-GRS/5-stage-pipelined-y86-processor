`timescale 1ns / 1ps
module fetch (fet, PC, instr_valid, icode, ifun, rA, rB, valC, icode_valid, ifun_valid, needRegids, needValC, align_done,valP);

    input fet;
    input [63:0] PC;
    output align_done;
    reg [8:0] instr1 [1023:0];

    initial
    begin
        $readmemb("instrMemory.txt", instr1);    
    end

    wire byte_complete;
    output [3:0] icode, ifun, rA, rB;
    output [63:0] valC;
    output reg [63:0] valP;
    output reg instr_valid, icode_valid, ifun_valid, needRegids, needValC, dec, start, deco;

    reg [7:0] instr_byte;
    reg [71:0] instr_info;

    split byte(instr_byte,icode,ifun,byte_complete,start);
    align info(instr_info,rA,rB,valC,needRegids,needValC,deco,align_done);
    
    always @ (posedge fet)
    begin
        start = 0;
        instr_byte = instr1[PC/8];
        start = 1;
    end

    always @ (posedge byte_complete)
    begin
        dec = 0;
        $display("ifun = %b\n", ifun);
        if(icode == 0)
            $finish;
        if(icode <= 11 && icode >=0)
            icode_valid = 1;
        else
            icode_valid = 0;
        if(icode == 2 || icode == 3 || icode == 4 || icode == 5 || icode ==6 || icode == 10 || icode == 11)
            needRegids = 1;
        else
            needRegids = 0;
        if((icode == 2 && ifun <= 6 && ifun >=0) || (icode == 6 && ifun <= 3 && ifun >=0) || (icode == 7 && ifun <= 6 && ifun >=0) || (!(icode == 2 || icode == 6 || icode ==7) && ifun == 0))
            ifun_valid = 1;
        else
            ifun_valid = 0;
        if(icode == 3 || icode == 4 || icode == 5 || icode == 7 || icode == 8)
            needValC = 1;
        else
            needValC = 0;
        instr_valid = ifun_valid & icode_valid;
        $display("icode = %b\n ifun = %b\n needRegids = %b\n needValC = %b\n", icode,ifun, needRegids,needValC);
        dec = 1;
    end

    always @ (posedge dec)
    begin
        deco = 0;
        if(needRegids && needValC)
        begin
            instr_info[71:64] = instr1[PC/8 + 1];
            instr_info[63:56] = instr1[PC/8 + 2];
            instr_info[55:48] = instr1[PC/8 + 3];
            instr_info[47:40] = instr1[PC/8 + 4];
            instr_info[39:32] = instr1[PC/8 + 5];
            instr_info[31:24] = instr1[PC/8 + 6];
            instr_info[23:16] = instr1[PC/8 + 7];
            instr_info[15:8] = instr1[PC/8 + 8];
            instr_info[7:0] = instr1[PC/8 + 9];
        end
        else if (needRegids && ~needValC)
        begin
            instr_info[71:64] = instr1[PC/8 + 1];
            instr_info[63:56] = 8'b0;
            instr_info[55:48] = 8'b0;
            instr_info[47:40] = 8'b0;
            instr_info[39:32] = 8'b0;
            instr_info[31:24] = 8'b0;
            instr_info[23:16] = 8'b0;
            instr_info[15:8] = 8'b0;
            instr_info[7:0] = 8'b0;
        end
        else if (~needRegids && needValC)
        begin
            instr_info[71:64] = 8'b0000_0000;
            instr_info[63:56] = instr1[PC/8 + 2];
            instr_info[55:48] = instr1[PC/8 + 3];
            instr_info[47:40] = instr1[PC/8 + 4];
            instr_info[39:32] = instr1[PC/8 + 5];
            instr_info[31:24] = instr1[PC/8 + 6];
            instr_info[23:16] = instr1[PC/8 + 7];
            instr_info[15:8] = instr1[PC/8 + 8];
            instr_info[7:0] = instr1[PC/8 + 9];
        end
        else
        begin
            instr_info[71:64] = 8'b0000_0000;
            instr_info[63:56] = 8'b0;
            instr_info[55:48] = 8'b0;
            instr_info[47:40] = 8'b0;
            instr_info[39:32] = 8'b0;
            instr_info[31:24] = 8'b0;
            instr_info[23:16] = 8'b0;
            instr_info[15:8] = 8'b0;
            instr_info[7:0] = 8'b0;
        end
        valP = PC + 8 + needRegids*8 + needValC*64;
        deco = 1;
    end

endmodule
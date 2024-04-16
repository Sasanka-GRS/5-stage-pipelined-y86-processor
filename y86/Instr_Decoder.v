`timescale 1ns / 1ps
module decode(instr, instr_valid, icode, ifun, rA, rB, valC, icode_valid, ifun_valid, needRegids, needValC, dec, deco);

    input [79:0] instr;
    input dec;
    wire byte_complete;
    output [3:0] icode, ifun, rA, rB;
    output [63:0] valC;
    output reg instr_valid, icode_valid, ifun_valid, needRegids, needValC, deco;

    wire [7:0] instr_byte;
    wire [71:0] instr_info;
    assign instr_byte = instr[79:72];
    assign instr_info = instr[71:0];

    split byte(instr_byte,icode,ifun,byte_complete,dec);
    align info(instr_info,rA,rB,valC,needRegids);
    
    always @ (posedge byte_complete)
    begin
        deco = 0;
        if(icode <= 11 && icode >=0)
            icode_valid = 1;
        else
            icode_valid = 0;
        if((icode >= 2 && icode <=6) || (icode >= 10 && icode <= 11))
            needRegids = 1;
        else
            needRegids = 1;
        if((icode == 2 && ifun <= 6 && ifun >=0) || (icode == 6 && ifun <= 3 && ifun >=0) || (icode == 7 && ifun <= 6 && ifun >=0) || (!(icode == 2 || icode == 6 || icode ==7) && ifun == 0))
            ifun_valid = 1;
        else
            ifun_valid = 0;
        if(icode == 3 || icode == 4 || icode == 5 || icode == 7 || icode == 8)
            needValC = 1;
        else
            needValC = 0;
        instr_valid = ifun_valid & icode_valid; 
        deco = 1;
    end

endmodule
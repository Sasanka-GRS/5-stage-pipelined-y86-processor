`timescale 1ns / 1ps
module split(instr_byte,icode,ifun,byte_complete,start);

    input [7:0] instr_byte;
    input start;
    output reg [3:0] icode,ifun;
    output reg byte_complete;

    always @ (posedge start)
    begin
        byte_complete=0;
        icode = instr_byte[7:4];
        ifun = instr_byte[3:0];
        byte_complete = 1;
    end

endmodule

module align(instr_info,rA,rB,valC,needRegids,needValC,deco,align_done);

    input [71:0] instr_info;
    input needRegids,needValC,deco;
    output reg [3:0] rA, rB;
    output reg [63:0] valC;
    output reg align_done;

    always @ (posedge deco)
    begin
        align_done = 0;
        if(needRegids)
        begin
            rA = instr_info[71:68];
            rB = instr_info[67:64];
        end
        if(needValC)
            valC = needRegids ? instr_info[63:0] : instr_info[71:8];
        $display("rA = %d\n rB = %d\n valC = %d\n", rA, rB, valC);
        align_done = 1;
    end

endmodule
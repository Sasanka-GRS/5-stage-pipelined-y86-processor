`timescale 1ns / 1ps
module y86 ();
    
    wire [63:0] PC;
    wire fet;
    wire instr_valid;
    wire [3:0] icode, ifun, rA, rB;
    wire [63:0] valM , valP, PC1;
    wire [71:0] instr_info;
    wire [2:0] cc;
    wire signed [63:0] valC , valA, valB, valE;
    wire icode_valid, ifun_valid, needRegids, needValC, cnd, align_done, mem, write_back, exec, pc_update, fet1;


    fetch fetc(fet, PC, instr_valid, icode, ifun, rA, rB, valC, icode_valid, ifun_valid, needRegids, needValC, align_done,valP);
    decoder_writeback decoder(icode, rA, rB, valA, valB, cnd, write_back, valM, valE,align_done,exec,pc_update);
    execute execut(icode, ifun, valC, valA, valB, valE, cnd , exec, mem, cc);
    memory memo(icode, valE, valA, valP, valM, mem, write_back);
    PC_update pc_up(fet, PC, icode, cnd, valC, valM, valP, pc_update);

endmodule
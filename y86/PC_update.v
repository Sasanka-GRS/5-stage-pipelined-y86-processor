`timescale 1ns / 1ps
module PC_update(fet, PC, icode, cnd, valC, valM, valP, pc_update);

    input [3:0] icode;
    input cnd, pc_update;
    input [63:0] valC, valM, valP;
    output reg [63:0] PC;
    output reg fet;

    initial begin
        PC = 0;
        fet = 1;
    end

    always @ (pc_update)
    begin
        fet = 0;
        if(icode == 0)
            PC = 0;
        else if(icode == 1 || icode == 2 || icode == 3 || icode == 4 || icode == 5 || icode == 6 || icode == 10 || icode == 11)
            PC = valP;
        else if(icode == 7)
            PC = cnd ? valC : valP;
        else if(icode == 8)
            PC = valC;
        else if(icode == 9)
            PC = valM;
        $display("PC = %d valP = %d\n", PC/8,valP/8);
        fet = 1;
    end

endmodule
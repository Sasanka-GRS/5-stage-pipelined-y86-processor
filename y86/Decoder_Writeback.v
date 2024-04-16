`timescale 1ns / 1ps
module decoder_writeback(icode, rA, rB, valA, valB, cnd, write_back, valM, valE, align_done, exec, pc_update);

    input [3:0] icode, rA, rB;
    input [63:0] valM, valE;
    input cnd, write_back, align_done;
    output reg [63:0] valA, valB;
    output reg exec, pc_update;
    
    reg [63:0] reg_file [15:0];
    reg i,write;
    
    initial
    begin
        $readmemb("programRegisters.txt", reg_file);
    end

    always @ (posedge align_done)
    begin
        exec = 0;
        if(icode == 2)
            valA = reg_file [rA];
        else if(icode == 4 || icode == 6)
        begin
            valA = reg_file [rA];
            valB = reg_file [rB];
        end
        else if(icode == 5)
            valB = reg_file [rB];
        else if(icode == 8)
            valB = reg_file [4];
        else if(icode == 9 || icode == 11)
        begin
            valA = reg_file [4];
            valB = reg_file [4];
        end
        else if(icode == 10)
        begin
            valA = reg_file [rA];
            valB = reg_file [4];
        end
        $display("valA = %d\n valB = %d\n", valA, valB);
        exec = 1;
    end

    always @ (posedge write_back)
    begin
        write = 0;
        if((icode == 2 && cnd) || (icode == 3) || (icode == 6))
        begin
            reg_file[rB] = valE;
        end
        else if(icode == 5)
            reg_file[rA] = valM;
        else if(icode == 8 || icode == 9 || icode == 10)
            reg_file[4] = valE;
        else if (icode == 11)
        begin
            reg_file[4] = valE;
            reg_file[rA] = valM;
        end
        $display("valE = %d\n valM = %d\n", valE, valM);
        write = 1;
    end

    always @ (posedge write)
    begin
        pc_update = 0;
        $writememb("programRegisters.txt",reg_file);
        pc_update = 1;
    end

endmodule
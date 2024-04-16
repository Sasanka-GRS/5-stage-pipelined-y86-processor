`timescale 1ns / 1ps
module memory(icode, valE, valA, valP, valM, mem, write_back);
    
    input [3:0] icode;
    input mem;
    input [63:0] valA, valE, valP;
    output reg [63:0] valM;
    output reg write_back;

    reg mem_read, mem_write, mem_addr, mem_data, mem_file, mem_start;
    reg [7:0] data_memory [1023:0];
    reg [63:0] address, data;

    initial
    begin
        $readmemb("dataMemory.txt", data_memory);    
    end

    always @ (posedge mem)
    begin
        mem_start = 0;
        mem_read = 0;
        mem_write = 0;
        if(icode == 5 || icode == 9 || icode == 11)
            mem_read = 1;
        if(icode == 8 || icode == 10 || icode == 4)
            mem_write = 1;
        if(icode == 4 || icode == 10 || icode == 8 || icode == 5)
            address = valE;
        else if(icode == 9 || icode == 11)
            address = valA;
        if(icode == 4 || icode == 10)
            data = valA;
        else if(icode == 8)
            data = valP;
        mem_start = 1;
    end

    always @ (posedge mem_start)
    begin
        write_back = 0;
        if(mem_read)
        begin
            valM[63:56] = data_memory[address];
            valM[55:48] = data_memory[address+1];
            valM[47:40] = data_memory[address+2];
            valM[39:32] = data_memory[address+3];
            valM[31:24] = data_memory[address+4];
            valM[23:16] = data_memory[address+5];
            valM[15:8] = data_memory[address+6];
            valM[7:0] = data_memory[address+7];
        end
        else if(mem_write)
        begin
            data_memory[address] = data[63:56];
            data_memory[address+1] = data[55:48];
            data_memory[address+2] = data[47:40];
            data_memory[address+3] = data[39:32];
            data_memory[address+4] = data[31:24];
            data_memory[address+5] = data[23:16];
            data_memory[address+6] = data[15:8];
            data_memory[address+7] = data[7:0];
            $writememb("dataMemory.txt",data_memory);
        end
        write_back = 1;
    end

endmodule
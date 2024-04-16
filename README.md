# Final-assignment

The y86 encoded instructions have to be pasted in the file named instrMemory.txt present in the y86 folder in binary format. A sample is shown below for addq in register 0 and 1 operation:

01100000

00000001


The program registers which are written or read are present in the file named programRegisters.txt present in the y86 folder in binary format. A sample of the test case for gcd of 4 and 6 present in the register r0 is shown below:

// 0x00000000
0000000000000000000000000000000000000000000000000000000000000010
0000000000000000000000000000000000000000000000000000000000000110
0000000000000000000000000000000000000000000000000000000000000100
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001100
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000011100
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000


The gcd (10 (2)) is present in register r0 with the code given in the previous section of the report.

The data memory can be read or written is present in the file named dataMemory.txt present in the y86 folder in binary format. This file shows the memory changes for any memory related operations.

For compiling the processor as a whole, it is necessary to compile all modules separately, with the command : 

iverilog Adder_2.v Adder_4.v ADD.v ALU.v AND.v Compliment_2.v Decoder_Writeback.v Execute.v Fetch.v Instr_Split.v Memory.v PC_update.v SUB.v XOR.v Y86_SEQ.v

And execute can be done by just using the command ./a.out

The current values of the variables in the processor are printed on the serial monitor and can be seen for each step.

The expected outputs can be seen either on the terminal screen, or the final outputs are available in the program registers and data memory based on the operation performed, and can also be viewed in gtkwave, by appending 

initial begin
        $dumpfile("file.vcd");
     	$dumpvars(0,y86);
end

In the y86 module, running the code, and running gtkwave file.vcd to observe the outputs in gtkwave.

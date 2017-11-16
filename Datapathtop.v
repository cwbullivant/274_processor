`timescale 1ns / 1ps

module Datapathtop(RegDest, RegisterWrite, ALUSource, WriteMem, ReadMem, MemToReg, PCSource, operation, rst, clk, PCAddress, PCNext, Instr, 
AddressPlusFour, ExtendedInstr, ShiftedAddress, AddShiftAddress, ReadData1, ReadData2, ALUSrc2, ALURes, ReadMemData, WriteToReg, 
WriteRegAddress, Zero);
   //first inputs are outputs from the controller, to tell the datapath what to do
   input RegDest, RegisterWrite, ALUSource, WriteMem, ReadMem, MemToReg, PCSource, ALUSource2, RegSel, Branch;
   input [3:0] operation;
   input rst, clk;
   wire [31:0] PCAddress, PCNext, Instr, AddressPlusFour, ExtendedInstr, ShiftedAddress, AddShiftAddress, ReadData1, ReadData2, 
               ALUSrc2, ALURes, ReadMemData, WriteToReg, ALUSrcSel, Zextend, ALURegSrc;
   wire [4:0]  WriteRegAddress;
   output reg  Zero; // output flag

   ProgramCounter PC_1(PCNext, PCAddress, rst, clk); //done
   InstructionMemory IM_1(PCAddress, Instr); //done
   Mux32Bit2To1 ALUMux(ALUSrc2, ExtendedInstr, ReadData2, ALUSource); //done
   Mux32Bit2To1 DataMemMux(WriteToReg, ReadMemData, ALURes, MemToReg); //done
   Mux32Bit2To1 PCSrcMux(PCNext, AddShiftAddress, AddressPlusFour, PCSource); //done
   Mux32Bit2To1 ALUMux2(ALUSrcSel, Zextend, ALUSrc2, ALUSource2); //done
   Mux32Bit2To1 ALUSrcRegMux(ALURegSrc, ReadData2, ReadData1, RegSel); //done
   Mux5Bit2To1 RegDstMux(WriteRegAddress, Instr[15:11], Instr[20:16], RegDest); //done
   RegisterFile allRegs(Instr[25:21], Instr[20:16], WriteRegAddress, WriteToReg, RegisterWrite, clk, ReadData1, ReadData2); //done
   SignExtension SignExtend(Instr[15:0], ExtendedInstr); //done
   ZeroExtension ZeroExtend(Intr[10:6], Zextend); //done
   ALU32Bit ALU_full(operation, ALURegSrc, ALUSrcSel, ALURes, Zero); //done
   DataMemory DataMem(ALURes, ReadData2, clk, WriteMem, ReadMem, ReadMemData); //done
   PCAdder PCAdd(PCAddress, AddressPlusFour); //done
   PCShifter PCShift(ExtendedInstr, ShiftedAddress); //done
   PCShiftAdder PCShiftAdd(AddressPlusFour, ShiftedAddress, AddShiftAddress); //done
   notgate not_1(Zero, nZero);
   and2gate and_1(nZero, Branch, PCSrc);
endmodule // Datapathtop
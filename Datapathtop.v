`timescale 1ns / 1ps

module Datapathtop(RegDest, RegisterWrite, ALUSource, WriteMem, ReadMem, MemToReg, ALUSource2, RegSel, Branch, operation, rst, clk, 
                   opc, func);
   //first inputs are outputs from the controller, to tell the datapath what to do
   input RegDest, RegisterWrite, ALUSource, WriteMem, ReadMem, MemToReg, ALUSource2, RegSel, Branch;
   input [3:0] operation;
   input rst, clk;
   wire [31:0] PCAddress, PCNext, Instr, AddressPlusFour, ExtendedInstr, ShiftedAddress, AddShiftAddress, ReadData1, ReadData2, 
               ALUSrc2, ALURes, ReadMemData, WriteToReg, ALUSrcSel, Zextend, ALURegSrc;
   wire [4:0]  WriteRegAddress;
   wire Zero; //, PCSource;
   output wire [5:0] opc, func;
   
   (* mark_debug = "true" *) wire [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;

   ProgramCounter PC_1(PCNext, PCAddress, rst, clk); //done
   PCAdder PCAdd(PCAddress, AddressPlusFour); //done
   InstructionMemory IM_1(PCAddress, Instr); //done
   Mux32Bit2To1 ALUMux(ALUSrc2, ExtendedInstr, ReadData2, ALUSource); //done
   Mux32Bit2To1 DataMemMux(WriteToReg, ReadMemData, ALURes, MemToReg); //done
   Mux32Bit2To1 PCSrcMux(PCNext, AddShiftAddress, AddressPlusFour, Branch & Zero); //done
   Mux32Bit2To1 ALUMux2(ALUSrcSel, Zextend, ALUSrc2, ALUSource2); //done
   Mux32Bit2To1 ALUSrcRegMux(ALURegSrc, ReadData2, ReadData1, RegSel); //done
   Mux5Bit2To1 RegDstMux(WriteRegAddress, Instr[15:11], Instr[20:16], RegDest); //done
   RegisterFile allRegs(Instr[25:21], Instr[20:16], WriteRegAddress, WriteToReg, RegisterWrite, clk, ReadData1, ReadData2, debug_Reg8, 	
                        debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19); //done
   SignExtension SignExtend(Instr[15:0], ExtendedInstr); //done
   ZeroExtension ZeroExtend(Instr[10:6], Zextend); //done
   ALU32Bit ALU_full(operation, ALURegSrc, ALUSrcSel, ALURes, Zero); //done
   DataMemory DataMem(ALURes, ReadData2, clk, WriteMem, ReadMem, ReadMemData); //done
   PCShifter PCShift(ExtendedInstr, ShiftedAddress); //done
   PCShiftAdder PCShiftAdd(AddressPlusFour, ShiftedAddress, AddShiftAddress); //done
   //and2gate and_1(Zero, Branch, clk, PCSource);
   
   assign opc = Instr[31:26];
   assign func = Instr[5:0];
endmodule // Datapathtop
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_Reg8, debug_Reg16, debug_Reg17, 
                    debug_Reg18, debug_Reg19);

   input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
   input [31:0] WriteData;
   input 	RegWrite, Clk;
   output reg [31:0] ReadData1, ReadData2;
   
   output [31:0] debug_Reg8, debug_Reg16, debug_Reg17,    
       debug_Reg18, debug_Reg19;
   
   //(* mark_debug = "true" *) reg [31:0] RegFile [0:31];

   (* mark_debug = "true" *) reg [31:0] 	     registers [0:31];
   integer 	     iter = 0; // iteration variable to initialize all registers

   initial begin
      for (iter = 0; iter < 32; iter = iter + 1) begin
	 registers[iter] = 0;
      end
   end
   
   // note: use of register[index] notation eliminates the need to write a 5 to 32 decoder module
   
   always @ (posedge Clk) begin
      if (RegWrite == 1) begin // write data in WriteData to the register indicated by WriteRegister if RegWrite == 1
         registers[WriteRegister] <= WriteData;	 // do nothing otherwise
      end
   end

   always @ (negedge Clk) begin
      ReadData1 <= registers[ReadRegister1];
      ReadData2 <= registers[ReadRegister2];
   end
   
   assign debug_Reg8 = registers[8];
   assign debug_Reg16 = registers[16];
   assign debug_Reg17 = registers[17];
   assign debug_Reg18 = registers[18];
   assign debug_Reg19 = registers[19];

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 06:23:57 PM
// Design Name: 
// Module Name: processortop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processortop(Rst, Clk);

input Rst, Clk; // reset and clock signals

wire [5:0] oprtn, fcn; // controller input signals

wire destReg, RgWrt, ALUSc, MemRd, MemWrt, MemtReg, Bnch, ALUSc2, RgSel; // controller output signals
wire [3:0] ALUOperation;
(* mark_debug = "true" *) wire [31:0] debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19;

matrixcontroller controller_1(oprtn, fcn, ALUSc, ALUSc2, RgSel,destReg, RgWrt, ALUOperation, MemRd, MemWrt, MemtReg, Bnch);
Datapathtop full_datapath(destReg, RgWrt, ALUSc, MemWrt, MemRd, MemtReg, ALUSc2, RgSel, Bnch, ALUOperation, Rst, Clk, oprtn, fcn, 
debug_Reg8, debug_Reg16, debug_Reg17, debug_Reg18, debug_Reg19);

endmodule

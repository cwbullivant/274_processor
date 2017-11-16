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


module processortop();

wire [5:0] operation, fcn; // controller input signals
wire Rst, Clk; // reset and clock signals

wire destReg, RgWrt, ALUSc, MemRd, MemWrt, MemtReg, Bnch, ALUSc2, RgSel, ALUOperation; // controller output signals
wire [31:0] PCAdd, PCN, Instruc, APF, ExtInstruc, ShftAddr, ASA, RD1, RD2, ALUS2, ALUR, RMD, WTR, ALUSS, Zext, ALURS;
wire [4:0] WRA;
wire Zro, nZro, PCSrc;

matrixcontroller controller_1(operation, fcn, destReg, RgWrt, ALUSc, MemRd, MemWrt, MemtReg, Bnch, ALUSc2, RgSel, ALUOperation);
Datapathtop full_datapath(destReg, RgWrt, ALUSc, MemWrt, MemRd, MemtReg, Bnch, operation, Rst, Clk, PCAdd, PCN, Instruc, APF, ExtInstruc, 
ShftAddr, ASA, RD1, RD2, ALUS2, ALUR, RMD, WTR, ALUSS, Zext, ALURS, WRA, Zro, nZro, PCSrc);

endmodule

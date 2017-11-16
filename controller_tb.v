`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 12:27:09 PM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb();

reg [5:0] op, fcn;
wire ALUSrc_tb, ALUSrc2_tb, RegSl_tb, RegDst_tb, RegWrite_tb;
wire [3:0] ALUOp_tb;
wire MemRead_tb, MemWrite_tb, MemtoReg_tb, Brnch_tb;

matrixcontroller con_tb(op, fcn, ALUSrc_tb, ALUSrc2_tb, RegSl_tb, RegDst_tb, RegWrite_tb, ALUOp_tb, MemRead_tb, 
                        MemWrite_tb, MemtoReg_tb, Brnch_tb);

always begin
    #100 op <= 6'b000000; fcn <= 6'b100000; // +
    #10 op <= 6'b000000; fcn <= 6'b100010; // -
    #10 op <= 6'b000000; fcn <= 6'b100100; // &&
    #10 op <= 6'b000000; fcn <= 6'b100101; // ||
    #10 op <= 6'b000000; fcn <= 6'b101010; // A < B
    #10 op <= 6'b000000; fcn <= 6'b000000; // shift left
    #10 op <= 6'b000000; fcn <= 6'b000010; // shift right
    #10 op <= 6'b000000; fcn <= 6'b000110; // ROTR
    #10 op <= 6'b011100; fcn <= 6'b100001; // clo
    #10 op <= 6'b011100; fcn <= 6'b100000; // clz
    #10 op <= 6'b011100; fcn <= 6'b000010; // mul
    #10 op <= 6'b001000; fcn <= 6'b100010; // addi
    #10 op <= 6'b001101; fcn <= 6'b100010; // ori
    #10 op <= 6'b101011; fcn <= 6'b100010; // sw
    #10 op <= 6'b100011; fcn <= 6'b100010; // lw
    #10 op <= 6'b000101; fcn <= 6'b100010; // bne
    #10 op <= 6'b000000; fcn <= 6'b000000; // shift left; test to see if it can switch back
    #10 op <= 6'b011100; fcn <= 6'b000010; // mul
    #10 op <= 6'b000000; fcn <= 6'b100101; // ||
end
    

endmodule

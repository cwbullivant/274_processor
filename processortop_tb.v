`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2017 01:25:17 PM
// Design Name: 
// Module Name: processortop_tb
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


module processortop_tb();

reg Rst_tb, Clk_tb; // reset and clock signals

processortop myProcessor(Rst_tb, Clk_tb);
                         
initial begin
    Clk_tb <= 1'b0;
    forever #100 Clk_tb <= ~Clk_tb;
end

initial begin
    Rst_tb <= 1;
    @(posedge Clk_tb);
    #25 Rst_tb <= 0;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 05:47:34 PM
// Design Name: 
// Module Name: and2gate
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


module and2gate(A, B, F);
    input A, B;
    output reg F;
    
    always @(A,B) begin
        F <= A & B;
    end
endmodule

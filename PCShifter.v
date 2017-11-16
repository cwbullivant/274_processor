`timescale 1ns / 1ps

module PCShifter(A, Result);
   input [31:0] A;
   output reg [31:0] Result;

   always @(A) begin
      Result <= A << 2;
   end
endmodule // PCShifter

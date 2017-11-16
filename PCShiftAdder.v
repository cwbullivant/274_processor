`timescale 1ns / 1ps

module PCShiftAdder(A, B, Result);
   input [31:0] A, B;
   output reg [31:0] Result;


   always @(*) begin
      Result <= A + B;
   end
endmodule // PCShiftAdder

   

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports a set of arithmetic and 
// logical operaitons. The 'ALUResult' will output the corresponding 
// result of the operation based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal determines the function of the ALU based 
// on the table below. 

// Op|'ALUControl' value  | Description | Notes
// ==========================
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)

//--// Below instructions will be in in Part 2 //--// 
// COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
// COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
//
// NOTES:-
// MULTIPLICATION : 32-bit signed multiplication results with 64-bit output.
//                  ALUResult will be set to lower 32 bits of the product value. 
//
// SET LESS THAN : ALUResult is '32'h000000001' if A < B.
// 
// LEFT SHIFT: The contents of the 32-bit "A" input are shifted left, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
// RIGHT SHIFT: The contents of the 32-bit "A" input are shifted right, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
//
// ROTR: logical right-rotate of a word by a fixed number of bits. 
//       The contents of the 32-bit "A" input are rotated right. 
//       The bit-rotate amount is specified by "B".
//	     ((A >> B) | (A << (32-B)))
//
//--// Below instructions will be in in Part 2 //--// 
// CLO: Count the number of leading ones in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
// 
// CLZ: Count the number of leading zeros in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
//
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

   input [3:0] ALUControl; // control bits for ALU operation
   input [31:0] A, B;	    // inputs
   integer i;
   reg flag = 0;
   integer counter = 0;

   output reg [31:0] ALUResult;	// answer
   output reg Zero;	    // Zero=1 if ALUResult == 0

   always @(*) begin
      case (ALUControl)
        4'b0000: ALUResult = A + B;
        4'b0001: ALUResult = A - B;
        4'b0010: ALUResult = A * B;
        4'b0011: ALUResult = A & B;
	    4'b0100: ALUResult = A || B;
	    4'b0101: begin
	       if (A < B) begin
	           ALUResult = 32'h00000001;
	       end
	       else begin
	           ALUResult = 32'h00000000;
	       end
	    end
	    4'b0110: begin
	       if (A == B) begin
	           ALUResult = 32'h00000001;
	       end
	       else begin
	           ALUResult = 32'h00000000;
	       end
	    end
        4'b0111: begin
	       if (A != B) begin
	           ALUResult = 32'h00000001;
	       end
	       else begin
	           ALUResult = 32'h00000000;
	       end
        end
	    4'b1000: ALUResult = A << B;
	    4'b1001: ALUResult = A >> B;
	    4'b1010: ALUResult = ((A >> B) | (A << (32-B)));
	    4'b1011: begin
	       if (A[31] == 1) begin
	           for (i = 31; i >= 0; i = i - 1) begin
	               if (A[i] == 1 && flag == 0) begin
	                   counter = counter + 1;
	               end
	               else begin
	                   flag = 1;
	               end
	           end
	           ALUResult = counter;
	           counter = 0;
	       end
	       else begin
	           ALUResult <= 0;
	       end
	    end
	    4'b1100: begin
            if (A[31] == 0) begin
                for (i = 31; i >= 0; i = i - 1) begin
                    if (A[i] == 0 && flag == 0) begin
                        counter = counter + 1;
                    end
                    else begin
                        flag = 1;
                    end
                end
                ALUResult = counter;
                counter = 0;
            end
            else begin
                ALUResult <= 0;
            end
        end
      endcase // case (ALUControl)
   end // always (*)
   
   always @(ALUResult) begin
       if (ALUResult == 32'h0) begin
           Zero <= 1'b1; 
       end
       else begin 
           Zero <= 1'b0;
       end
   end
endmodule // ALU32Bit
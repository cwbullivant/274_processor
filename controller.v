`timescale 1ns / 1ps

module matrixcontroller(opcode, func, ALUSrc, ALUSrc2, RegSl, RegDst, RegWrite, ALUOp, MemRead, MemWrite, MemtoReg, Brnch);
   input [5:0] opcode, func;
   output reg  RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Brnch, ALUSrc2, RegSl;
   output reg [3:0] ALUOp;

 always @(*) begin
   if (opcode == 6'b000000) begin // most r-type operations; +,-,&&,||, ROTR, >>, << , etc.
      if (func == 6'b100000) begin //+
        ALUSrc <= 0;
        ALUSrc2 <= 0;
        RegSl <= 0;
        RegDst <= 1;
        RegWrite <= 1;
        ALUOp <= 4'b0000;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0; 
        Brnch <= 0;
      end
      else if (func == 6'b100010) begin //-
              ALUSrc <= 0;
              ALUSrc2 <= 0;
	          RegSl <= 0;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b0001;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
      else if (func == 6'b100100) begin//&&
              ALUSrc <= 0;
              ALUSrc2 <= 0;
	          RegSl <= 0;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b0011;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
      else if (func == 6'b100101) begin//||
              ALUSrc <= 0;
              ALUSrc2 <= 0;
	          RegSl <= 0;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b0100;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
      else if (func == 6'b101010) begin // A < B
              ALUSrc <= 0;
              ALUSrc2 <= 0;
	          RegSl <= 0;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b0101;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
      else if (func == 6'b000000) begin// shift left
              ALUSrc <= 0; //strictly speaking, don't care
              ALUSrc2 <= 1;
	          RegSl <= 1;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b1000;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
      else if (func == 6'b000010) begin// shift right
              ALUSrc <= 0; //strictly speaking, don't care
              ALUSrc2 <= 1;
              RegSl <= 1;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b1001;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
      else if (func == 6'b000110) begin // ROTR
              ALUSrc <= 0;
              ALUSrc2 <= 0;
              RegSl <= 0;
              RegDst <= 1;
              RegWrite <= 1;
              ALUOp <= 4'b1010;
              MemRead <= 0;
              MemWrite <= 0;
              MemtoReg <= 0; 
              Brnch <= 0;
      end
   end
   else if (opcode == 6'b011100) begin // clo, clz, mul
      if (func == 6'b100001) begin // clo
                    ALUSrc <= 0;
                    ALUSrc2 <= 0;
                    RegSl <= 0;
                    RegDst <= 1;
                    RegWrite <= 1;
                    ALUOp <= 4'b1011;
                    MemRead <= 0;
                    MemWrite <= 0;
                    MemtoReg <= 0; 
                    Brnch <= 0;
      end
      else if (func == 6'b100000) begin // clz
                          ALUSrc <= 0;
                          ALUSrc2 <= 0;
                          RegSl <= 0;
                          RegDst <= 1;
                          RegWrite <= 1;
                          ALUOp <= 4'b1100;
                          MemRead <= 0;
                          MemWrite <= 0;
                          MemtoReg <= 0; 
                          Brnch <= 0;
      end
      else if (func == 6'b000010) begin // mul
                          ALUSrc <= 0;
                          ALUSrc2 <= 0;
                          RegSl <= 0;
                          RegDst <= 1;
                          RegWrite <= 1;
                          ALUOp <= 4'b0010;
                          MemRead <= 0;
                          MemWrite <= 0;
                          MemtoReg <= 0; 
                          Brnch <= 0;
      end
   end // if (opcode == 6'b011100)
   else if (opcode == 6'b001000) begin // addi
      ALUSrc <= 1;
      ALUSrc2 <= 0;
      RegSl <= 0;
      RegDst <= 0;
      RegWrite <= 1;
      ALUOp <= 4'b0000;
      MemRead <= 0;
      MemWrite <= 0;
      MemtoReg <= 0;
      Brnch <= 0;
   end // if (opcode == 6'b001000)
   else if (opcode == 6'b001101) begin // ori
      ALUSrc <= 1;
      ALUSrc2 <= 0;
      RegSl <= 0;
      RegDst <= 0;
      RegWrite <= 1;
      ALUOp <= 4'b0100;
      MemRead <= 0;
      MemWrite <= 0;
      MemtoReg <= 0;
      Brnch <= 0;
   end
   else if (opcode == 6'b101011) begin // sw
                       ALUSrc <= 1;
                       ALUSrc2 <= 0;
                       RegSl <= 0;
                       RegDst <= 0;
                       RegWrite <= 0;
                       ALUOp <= 4'b0000;
                       MemRead <= 0;
                       MemWrite <= 1;
                       MemtoReg <= 0; 
                       Brnch <= 0;
   end
   else if (opcode == 6'b100011) begin // lw
                       ALUSrc <= 1;
                       ALUSrc2 <= 0;
                       RegSl <= 0;
                       RegDst <= 0;
                       RegWrite <= 1;
                       ALUOp <= 4'b0000;
                       MemRead <= 1;
                       MemWrite <= 0;
                       MemtoReg <= 1; 
                       Brnch <= 0;
   end
   else if (opcode == 6'b000101) begin // bne
                       ALUSrc <= 0;
                       ALUSrc2 <= 0;
                       RegSl <= 0;
                       RegDst <= 1;
                       RegWrite <= 0;
                       ALUOp <= 4'b0110;
                       MemRead <= 0;
                       MemWrite <= 0;
                       MemtoReg <= 0; 
                       Brnch <= 1;
   end
 end

endmodule // matrixcontroller

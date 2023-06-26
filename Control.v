module Control(
  Instruction,Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite,ALUOp,Clock,Exit);
   input wire [6:0] Instruction;
   input wire Clock;
  output  reg Branch, MemRead, MemWrite, ALUSrc, RegWrite,MemToReg,Exit;
  output  reg [1:0] ALUOp;

  always @(*)
  begin


    case (Instruction) //Baseado no valor Instruction(Opcode da instrucao)
      7'b0110011: begin // R-type instruction
  Branch = 1'b0;
  MemRead = 1'b0;
  MemWrite = 1'b0;
  ALUSrc = 1'b0;
  RegWrite = 1'b1;
  MemToReg = 1'b0; // Assign a value to MemToReg in this case
  ALUOp = 2'b10;
end
      7'b0100011:begin //S

Branch = 1'b0;
MemRead = 1'b0;
MemToReg = 1'b0;
MemWrite = 1'b1;
ALUSrc = 1'b1;
RegWrite = 1'b0;
ALUOp <= 2'b00; end
      7'b1100011: begin //R
Branch = 1'b1;
MemRead = 1'b0;
MemToReg = 1'b0;
MemWrite = 1'b0;
ALUSrc = 1'b0;
RegWrite = 1'b0;
ALUOp = 2'b01; end
      
7'b0010011: begin //I
Branch = 1'b0;
MemRead = 1'b0;
MemToReg = 1'b0;
MemWrite = 1'b0;
ALUSrc = 1'b1;
RegWrite = 1'b1;
ALUOp = 2'b11; end

    endcase
 if(Instruction === 7'bxxxxxxx)begin
                  Exit=1;
end else begin
//$display("%b-%b",Instruction,ALUOp);
//$display("Branch: %b MemRead: %b MemToReg: %b MemWrite: %b ALUSrc: %b RegWrite: %b ALUOp: %b",
  //         Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp);
end
  end


endmodule
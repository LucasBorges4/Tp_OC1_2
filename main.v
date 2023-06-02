module ALUControl(Operation,Funct_Code,Control);
	input [1:0] Operation;
	input [5:0] Funct_Code;
	output[3:0] reg Control;
	always case(Funct_Code)

		32: Operation<=2; //add	
		34: Operation <=6; //sub
		36: Operation <=0; //and
		37: Operation<=1; //or
		39: Operation <=12; //nor
		42: Operation <= 7; //slt
		default: Operation <= 1; //Ilegal
	endcase
endmodule



module ALU(Control, Input1,Input2,Out,Zero);
	input [3:0] Control;
	input [31:0] Input1,Input2;
	output reg [31:0] Out;
	output Zero;
	assign Zero = (Out ==0);
	always @(Control,Input1,Input2) begin
		case(Control)
			0:Out <= Input1 & Input2; //AND
			1: Out <= Input1 | Input2; //OR
			2: Out <= Input1 + Input2;  //ADD
			6: Out <= Input1 - Input2; //SUB
			7: Out <= Input1 < Input2 ? 1 : 0; //BEQ?
			12: Out <= ~(Input1 | Input2); //NOR
			default: Out <= 0; 
		endcase

	end

endmodule

module FlipFlop(Clock,Input_Data,Output_Data,Output_Bar);
 input clock, Input_Data;
 output reg Output_Data;
 output Output_Bar;
 assign Output_Bar= ~ Output_Data;
 always @(posedge Clock)
 Output_Data=Input_Data;
endmodule

module RegisterFile(Read1,Read2,WriteR,WriteD,RWrite,Data1,Data2,clock);
	input [5:0] Read1,Read2,WriteR;
	input [31:0] WriteD;
	output[31:0] Data1,Data2;
	reg [31:0] RegisterF [31:0];
	assign Data1 = RegisterF[Read1];
	assign Data2 = RegisterF[Read2];
	always begin @(posedge clock) 
		if (RWrite) RegisterF[WriteR] <= WriteD;
	end
endmodule

module Adder(Read1,Read2,Data);
	input [31:0] Read1,Read2;
	output[31:0] Data;
	assign Data = Read1 +  Read2;
endmodule

module PCAdder(PC,PC4)(
input [31:0] PC,
output [31:0] PC4);
assign PC4 = PC + 4;
endmodule

module MUX(A,B,S,Out)(
 input [31:0] A,B;
 input S;
 output [31:0] Out;
 assign Out = (S == 1'b0) ? A : B;
endmodule

module Control(Instruction,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite)
input [6:0] Instruction,
output Branch,MemRead,MemToReg,[1:0] ALUOp,MemWrite,ALUSrc,RegWrite);
reg [8:0] control;
assign {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Aluop} = control;
always @(*)
begin
case(Instruction)
7'b0110011 : control <= 9'b001000010; // R
7'b0000011 : control <= 9'b111100000; // Lw
7'b0100011 : control <= 9'b1x0010000; // S
7'b1100011 : control <= 9'b0x0001001; // Sb
7'b0010011 : control <= 9'b101000011; // I
7'b1100111 : control <= 9'b111xx0100; // Jalr
7'b1101111 : control <= 9'b111xx0100; // Jal
default : control    <= 9'bxxxxxxxxx; //Desconhecido
endcase
end
endmodule


module Shift(Input,Output)(
input [31:0] Input;
output [31:0] Output;

assign Out = Input << 1;
endmodule 
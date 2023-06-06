`include "ADD.v" 
`include "ALU_Control.v"
`include "ALU.v"
`include "Branch.v"
`include "Control.v"
`include "Data_Memory.v"
`include "Immediate_Generation.v"
`include "Instruction_mem.v"
`include "MUX.v"
`include "Register.v"
`include "PC.v"

module top_module (Clock, Reset, Out_signal,PCout,Instruction,Result);
wire [31:0] PCin;
output reg Out_signal;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, Branch_Out;
input wire Clock, reset;
output wire [31:0]PCout; 
output wire [31:0]Instruction;
wire [31:0]ReadData1, ReadData2, WriteData2; 
output wire [31:0]Result;
wire [6:0]Opcode; 
wire [4:0]WriteRegister; 
wire [2:0]Funct3; 
wire [6:0]Funct7;
wire [31:0]MUX1, MUX2, MUX3; 
wire [31:0]Read_Data; 
wire [31:0]imm_gen; 
wire [1:0]ALUOp; wire [3:0]Operation; 
wire [31:0]Out1,Out2;
wire [31:0]Sum, Num1, Num2;

reg True = 1'b1;
reg False = 1'b0;
 PC pc( 
	.PCin(MUX1),
	.clk(Clock),
	.PCout(PCout)
);

PC_Change Somador_PC1(
   .PCIn(PCin),
   .PCout(Sum),
   .PC_Change(False)
   
);

PC_Change Somador_PC2(
   .PCIn(PCin),
   .PCout(Sum),
   .PC_Change(False)
   
);
ALU ALU_Outcome( 
	.Number1(ReadData1),
	.Number2(MUX2),
	.ALUOp(ALUOp),
	.Out(Result),
	.Zero(Zero)
);

Register Regs(
    .Clock(Clock), 
	.Write_Register(RegWrite),
    .Write_Data(MUX3), 
	.Read_Register1(Instruction[19:15]), 
	.Read_Register2(Instruction[24:20]), 
	.WriteRegister(Instruction[11:7]),
    .Read_Data1(ReadData1), 
	.Read_Data2(ReadData2)
);

Branch Branch_Control(
	.Branch_In(Branch),  
	.Zero(Zero),
	.Out(Branch_Out)
);

mux Mux_PC( //mux branch
    .A(Out1), 
	.B(Out2), 
	.S(Branch_Out), 
    .Out(MUX1)
);

mux Mux_ALU(
    .A(ReadData2), 
	.B(imm_gen), 
	.S(ALUSrc),
    .Out(MUX2)
);

mux Mux_Exit( //mux datamemory
    .A(Read_Data), 
	.B(Result), 
	.S(MemtoReg),
    .Out(MUX3)
);

Instruction_Memory IM(
	.Inst_Address(PCout),
	.Instruction(Instruction)
);

Data_Memory DM(
	.Address(Result), 
	.WriteData(ReadData2),
	.Clock(Clock), 
	.WriteEnable(MemWrite), 
	.MemRead(MemRead),
	.ReadData(ReadData),
);

Imm_Gen Bigger_Imm(
    .Input(Instruction),
    .Output(imm_gen)
);

Control Controller(
	.Instruction(opcode),
	.Branch(Branch), 
	.MemRead(MemRead), 
	.MemtoReg(MemtoReg), 
	.MemWrite(MemWrite), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite),
	.ALUOp(ALUOp)
);

ALU_Control ALU_Controller(
	.Operation(ALUOp),
	.Funct_Code({Instruction[30], Instruction[14:12]}), 
	.Control(Operation)
);

Add A1(
    .x(PCout), 
	.y(64'd4),
    .soma(Out1) 
);

Add A2(
    .x(PCout), 
	.y(imm_gen<<1), 
    .soma(Out2) 
);
endmodule 



module old_top_module (Clock, Reset, Out_signal);
	input Clock, Reset;
	wire [31:0] PCin, PCout;
	output reg Out_signal;

	PC PC_inst (.Clock(Clock), .PCin(PCin[31:0]), .PCout(PCout[31:0]));



	initial begin
		$display("Olá, mundo!");
	end
	
endmodule

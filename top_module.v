`include "Tp_OC1_2\\Add.v" 
`include "Tp_OC1_2\\ALU_Control.v"
`include "Tp_OC1_2\\ALU.v"
`include "Tp_OC1_2\\Branch.v"
`include "Tp_OC1_2\\Control.v"
`include "Tp_OC1_2\\Data_Memory.v"
`include "Tp_OC1_2\\Immediate_generation.v"
`include "Tp_OC1_2\\Instruction_mem.v"
`include "Tp_OC1_2\\MUX.v"
`include "Tp_OC1_2\\Register.v"
`include "Tp_OC1_2\\PC_Change.v"

module top_module (Clock, Reset,PCout,Instruct,Result);
input wire Clock, Reset;
wire [31:0] PCin, ReadData1, ReadData2, WriteData2,MUX1, MUX2, MUX3,Read_Data,imm_gen,Out1,Out2,Sum, Num1, Num2;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, Branch_Out;
output wire [31:0]PCout,Instruct,Result;
wire [6:0]Opcode; 
wire [4:0]WriteRegister;
wire [1:0]ALUOp; 
wire [3:0]Operation; 

reg True = 1'b1;
reg False = 1'b0;
 PC_Change pc( 
	.PCin(MUX1),
	.PCout(PCout),
	.PC_Change(False),
	.Clock(Clock),
	.Branch(Branch_Out),
	.Reset(Reset)
);

PC_Change Somador_PC1(
   .PCin(PCin),
   .PCout(Sum),
   .PC_Change(False),
   .Clock(Clock),
   .Branch(Branch_Out),
   .Reset(Reset)
);

PC_Change Somador_PC2(
   .PCin(PCin),
   .PCout(Sum),
	.PC_Change(True),
   .Clock(Clock),
   .Branch(Branch_Out),
   .Reset(Reset)
);
ALU ALU_Outcome( 
	.Input1(ReadData1),
	.Input2(MUX2),
	.Control(Operation),
	.Out(Result),
	.Zero(Zero)
);

Register Regs(
    .Clock(Clock), 
	.Reg_Write(RegWrite),
    .Write_Data(MUX3), 
	.Read_Register1(Instruct[19:15]), 
	.Read_Register2(Instruct[24:20]), 
	.Write_Register(Instruct[11:7]),
    .Read_Data1(ReadData1), 
	.Read_Data2(ReadData2)
);

Branch Branch_Control(
	.Branch_In(Branch),  
	.Zero(Zero),
	.Out(Branch_Out)
);

MUX Mux_PC( 
    .A(Out1), 
	.B(Out2), 
	.S(Branch_Out), 
    .Out(MUX1)
);

MUX Mux_ALU(
    .A(ReadData2), 
	.B(imm_gen), 
	.S(ALUSrc),
    .Out(MUX2)
);

MUX Mux_Exit(
    .A(Read_Data), 
	.B(Result), 
	.S(MemtoReg),
    .Out(MUX3)
);

Instruction_Memory IM(
	.Instruction_Add(PCout),
	.Instruction(Instruct)
);



Data_Mem DM(
	.Address(Result), 
	.WriteData(ReadData2),
	.Clock(Clock), 
	.WriteEnable(MemWrite), 
	.MemRead(MemRead),
	.ReadData(ReadData1)
);

Immediate_Generation Bigger_Imm(
    .Input(Instruct),
    .Output(imm_gen)
);

Control Controller(
	.Instruction(Opcode),
	.Branch(Branch), 
	.MemRead(MemRead), 
	.MemToReg(MemtoReg), 
	.MemWrite(MemWrite), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite),
	.ALUOp(ALUOp)
);
//Resolver
ALUControl ALU_Controller(
	.Operation(ALUOp),
	.Funct_Code({Instruct[30], Instruct[14:12]}), 
	.Control(Operation)
);

Add A1(
    .Input1(PCout), 
	.Input2(32'd4),
    .Soma(Out1) 
);

Add A2(
    .Input1(PCout), 
	.Input2(imm_gen<<1), 
    .Soma(Out2) 
);
	initial begin
		 $display("myVariable: %d", Instruct);
	end
	
endmodule 


/*
module old_top_module (Clock, Reset, Out_signal);
	input Clock, Reset;
	wire [31:0] PCin, PCout;
	output reg Out_signal;

	PC_Change PC_inst ( .PCin(PCin[31:0]), .PCout(PCout[31:0]));



	initial begin
		$display("Olá, mundo!");
	end
	
endmodule
*/
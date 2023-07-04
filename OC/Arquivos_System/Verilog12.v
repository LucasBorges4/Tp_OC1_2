module top_module (Clock,Reset,PCin,RegisterIn,Instruct_Count,PCResetter); //Modulo principal
/*Instanciacoes */
input wire Reset,PCResetter;
output reg[31:0]PCin,Instruct_Count;
output wire[31:0] RegisterIn;
input wire Clock;
wire Branch,Exit;
reg [31:0] Read_Data,WriteData2,MUX1, MUX2, MUX3,Out1,Out2, InputA, InputB;
wire MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, Branch_Out;
wire [31:0] Out_Put_Shift,PC_Saida,ReadData1, ReadData2,ReadData3;
wire [31:0]PCout,Instruct,Result,imm_gen;
wire [6:0]Opcode; 
wire [4:0]WriteRegister;
wire [1:0]ALUOp; 
wire [3:0]Operation;


wire [31:0] Resultado_Soma_Endereco_PC,Choice_ALU,Output_ALU,Choice_Writing;
reg Aux = 1'b0;
/*
always @(posedge Clock) begin
	if(PCResetter == 1'b1)begin
		PCin <= 0;
		
	if(Aux == 1'b1)begin
	PCin<=PCin + imm_gen;
	end else begin
		  		PCin <= PCin + 4;

	end
end
   
				
				
end
*/
reg [31:0] PC_Add = 4;
reg Reset_Now=1'b0;
always@(posedge Clock)begin
if(Reset_Now)begin
PCin <= 0;
end else begin
PCin <= PCin +PC_Add;
end
end

always@(posedge Zero or posedge Branch)begin


if(Zero) begin
		if(Branch) begin
		PC_Add = imm_gen;
		end else begin
		PC_Add = 4;
		
		end
		end else begin
		PC_Add = 4;

		end
	  
end
	  
always@(posedge Reset)begin
	Reset_Now=1'b1;
	if(PCin == 0)begin
		Reset_Now=1'b0;

	end

end
always@(posedge Clock)begin
Instruct_Count <=PCin / 4;
end   
     
    


ALU ALU(
	.Control(Operation),
	.Input1(ReadData1),
	.Input2(Choice_ALU),
	.Zero(Zero),
	.Out(Output_ALU),
	.Clock(Clock)
);
Register Regs( 
    .Clock(Clock), 
	.Reg_Write(RegWrite),
    .Write_Data(Choice_Writing), 
	.Read_Register1(Instruct[19:15]), 
	.Read_Register2(Instruct[24:20]), 
	.Write_Register(Instruct[11:7]),
    .Read_Data1(ReadData1), 
	.Read_Data2(ReadData2),
	.Reset(Reset_Now),
	.Exit(Exit),
	.Register_Out(RegisterIn)
);





MUX MUX_ALU(
	.A(ReadData2),
	.B(imm_gen),
	.S(ALUSrc),
	.Out(Choice_ALU),
	.Clock(Clock)
);

Instruction_Memory IM( //Funcao que pega a instrucao na memoria
	.Instruction_Add(Instruct_Count),
	.Instruction(Instruct),
	.Exit(Exit)
);

Data_Mem DM( //Local onde e armazenado a memoria do processador, podendo ser alterada ou simplesmente lida
	.Address(Output_ALU), 
	.WriteData(ReadData2),
	.Clock(Clock), 
	.WriteEnable(MemWrite), 
	.MemRead(MemRead),
	.ReadData(ReadData3),
	.Reset(Reset_Now)

);
Immediate_Generation Bigger_Imm( //Funcao Responsavel por pegar um imediato e transformar ele em 32 bits baseado na replicacoa do bit mais significativo
    .Input(Instruct),
		.Clock(Clock),
    .Output(imm_gen));
Control Controller( //Funcao de Controle, basicamente delimitado todos os 6 valores baseado no opcode da instrucao
	.Instruction(Instruct[6:0]),
	.Branch(Branch), 
	.MemRead(MemRead), 
	.MemWrite(MemWrite), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite),
	.ALUOp(ALUOp),
	.Clock(Clock),
	.MemToReg(MemToReg)
);
MUX_Data_Choice Writing_Choice(
	.A(Output_ALU),
	.B(ReadData3),
	.S(MemToReg),
	.Output_ALU(Output_ALU),
	.Out(Choice_Writing),
	.Clock(Clock)
);
ALUControl ALU_Controller(  
	.Operation(ALUOp),
	.Funct_Code({Instruct[30],Instruct[14:12]}), 
	.Control(Operation),
	.Clock(Clock),
	.Funct_3(Instruct[14:12])
);


Add SumAdress_PC(
	.Input1(PCin),
	.Input2(imm_gen),
	.Soma(Resultado_Soma_Endereco_PC),
	.Clock(Clock)
);

endmodule 




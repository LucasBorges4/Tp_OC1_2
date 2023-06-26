`include "Tp_OC1_2//Add.v" 
`include "Tp_OC1_2//ALU_Control.v"
`include "Tp_OC1_2//ALU.v"
`include "Tp_OC1_2//Branch.v"
`include "Tp_OC1_2//Control.v"
`include "Tp_OC1_2//Data_Memory.v"
`include "Tp_OC1_2//Immediate_generation.v"
`include "Tp_OC1_2//Instruction_mem.v"
`include "Tp_OC1_2//MUX.v"
`include "Tp_OC1_2//Register.v"
`include "Tp_OC1_2//PC_Change.v"
`include "Tp_OC1_2//shift.v"

module top_module (Clock, Reset,Exit); //Modulo principa

/*Instanciacoes */
input wire Clock, Reset,Exit;
wire Branch;
reg [31:0] PCin,Read_Data,WriteData2,MUX1, MUX2, MUX3,Out1,Out2, InputA, InputB;
wire MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, Branch_Out;
wire [31:0] Out_Put_Shift,PC_Saida,ReadData1, ReadData2,ReadData3;
wire [31:0]PCout,Instruct,Result,imm_gen;
wire [6:0]Opcode; 
wire [4:0]WriteRegister;
wire [1:0]ALUOp; 
wire [3:0]Operation;
reg [31:0] Instruct_Count;

/*Assigns para a nao geracao de valores indeterminados */
/*
assign PCout = 32'b0;
assign Instruct = 32'b0;
assign Result = 32'b0;
assign PCin =32'b0;
assign MUX1 = 32'b0;
assign MUX2= 32'b0;
assign MUX3= 32'b0;
assign ReadData1 = 32'b0;
assign Read_Data2 =32'b0;
assign WriteData2 = 32'b0;
assign Read_Data = 32'b0;
assign imm_gen = 32'b0;
assign Out1= 32'b0;
assign Out2 = 32'b0;
assign InputA = 32'b0;
assign InputB = 32'b0;

assign Reset = 0;
 assign Branch = 0;
 assign MemRead = 0;
 assign MemToReg = 0;
 assign MemWrite = 0;
 assign ALUSrc= 0;
 assign RegWrite = 0;
 assign Zero = 0;
 assign Branch_Out = 0;
 assign PC_Saida = 32'b0;
assign PCOut = 32'b0;
reg True = 1'b1;
reg False = 1'b0;


*/
wire [31:0] Resultado_Soma_Endereco_PC,Choice_ALU,Output_ALU,Choice_Writing;
initial begin
	PCin =0;
	Instruct_Count = 0;
	
end

always@(posedge Clock) begin
		$display("Branch:%b",Branch);
		Instruct_Count <= PCin / 32'b00000000000000000000000000000100;

end

/*
Refresh_PC PC_Refresher(
	.PCin(PC_Saida),
	.PCout(PCout),
	.Clock(Clock),
	.Reset(Reset)
);*/
PC Somador_PC1( //Funcao que incrementa PC por 4, ultrapassando para a proxima funcao
   .PCin(PCin),
   .Output(PC_Saida),
   .Clock(Clock),
   .Reset(Reset),
   .Zero(Zero),
   .Branch(Branch),
   .imm(imm_gen)
);





ALU ALU(
	.Control(Operation),
	.Input1(ReadData1),
	.Input2(Choice_ALU),
	.Zero(Zero),
	.Out(Output_ALU),
	.Clock(Clock)
);
Register Regs( //Funcao de Registro que guarda os registradores e permite o acesso
    .Clock(Clock), 
	.Reg_Write(RegWrite),
    .Write_Data(Choice_Writing), 
	.Read_Register1(Instruct[19:15]), 
	.Read_Register2(Instruct[24:20]), 
	.Write_Register(Instruct[11:7]),
    .Read_Data1(ReadData1), 
	.Read_Data2(ReadData2)
);

always@(posedge Clock) begin
	//$display("Branch: %b MemRead: %b MemToReg: %b MemWrite: %b ALUSrc: %b RegWrite: %b ALUOp: %b",
     //      Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, ALUOp);
	
		PCin <= PCin + 32'b00000000000000000000000000000100;
	
	//$display(PCin);
end

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
	.Reset(Reset)

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
	.MemToReg(MemToReg),
	.Exit(Exit)
);
MUX_Data_Choice Writing_Choice(
	.A(Output_ALU),
	.B(ReadData3),
	.S(MemToReg),
	.Output_ALU(Output_ALU),
	.Out(Choice_Writing),
	.Clock(Clock)
);
ALUControl ALU_Controller( //Funcao de controle da ALU que retorna um valor de 4 bits responsavel 
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
















/*
Refresh_PC pc(  //Funcao atualiza constantemente PCout com o valor atual de PCin
	.PCin(MUX1),
	.PCout(PCout),
	.Clock(Clock),
	.Reset(Reset)
);
PC_Increment_By_Four Somador_PC1( //Funcao que incrementa PC por 4, ultrapassando para a proxima funcao
   .PCin(PCin),
   .Output(Soma)
);
 
PC_Change Somador_PC2( //Funcao que pode ou nao incrementar PC por 4, caso a Branch for verdadeira vai passar para outro endereco
   .PCin(PCin),
   .PCout(Soma),
   .Clock(Clock),
   .Branch(Branch_Out),
   .Add(InputA+InputB)

);
Shift Shifter( //Funcao que faz shift esquerdo em 1 bit, vai ser necessaria para a questao da imm_gen
	.Input(imm_gen),
	.Output(Out_Put_Shift)
);





Add Somador1( //Esse valor vai somar a saida de PC com 4 e salvar em Out1
    .Input1(PCout), 
	.Input2(32'b00000000000000000000000000000100),
    .Soma(Out1) 
);

Add Somador2( //Esse valor vai somar a saida de PC com a imm_gen com um shift para esquerda e salvar o valor em Out2
    .Input1(PCout), 
	.Input2(Out_Put_Shift), 
    .Soma(Out2) 
);

ALU ALU_Outcome( //ALU, que retornara o resultado da operacao alem se Zero for verdadeiro(PC ira mudar de endereco)
	.Input1(ReadData1),
	.Input2(MUX2),
	.Control(Operation),
	.Out(Result),
	.Zero(Zero)
);




Register Regs( //Funcao de Registro que guarda os registradores e permite o acesso
    .Clock(Clock), 
	.Reg_Write(RegWrite),
    .Write_Data(MUX3), 
	.Read_Register1(Instruct[19:15]), 
	.Read_Register2(Instruct[24:20]), 
	.Write_Register(Instruct[11:7]),
    .Read_Data1(ReadData1), 
	.Read_Data2(ReadData2)
);
Branch Branch_Control( //Funcao responsavel por checar se a Branch for verdadeira e se Zero tambem for, mudando PC de endereco
	.Branch_In(Branch),  
	.Zero(Zero),
	.Out(Branch_Out)
);
MUX Mux_PC(  //Multiplexador que, baseado no valor de Branch_Out, passara um certo valor para o PC
    .A(Out1), 
	.B(Out2), 
	.S(Branch_Out), 
    .Out(MUX1)
);
MUX Mux_ALU( //Multiplexador da ALU que escolhe entre o imediato e o segundo registrador lido baseado no valor de ALUSrc
    .A(ReadData2), 
	.B(imm_gen), 
	.S(ALUSrc),
    .Out(MUX2)
);


MUX Mux_Exit( //Multiplexador que escolhe entre passar o resultado da ALU ou o de um dado armazenado para ser escrito na base de registradores
    .A(Read_Data), 
	.B(Result), 
	.S(MemtoReg),
    .Out(MUX3)
);

Instruction_Memory IM( //Funcao que pega a instrucao na memoria
	.Instruction_Add(PCout),
	.Instruction(Instruct)
);

Data_Mem DM( //Local onde e armazenado a memoria do processador, podendo ser alterada ou simplesmente lida
	.Address(Result), 
	.WriteData(ReadData2),
	.Clock(Clock), 
	.WriteEnable(MemWrite), 
	.MemRead(MemRead),
	.ReadData(ReadData1),
	.Reset(Reset)

);




Immediate_Generation Bigger_Imm( //Funcao Responsavel por pegar um imediato e transformar ele em 32 bits baseado na replicacoa do bit mais significativo
    .Input(Instruct),
    .Output(imm_gen),
	.opcode(Opcode)
	
);

Control Controller( //Funcao de Controle, basicamente delimitado todos os 6 valores baseado no opcode da instrucao
	.Instruction(Opcode),

	.Branch(Branch), 
	.MemRead(MemRead), 
	.MemToReg(MemtoReg), 
	.MemWrite(MemWrite), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite),
	.ALUOp(ALUOp)
);



ALUControl ALU_Controller( //Funcao de controle da ALU que retorna um valor de 4 bits responsavel 
	.Operation(ALUOp),
	.Funct_Code({Instruct[30],Instruct[14:12]}), 
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
 

*/











endmodule 




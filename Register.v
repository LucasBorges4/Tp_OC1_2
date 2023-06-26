module Register(Clock,Read_Register1, Read_Register2, Reg_Write, Write_Data, Read_Data1, Read_Data2,Write_Register);
	input wire Clock;
	input wire Reg_Write;
	integer Integer;
	input wire [4:0] Read_Register1;
	input wire [4:0]  Read_Register2;
	input wire [4:0] Write_Register;
	input wire [31:0] Write_Data;
	output reg [31:0] Read_Data1; 
	output reg [31:0] Read_Data2;

	//reg read_register1, read_register2, write_register;
	//reg write_data;
	reg signed [31:0] Registradores [0:31]; //32 Registradores de 32 bits cada
	integer index; //Index que sera utilizado para acessarmos esses registradores
	initial
	begin
	Integer = 0;
	for(index=0; index < 32; index = index + 1)begin
		Registradores[index] <= index; //No inicio da compilacao zeramos os valores dentro dos registradores(possivel lixo eletronico)
	end
	end
	
	always@(posedge Clock)begin
		if (Reg_Write == 1'b1)begin  //Se a escrita for verdadeira 
		//$display("Reg:%b",Write_Data);
		Registradores[Write_Register] = Write_Data; //Alteramos a posicao Write_Register do vetor para o que queremos escrever
		end
	end
	always@(posedge Clock)begin
		Integer += 1;
		//if (Reg_Write == 1'b1)begin  //Se a escrita for verdadeira 
		//$display("Reg:%b",Write_Data);
		//Registradores[Write_Register] = Write_Data; //Alteramos a posicao Write_Register do vetor para o que queremos escrever
		//end
	//$display("%d",Integer);
	if(Integer == 30)begin
	for(index=0; index < 32; index = index +1) begin
	//$display ("Registrador[%0d] = %d", index, Registradores[index]); //Display do valor dos resgitradores na tela
	end
	Integer = 0;
	end
	end
	

	always@(*) begin 
		 //Passado os valores de leitura para as variaveis Read_Data1 e Read_Data2
		Read_Data1 <= Registradores[Read_Register1];
		Read_Data2 <= Registradores[Read_Register2];
		//$display ("Here it is %b", Read_Data1); //Display do valor dos resgitradores na tela

	end
	

	

endmodule

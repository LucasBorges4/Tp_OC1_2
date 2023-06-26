
module Data_Mem(Clock,Address,WriteData,WriteEnable,MemRead,ReadData,Reset);
 input Clock,WriteEnable,MemRead,Reset;           
 input [31:0] Address;
 input [31:0] WriteData;  
 output reg [31:0] ReadData;
 reg [31:0] memory [0:1023]; //1024 memorias de 32 bits cada
 integer index; //index para percorrermos a memoria
initial begin
  for(index=0; index < 1024; index = index +1) begin
		memory[index] <= 0; //Quando iniciamos o codigo queremos zerar todas as memorias(evitar lixo eletronico)

	end
end

always @(posedge Clock) begin

    if(Reset == 1'b1) begin
        for(index=0; index < 1024; index = index +1) begin 

		memory[index] <= 0; //Se Reset for verdadeiro tambem queremos zerar todas as memorias
	end
    end
    if (WriteEnable) begin //Se a escrita for permitida queremos escrever em um certo endereco passada na memoria
        memory[Address] <= WriteData; 
    end else if(MemRead) begin
         ReadData <= memory[Address];
    end
//$display("Adress: %b",Address);
//$display("ReadData: %b",memory[Address]);
    end
    





endmodule

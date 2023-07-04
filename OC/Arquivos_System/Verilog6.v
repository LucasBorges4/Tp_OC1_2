module Instruction_Memory( //Memoria de instrucoes
     Instruction_Add, Instruction,Exit
);
input wire [31:0]Instruction_Add; //Endereco instrucao
output reg [31:0]Instruction; //Instrucao a ser retornada
output reg Exit;
reg [31:0]Memory[31:0]; //Memoria de instrucao(32 partes com 32 bits cada)

initial begin
        //$readmemb("TP_OC1_2//instructions.txt",Memory); //Lemos o arquivo .txt
	integer x = 0;
	for(x = 0; x < 32; x = x +1)begin
	Memory[x] = 0;
	end

	Memory[2] = 32'b00000000011100000000000100010011;
	Memory[3] = 32'b00000000001000000000001000100011;
	Memory[4]= 32'b00000000010000000000000010000011;
	Memory[5] = 32'b00000000000000001000000100110011;
	Memory[6] = 32'b00000000001000001000000010110011;
	Memory[7] = 32'b00000000001000001000000010110011;
	Memory[8] = 32'b01000000001000001000000010110011;
	Memory[9] = 32'b01000000001000001000000010110011;
	Memory[10] = 32'b00000011001000000000000010010011;

	
	

end
  always @ (Instruction_Add) begin
        Instruction <= Memory[Instruction_Add]; //Lemos a Memoria no endereco Instruction_Add
       // if(Instruction === 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)begin
         //         Exit=1'b1;
        //end else begin
         // Exit=1'b0;
        //$display("Instruct %b Instruct_Add %b\n",Instruction,Instruction_Add);
        //end
    end

endmodule 
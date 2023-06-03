module ALUControl(Operation,Funct_Code,Control); //Recebe ALUOP, e o opcode, retorna controle
	input [1:0] Operation;
	input [6:0] Opcode;
	output reg[3:0] Control;
    
    always case(Operation)
		0: Control <= 2; 
		1: Control <= 6; 
		2: 
		begin
		case(Opcode)
			32:
			begin
				Control = 2;
			end

			34:
			begin
				Control = 6;
			end
			
			36:
			begin
				Control = 0;
			end

			37:
			begin
				Control = 1;
			end
			
		endcase
		end

			
			
			
		//37: Operation<=1; //or
		//39: Operation <=12; //nor
		//42: Operation <= 7; //slt
		default: Control <= 3; //Ilegal
	endcase
endmodule
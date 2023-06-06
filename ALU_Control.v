//module Old_ALUControl(Operation,Funct_Code,Control); //Recebe ALUOP, e o opcode, retorna controle
//	input [1:0] Operation;
//	input [6:0] Opcode;
//	output reg[3:0] Control;
    
//    always case(Operation)
//		0: Control <= 2; 
//		1: Control <= 6; 
//		2: 
//		begin
//		case(Opcode)
//			32:
//			begin
//				Control = 2;
//			end
//
//			34:
//			begin
//				Control = 6;
//			end
//			
//			36:
//			begin
//				Control = 0;
//			end
//
//			37:
//			begin
//				Control = 1;
//			end
//			
//		endcase
//		end
//
			
			
			
		//37: Operation<=1; //or
		//39: Operation <=12; //nor
		//42: Operation <= 7; //slt
//		default: Control <= 3; //Ilegal
//	endcase
//endmodule

module ALUControl(Operation, Funct_Code, Control);
    input [1:0] Operation;
    input [3:0] Funct_Code;
    output reg [3:0] Control;

    always @* begin
        case (Operation)
            2'b00: Control = 4'b0010; // Operações R-type
            2'b01: Control = 4'b0110; // Operações I-type
            2'b10: begin
               case(Funct_Code)
			4'b0000:
			begin
				Control = 4'b0010;
			end
			
			4'b1000:
			begin
				Control = 4'b0110;
			end
			
			4'b0111:
			begin
				Control = 4'b0000;
			end
			
			4'b0110:
			begin
				Control = 4'b0001;
			end
		endcase	
            end
            default: Control = 4'b1111; // Ilegal
        endcase
    end
endmodule

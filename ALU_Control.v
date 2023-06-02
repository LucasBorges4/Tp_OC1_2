module ALUControl(Operation,Funct_Code,Control);
	input [1:0] Operation;
	input [5:0] Funct_Code;
	output reg[3:0] Control;
    
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
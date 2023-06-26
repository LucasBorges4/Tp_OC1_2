module ALUControl(Operation, Funct_Code, Control,Clock,Funct_3);//Recebe a Operacao ALU alem de um codigo de funcao determinado[bit 30 + 12 ao 14]
    input [1:0] Operation;
    input [3:0] Funct_Code;
	input[2:0] Funct_3;
    output reg [3:0] Control;
	
	input Clock;
    always @(*) begin
        case (Operation)
			2'b11:
			case(Funct_3)
				3'b000:
				Control = 4'b0010;
				3'b110:
				Control = 4'b0001;

			endcase


            2'b00: Control = 4'b0010; //Load e Store
            2'b01: Control = 4'b0110; //Beq
            2'b10: begin //R
               case(Funct_Code)
			4'b0101:
			 Control = 4'b1110; //Srl
			4'b0000:
			begin
				Control = 4'b0010; //Add
			end
			
			4'b1000:
			begin
				Control = 4'b0110; //Sub
			end
			
			4'b0111:
			begin
				Control = 4'b0000; //And
			end
			
			4'b0110:
			begin
				Control = 4'b0001; //Or
			end
	
		endcase	
            end
            default: Control = 4'b1111; // Ilegal
        endcase

//	$display("**%b-%b-%b",Operation,Funct_Code,Control);

    end
endmodule

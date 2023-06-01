module ALU(Control, Input1,Input2,Out,Zero);
	input [3:0] Control;
	input [31:0] Input1,Input2;
	output reg [31:0] Out;
	output Zero;
	assign Zero = (Out ==0);
	always @(Control,Input1,Input2) begin
		case(Control)
			0:Out <= Input1 & Input2; //AND
			1: Out <= Input1 | Input2; //OR
			2: Out <= Input1 + Input2;  //ADD
			6: Out <= Input1 - Input2; //SUB
			7: Out <= Input1 < Input2 ? 1 : 0; //BEQ?
			12: Out <= ~(Input1 | Input2); //NOR
			default: Out <= 0; 
		endcase

	end

endmodule

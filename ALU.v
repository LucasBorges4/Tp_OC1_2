/*
module Old_ALU(Control, Input1, Input2, Out, Zero);
	
	input [3:0] Control;
	input [31:0] Input1,Input2;

	output reg [31:0] Out;

	output Zero;
	assign Zero = (Out == 0);
	
	always @(Control,Input1,Input2) begin
		case(Control)
			0: Out <= Input1 & Input2; //AND
			1: Out <= Input1 | Input2; //OR
			2: Out <= Input1 + Input2;  //ADD
			6: Out <= Input1 - Input2; //SUB
			7: Out <= Input1 < Input2 ? 1 : 0; //BEQ?
			12: Out <= ~(Input1 | Input2); //NOR
			default: Out <= 42; 
		endcase

	end

endmodule
*/
module ALU(
    input wire [3:0] Control,
    input wire Clock,
    input wire [31:0] Input1,
    input wire [31:0] Input2,
    output reg [31:0] Out,
    output reg Zero
);

    always @(*) begin
        case (Control)
            4'b0000: Out <= Input1 & Input2; // AND
            4'b0001: Out <= Input1 | Input2; // OR
            4'b0010: Out <= Input1 + Input2; // ADD
            4'b0110: Out <= Input1 - Input2; // SUB
            4'b0111: Out <= (Input1 < Input2) ? 1 : 0; // SLT
            4'b1110: Out <= (Input1 >> Input2);
            4'b1100: Out <= ~(Input1 | Input2); // NOR
        endcase
    Zero = (Out == 0);
    //$display("ALU:%b-%b-%b-%b",Control,Input1,Input2,Out);
    end

    


endmodule

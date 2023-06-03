/*`include ".v"
`include ".v"
`include ".v"
`include ".v"*/
`include "PC.v"

module top_module (Clock, Reset, Out_signal);
	input Clock, Reset;
	wire [31:0] PCin, PCout;
	output reg Out_signal;

	PC PC_inst (.Clock(Clock), .PCin(PCin[31:0]), .PCout(PCout[31:0]));



	initial begin
		$display("Olá, mundo!");
	end
	
endmodule

module FlipFlop(Clock,Input_Data,Output_Data,Output_Bar);
	input Clock, Input_Data;
	output reg Output_Data;
	output Output_Bar;
	assign Output_Bar= ~ Output_Data;
	always @(posedge Clock)
	    Output_Data=Input_Data;
endmodule
/*Program Counter / Memoria de Instrução*/

module PC(Clock , PCin, PCout);
    input [31:0] PCin;
    input Clock;
    output reg [31:0] PCout;
	
	initial begin
		$dumpfile("PC.vcd");
		$dumpvars;
	end

endmodule

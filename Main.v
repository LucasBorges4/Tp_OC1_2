`include "Tp_OC1_2/top_module.v"

module main();
reg Clock, Reset;
wire [31:0]Result, PCOut;
wire [31:0]Instruction;

top_module tm( 
    .Clock(Clock), .Reset(Reset), .Result(Result), .Instruct(Instruction), .PCout(PCOut)
);
	
initial
begin

	//$dumpfile("main.vcd");
    //$dumpvars();
    Clock = 0;
    #100000 $finish;

end
	
always begin
	#5 Clock = ~ Clock;
end
	
endmodule
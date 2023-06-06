`include "Tp_OC1_2/top_module.v"

module main();
reg Clock, Reset;
wire [31:0]Result, PCOut;
wire [31:0]Instruction;

top_module tm( 
    .Clock(Clock), .Reset(Reset), .Result(Result), .Instruct(Instruction), .PCout(PCOut)
);

always begin
	#10 Clock = ~ Clock;
end
		
initial
begin

	$dumpfile("main.vcd");
    $dumpvars(0,main);
    Clock = 0;
    
	
    #10000 $finish;
    

end
	

endmodule
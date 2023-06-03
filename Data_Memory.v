module Data_Mem(Clock , Address, WriteData, ReadData);
    input Address;
    input WriteData;
    input ReadData;
    input Clock;

    output reg [31:0] PCout;
    
	
	initial begin
		$dumpfile("PC.vcd");
		$dumpvars;
	end

endmodule
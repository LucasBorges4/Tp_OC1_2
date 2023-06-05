module Data_Mem(Clock , Address, WriteData, ReadData);
    input Address;
    input WriteData;
    input ReadData;
    input Clock;

    output reg [31:0] PCout;
    
	
	
endmodule

module Data_Mem_Possible_Solution(Clock,Address,WriteData,WriteEnable,MemRead);
 input Clock,WriteEnable,MemRead;           
 input [31:0] Address;
 input [31:0] WriteData;  
 output reg [31:0] ReadData;
 reg [31:0] memory [0:1023];

always @(posedge Clock) begin
    if (WriteEnable) 
        memory[Address] <= WriteData;  
end

always @(posedge Clock) begin   
    if(!WriteEnable)begin
        ReadData = memory[Address];
    end
    else if(MemRead) begin
        Read_Data <= memory[Address];
    end   
end
initial begin
		$dumpfile("Data_Mem.vcd");
		$dumpvars;
	end

endmodule

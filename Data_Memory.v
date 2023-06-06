/*
module Old_Data_Mem(Clock , Address, WriteData, ReadData);
    input Address;
    input WriteData;
    input ReadData;
    input Clock;

    output reg [31:0] PCout;
    
	
	
endmodule
*/
module Data_Mem(Clock,Address,WriteData,WriteEnable,MemRead,ReadData);
 input Clock,WriteEnable,MemRead;           
 input [31:0] Address;
 input [31:0] WriteData;  
 output reg [31:0] ReadData;
 reg [31:0] memory [0:1023];
 integer index;
initial begin
  for(index=0; index < 32; index = index +1) begin
		memory[index] <= 0;
	end
end

always@(posedge Clock) begin
	
		for(index=0; index < 32; index = index +1) begin
		$display ("Memory[%0d] = %0b", index, memory[index]);
		end
	end

always @(posedge Clock) begin
    if (WriteEnable) 
        memory[Address] <= WriteData;  
end

always @(posedge Clock) begin   
    if(!WriteEnable)begin
        ReadData = memory[Address];
    end
    else if(MemRead) begin
        ReadData <= memory[Address];
    end   
end
//initial begin
//		$dumpfile("Data_Mem.vcd");
//		$dumpvars;
//	end

endmodule

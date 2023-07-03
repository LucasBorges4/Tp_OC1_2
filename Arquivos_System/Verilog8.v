module PC(PCin, Output, Clock, Reset,Branch,Zero,imm);
  input wire [31:0] PCin,imm;
  input wire Clock, Reset,Branch,Zero;
  output reg [31:0] Output;
  reg [31:0] Aux;
  
  always @(posedge Clock) begin
    if (Reset) begin
      Output <= 32'b00000000000000000000000000000000;
    end else begin 
      Output <= PCin;
    end
    //$display ("%b - %b", PCin, Output);
  end
  always@(*)begin
    if(Zero)begin
      if(Branch)begin
        Output<=PCin + imm;
        
      end
    end
  end
endmodule


 

module Refresh_PC(
	 PCin, Clock, Reset, PCout
);
input wire [31:0] PCin;
	input wire Clock,Reset;
	output reg[31:0] PCout;
initial begin
  PCout = 0;
end
	always@(posedge Clock)
	begin
		if(Reset)
			PCout <= 32'b00000000000000000000000000000000;
		else
			PCout <= PCin;
	end
endmodule
module PC_Change(PCin,Add, Branch, Clock,PCout);
  input [31:0] PCin,Add;
  input Branch, Clock;
  output reg [31:0] PCout;
  always @(posedge Clock) begin

        case (Branch)
          1'b1: PCout <= Add;
          1'b0: PCout <= PCin + 32'b00000000000000000000000000000100;
        endcase
    
      end
    
  
endmodule


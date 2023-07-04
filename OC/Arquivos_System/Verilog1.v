module Reset_Viewer(Reset,ResetB,CanReset);
input Reset;
output reg ResetB;
output reg CanReset;

always@(*) begin
if(Reset==1'b0)begin
	ResetB = 1'b1;
	CanReset = 1'b1;end
else begin
ResetB=1'b0;
CanReset = 1'b0;
end
end

endmodule
module Instruction_Viewer(Clock, Instruction, ledsout);
input [31:0] Instruction;
output reg [6:0] ledsout;
input Clock;
always @(posedge Clock) begin
    case(Instruction)
      4'h0: ledsout = 7'b1000000; // Displays 0
      4'h1: ledsout = 7'b1111001; // Displays 1
      4'h2: ledsout = 7'b0100100; // Displays 2
      4'h3: ledsout = 7'b0110000; // Displays 3
      4'h4: ledsout = 7'b0011001; // Displays 4
      4'h5: ledsout = 7'b0010010; // Displays 5
      4'h6: ledsout = 7'b0000010; // Displays 6
      4'h7: ledsout = 7'b1111000; // Displays 7
      4'h8: ledsout = 7'b0000000; // Displays 8
      4'h9: ledsout = 7'b0010000; // Displays 9
		
endcase
end
endmodule
module binarytohexadecimal(Clock,  bin1,bin2,leds1,leds2,leds3,leds4,leds5,leds6);
input [3:0] bin1,bin2;
output reg [6:0] leds1,leds2,leds3,leds4,leds5,leds6;
input Clock;

 always @(posedge Clock) begin
		leds3 = 7'b1111111;
				leds4 = 7'b1111111;
		leds5 = 7'b1111111;
		leds6 = 7'b1111111;

    case(bin1)
      4'h0: leds1 = 7'b1000000; // Displays 0
      4'h1: leds1 = 7'b1111001; // Displays 1
      4'h2: leds1 = 7'b0100100; // Displays 2
      4'h3: leds1 = 7'b0110000; // Displays 3
      4'h4: leds1 = 7'b0011001; // Displays 4
      4'h5: leds1 = 7'b0010010; // Displays 5
      4'h6: leds1 = 7'b0000010; // Displays 6
      4'h7: leds1 = 7'b1111000; // Displays 7
      4'h8: leds1 = 7'b0000000; // Displays 8
      4'h9: leds1 = 7'b0010000; // Displays 9
      4'ha: leds1 = 7'b0001000; // Displays A
      4'hb: leds1 = 7'b0000011; // Displays B
      4'hc: leds1 = 7'b1000110; // Displays C
      4'hd: leds1 = 7'b0100001; // Displays D
      4'he: leds1 = 7'b0000110; // Displays E
      4'hf: leds1 = 7'b0001110; // Displays F
		 default: leds1 = 7'b0111111; // Displays 0
		 endcase
    case(bin2)
      4'h0: leds2 = 7'b1000000; // Displays 0
      4'h1: leds2 = 7'b1111001; // Displays 1
      4'h2: leds2 = 7'b0100100; // Displays 2
      4'h3: leds2 = 7'b0110000; // Displays 3
      4'h4: leds2 = 7'b0011001; // Displays 4
      4'h5: leds2 = 7'b0010010; // Displays 5
      4'h6: leds2 = 7'b0000010; // Displays 6
      4'h7: leds2 = 7'b1111000; // Displays 7
      4'h8: leds2 = 7'b0000000; // Displays 8
      4'h9: leds2 = 7'b0010000; // Displays 9
      4'ha: leds2 = 7'b0001000; // Displays A
      4'hb: leds2 = 7'b0000011; // Displays B
      4'hc: leds2 = 7'b1000110; // Displays C
      4'hd: leds2 = 7'b0100001; // Displays D
      4'he: leds2 = 7'b0000110; // Displays E
      4'hf: leds2 = 7'b0001110; // Displays F
		 default: leds2 = 7'b0111111; // Displays 0
		 endcase
	
end
endmodule
module register_viewer(Registrador,Clock,SWs);
	output reg [17:0] SWs;
	input[17:0] Registrador;
	input wire Clock;
	always@(posedge Clock) begin
		integer i = 0;

		for(i = 0; i < 18; i = i + 1) begin
			SWs[i] <= Registrador[i];
		end
		i <= 0;
	end
endmodule
module Initial_LEDS(HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);
output reg [6:0]HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
initial begin
HEX1=7'b1111111;
HEX2=7'b1111111;
HEX3=7'b1111111;
HEX4=7'b1111111;
HEX5=7'b1111111;
HEX6=7'b1111111;
HEX7=7'b1111111;
end

endmodule


module Register_Print(Clock,LEDR,Register);
input  Clock;
input [17:0] Register;
output reg [17:0] LEDR;
always@(posedge Clock) begin
	LEDR <= Register;


end
endmodule


module Branch(
   Branch_In, Zero, Out
);
  input wire Branch_In, Zero;
  output reg Out;

always@(*)
begin
case(Branch_In)
	1'b1:
				if(Zero == 1'b0) 
				begin
					Out= 1'b0;
				end
				else
				begin
					Out = 1'b1;
				end	
	1'b0:
	begin
		Out = 1'b0;	
	end
endcase
end
endmodule



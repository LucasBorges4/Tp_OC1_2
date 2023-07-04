module Add(Input1,Input2,Soma,Clock);
input[31:0] Input1,Input2;
input Clock;
output reg [31:0] Soma;
always @(*) begin
Soma <= Input1 + Input2;
//$display("%b",Soma);
end
endmodule

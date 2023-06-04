module Add (
	x, y, soma, //overflow
);
    input [31:0] x, y;
    output [31:0] soma;
    output [1:0] overflow;
    assign soma = x + y;
    //assign overflow = (x[31] == y[31]) && (x[31] != y[31]);

endmodule


model Add_GPTSolution(Input1,Input2,Soma,Overflow);
input[31:0] Input1,Input2;
output [31:0] Soma;
output reg [1:0] Overflow;
always @* begin
Soma = Input1 + Input2;
Overflow = (Soma > 2**31-1);
end
endmodule

    //assign overflow = (x[31] == y[31]) && (x[31] != y[31]);

endmodule

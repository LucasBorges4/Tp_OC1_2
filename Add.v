module Old_Add (
	x, y, soma, //overflow
);

    input [31:0] x, y;
    output [31:0] soma;
    output [1:0] overflow;
    assign soma = x + y;
    //assign overflow = (x[31] == y[31]) && (x[31] != y[31]);

endmodule


module Add(Input1,Input2,Soma);
input[31:0] Input1,Input2;
output [31:0] Soma;
always @* begin
Soma = Input1 + Input2;
end
endmodule
    //assign overflow = (x[31] == y[31]) && (x[31] != y[31]);


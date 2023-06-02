module top_module (
	x, y, soma, //overflow
);
    input [31:0] x, y;
    output [31:0] soma;
    output [1:0] overflow;
    assign soma = x + y;
    //assign overflow = (x[31] == y[31]) && (x[31] != y[31]);

endmodule
module MUX(A, B, S, Out);
    input [31:0] A,B;
    input S;
    output [31:0] Out;
    assign Out = (S == 1'b0) ? A : B;
endmodule


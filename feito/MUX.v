module MUX(Clock, A, B, S, Out);
    input [31:0] A,B;
    input S, Clock;
    output [31:0] Out;
    assign Out = (S == 1'b0) ? A : B;
endmodule

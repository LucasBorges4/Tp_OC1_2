module MUX(A, B, S, Out,Clock);

    input [31:0] A,B;
    input S,Clock;
    output reg [31:0] Out;
    always@(*) begin

        Out <= (S == 1'b0) ? A : B;
   // $display("In: %d-%d-%d",A,B,S);
   //$display("Out: %d",Out);
    end
endmodule

module MUX_Data_Choice(A, B, S, Out,Clock,Output_ALU);

    input [31:0] A,B,Output_ALU;
    input S,Clock;
    output reg [31:0] Out;
    always@(*) begin

        Out <= (S == 1'b0) ? A : B;
    //$display("1In: %d-%d-%d",A,B,S);
   //$display("1Out: %d",Out);
    end
endmodule


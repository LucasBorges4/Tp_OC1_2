module Shift(Input,Output);
    input [31:0] Input;
    output [31:0] Output;

    assign Out = Input << 1;
    
endmodule 
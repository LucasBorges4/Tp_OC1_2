//module Old_Immediate_Generation(Input,Output);
 //   input [11:0] Input;
   // output reg[31:0] Output;
    //always @(Input) begin
     //   reg Bit_Esquerda = Input[11];

      //  if (Bit_Esquerda) begin
        //    Output = { {20{1'b1}}, Input[11:0] };
       // end else begin
         //   Output = { {20{1'b0}}, Input[11:0] };
        //end
    //end

//endmodule

module Immediate_Generation(Input,Output);
    input [11:0] Input;
    output reg [31:0] Output;
    always @(*) begin
        Output = {Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input[11], Input};
    end
    
endmodule

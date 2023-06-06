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
    input [31:0] Input;
    output reg [31:0] Output;
    reg [6:0] opcode;
    reg [11:0] immediate;
  

    always @(*) begin
     opcode= Input[31:26];
     case(opcode)
        //7'b0110011 : imeediate <= Input[]; // R
     //   7'b0000011 : immediate <= 9'b111100000; // Lw
        7'b0100011 : immediate <= {Input[6:0],Input[25:21]}; // S
       // 7'b1100011 : control <= 9'b0x0001001; // Sb
        7'b0010011 :  immediate <= Input[11:0]; // I
       // 7'b1100111 : control <= 9'b111xx0100; // Jalr
        //7'b1101111 : control <= 9'b111xx0100; // Jal
        default : immediate    <= 9'bxxxxxxxxx; //Desconhecido
    endcase
        Output = {immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate};
    end
    
endmodule

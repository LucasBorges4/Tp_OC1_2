module Immediate_Generation(Input,Output,Clock);//Recebe a instrucao inteira, pega seu imediato, e transforma esse imediato em 32 bits
    input [31:0] Input; 
    output reg [31:0] Output;
    reg [11:0] immediate;
    reg [6:0] opcode;
    input Clock;

    always @(*) begin
     opcode = Input[6:0];
    
     case(opcode) //Baseado no opcode sabemos onde esta o imediato da instrucao
        7'b1100011: immediate <= {Input[31:25], Input[11:7]}; // SB
        7'b0000011: immediate <= {Input[31:20], Input[11:0]}; // LB
        7'b0100011 : immediate <= {Input[31:25],Input[11:0]}; // S
        7'b0010011 :  immediate <= Input[31:20]; // I
      
        default : immediate    <= 12'bxxxxxxxxxx; //Desconhecido
    endcase
    //Por fim, a saida e simplesmente o imediato complemetado com 20 bits baseados no seu mais significativo[11]
        Output = {immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate[11], immediate};
        //$display("%b::%b",Input,Output);
    end
    
endmodule

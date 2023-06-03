module ALUControl(Operation, Funct_Code, Control);
    input [1:0] Operation;
    input [6:0] Funct_Code;
    output reg [3:0] Control;

    always @* begin
        case (Operation)
            2'b00: Control = 4'b0010; // Operações R-type
            2'b01: Control = 4'b0110; // Operações I-type
            2'b10: begin
                case (Funct_Code)
                    7'b1000000: Control = 4'b0010; // ADD
                    7'b1000001: Control = 4'b0110; // SUB
                    7'b1000100: Control = 4'b0011; // AND
                    7'b1000101: Control = 4'b0100; // OR
                    7'b1000110: Control = 4'b0101; // XOR
                    7'b1010100: Control = 4'b0111; // SLT
                    default: Control = 4'b0000; // Outra operação
                endcase
            end
            default: Control = 4'b1111; // Ilegal
        endcase
    end
endmodule
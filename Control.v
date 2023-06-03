module Control(Clock, Instruction, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    
    input [6:0] Instruction;
    input [1:0] Clock;

    output wire Branch, MemRead, MemToReg;
    output wire [1:0] ALUOp, MemWrite, ALUSrc, RegWrite;
    
    reg [8:0] control;
    
    assign {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Aluop} = control;
    
    always @(posedge Clock)
    begin
    case(Instruction)
        7'b0110011 : control <= 9'b001000010; // R
        7'b0000011 : control <= 9'b111100000; // Lw
        7'b0100011 : control <= 9'b1x0010000; // S
        7'b1100011 : control <= 9'b0x0001001; // Sb
        7'b0010011 : control <= 9'b101000011; // I
        7'b1100111 : control <= 9'b111xx0100; // Jalr
        7'b1101111 : control <= 9'b111xx0100; // Jal
        default : control    <= 9'bxxxxxxxxx; //Desconhecido
    endcase
end
endmodule

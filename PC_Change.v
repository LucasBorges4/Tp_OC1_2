module PC_Change(PCin, PCout, PC_Change);
    input [31:0] PCin;
    input PC_Change;
    output reg [31:0] PCout;

    always @(*) begin
        case (PC_Change)
            2'b01: PCout = PCin;
            default: PCout = PCin + 4;
        endcase
    end

   

endmodule
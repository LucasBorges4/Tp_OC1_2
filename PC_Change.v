module PC_Change(PCin, PCout, PC_Change,Branch,Clock,Reset);
     input [31:0] PCin;
    input PC_Change,Branch,Clock,Reset;
    output reg [31:0] PCout;
    initial begin
    PCout = 0;
    end
   
    always @(posedge Clock) begin
        if(Reset == 1'b1) begin
			PCout <= 0;
        end
		else begin
			PCout <= PCin;
        end
        case (PC_Change)
            1'b1: case(Branch)
                1'b1:PCout <= PCin;
                default: PCout <= PCin + 4;
    endcase
            default: PCout <= PCin + 4;
        endcase
    end

   

endmodule
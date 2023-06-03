module ALU(
    input wire [3:0] Control,
    input wire [31:0] Input1,
    input wire [31:0] Input2,
    output reg [31:0] Out,
    output wire Zero
);

    always @(Control, Input1, Input2) begin
        case (Control)
            4'b0000: Out <= Input1 & Input2; // AND
            4'b0001: Out <= Input1 | Input2; // OR
            4'b0010: Out <= Input1 + Input2; // ADD
            4'b0110: Out <= Input1 - Input2; // SUB
            4'b0111: Out <= (Input1 < Input2) ? 1 : 0; // SLT
            4'b1100: Out <= ~(Input1 | Input2); // NOR
            default: Out <= 32'b11111111111111111111111111111111; //Ilegal
        endcase
    end

    assign Zero = (Out == 0);

endmodule
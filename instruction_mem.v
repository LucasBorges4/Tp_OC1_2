module Instruction_Mem(PC, Instruction, clock, Control, Read_Register_1, Read_Register_2, Write_Register);
    input [31:0]PC;
    input [31:0]Instruction;
    input clock;

    output [6:0] Control;
    output [19:15] Read_Register_1;
    output [24:20] Read_Register_2;
    output [11:7] Write_Register;
    output [3:0] AluControl;
    
    reg [6:0] control;
    reg [19:15] read_register_1;
    reg [24:20] read_register_2;
    reg [11:7] write_register;
    reg [3:0] AluControl;

    always @(posedge clock) begin
        control = Instruction[6:0];
        read_register_1 = Instruction[19:15];
        read_register_2 = Instruction[24:20];
        write_register = Instruction[11:7];
    end

    assign Control = control;
    assign Read_Register_1 = read_register_1;
    assign Read_Register_2 = read_register_2;
    assign Write_Register = write_register;


	initial begin
		$dumpfile("instruction_mem.vcd");
		$dumpvars;
	end

endmodule
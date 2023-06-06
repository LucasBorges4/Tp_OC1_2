/*Incompleto*/
module Register(Clock,Read_Register1, Read_Register2, Reg_Write, Write_Data, Read_Data1, Read_Data2,Write_Register);
	input wire Clock;
	input wire Reg_Write;
	
	input wire [4:0] Read_Register1;
	input wire [4:0]  Read_Register2;
	input wire [4:0] Write_Register;
	input wire [31:0] Write_Data;
	output reg [31:0] Read_Data1; 
	output reg [31:0] Read_Data2;

	//reg read_register1, read_register2, write_register;
	//reg write_data;
	reg [31:0] Registradores [0:31];
	integer index;
	initial
	begin
	for(index=0; index < 32; index = index + 1)
	begin
		Registradores[index] <= 0;
	end
	end

	always@(posedge Clock) begin
	
		for(index=0; index < 32; index = index +1) begin
		$display ("Register[%0d] = %0b", index, Registradores[index]);
		end
	end
	always@(posedge Clock)begin
		if (Reg_Write == 1'b1)begin 
		Registradores[Write_Register] = Write_Data;
		end
	end

	always@(posedge Clock) begin 
		Read_Data1 = Registradores[Read_Register1];
		Read_Data2 = Registradores[Read_Register2];
	/*Retornar o resultado das saídas*/
	end
	

	//initial begin
	//	$dumpfile("Register.vcd");
	//	$dumpvars;
	//end

endmodule

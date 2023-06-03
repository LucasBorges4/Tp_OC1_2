/*Incompleto*/
module Register(Read_Register1, Read_Register2, Write_Register, Write_Data, Read_Data1, Read_Data2);
	input [4:0] Read_Register1, Read_Register2, Write_Register;
	input Write_Data; //Incompleto
	output Read_Data1, Read_Data2; //Incompleto

	reg read_register1, read_register2, write_register;
	reg write_data;

	/*Retornar o resultado das saídas*/
	

	initial begin
		$dumpfile("Register.vcd");
		$dumpvars;
	end

endmodule

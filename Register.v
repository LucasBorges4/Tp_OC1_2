/*Incompleto*/
module Register(Clock,Read_Register1, Read_Register2, Write_Register, Write_Data, Read_Data1, Read_Data2);
	input wire Clock;
	input wire [4:0] Read_Register1, Read_Register2,Write_Register;
	input wire [31:0] Write_Data;
	output reg [31:0] Read_Data1, Read_Data2; //Incompleto

	//reg read_register1, read_register2, write_register;
	reg write_data;
	reg [31:0] Registradores [31:0];
	always@(posedge Clock)begin
		if (RegWrite == 1)begin //Se RegWrite for verdadeiro,alterar registrador com os dados a serem escritos
		Registradores[Write_Register] = WriteData;
		end
	end

	always@(negedge Clock) begin 
		ReadData1 = Register[RS1];
		ReadData2 = Register[RS2];
	/*Retornar o resultado das saídas*/
	end

	initial begin
		$dumpfile("Register.vcd");
		$dumpvars;
	end

endmodule

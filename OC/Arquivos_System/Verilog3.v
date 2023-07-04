module Register (
  input wire Clock,
  input wire Reset,
  input wire Reg_Write,
  input wire [4:0] Read_Register1,
  input wire [4:0] Read_Register2,
  input wire [4:0] Write_Register,
  input wire [31:0] Write_Data,
  input wire Exit,
  output reg [31:0] Read_Data1,
  output reg [31:0] Read_Data2,
  output reg [31:0] Register_Out
);

  reg [31:0] Registradores [0:31];
  integer index;
  reg Bool = 1'b0;

  initial begin
    for (index = 0; index < 32; index = index + 1) begin
      Registradores[index] <= 0;
    end
  end

  always @(posedge Clock) begin
  if(Reset)begin
   for (index = 0; index < 32; index = index + 1) begin
      Registradores[index] <= 0;
    end
  end
  Register_Out <= Registradores[1];
    if (Reg_Write) begin
      Registradores[Write_Register] <= Write_Data;
    end

 //   if (Reset) begin
   //   for (index = 0; index < 32; index = index + 1) begin
   //     Registradores[index] <= 0;
    //  end
    //end

   // if (Exit) begin
		//if(Bool == 1'b0)begin
      //Bool <= 1'b1;
		//end
    end
  

  always @(*) begin
    Read_Data1 <= Registradores[Read_Register1];
    Read_Data2 <= Registradores[Read_Register2];
  
  end
endmodule
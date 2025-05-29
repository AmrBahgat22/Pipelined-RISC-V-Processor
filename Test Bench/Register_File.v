module Register_File(
	
	input	wire			clk   , 
	input	wire	[4:0]	A1    , //  using to read register address
	input	wire	[4:0]	A2    , //  using to read register address
	input	wire	[4:0]	A3	  , //  using to write register address
	input	wire	[31:0]  WD3	  , //  write data input
	input	wire			WE    , //  write enable 
	
	output	wire 	[31:0]	RD1   , //  read data outputs
	output	wire 	[31:0]	RD2     //  read data outputs
);

	reg	[31:0]	Reg_File	[0:31] ;

initial
begin
    Reg_File[0] = 32'b0; 
end
// synchronous " write process "
always@(posedge clk)
begin 
	if(WE && A3 != 5'b00000) begin 
		Reg_File[A3] <= WD3 ; 
	end 

end

// asynchronous " read process "

	assign RD1 = Reg_File[A1] ;
	assign RD2 = Reg_File[A2] ;




endmodule 
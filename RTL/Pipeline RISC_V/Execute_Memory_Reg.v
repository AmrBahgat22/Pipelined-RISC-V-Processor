`timescale 1ns / 1ps

module Execute_Memory_Reg(

	input	wire			clk			,
	input 	wire			mem_write_exe	,
	input 	wire			reg_write_exe	,
	input 	wire	[1:0] 	result_src_exe	,
	input 	wire	[4:0] 	rd_exe		,
	input 	wire	[31:0] 	alu_result_exe , 
	input 	wire	[31:0]	write_data_exe ,
	input 	wire	[31:0]  pc_plus_4_exe 	,
    
    output 	reg 			mem_write_m  ,
    output 	reg 			reg_write_m  ,
    output	reg 	[1:0] 	result_src_m ,
    output 	reg 	[4:0] 	rd_m		,
    output reg 		[31:0] 	alu_result_m	, 
    output reg 		[31:0] 	write_data_m	, 
    output reg 		[31:0] 	pc_plus_4_m	
);

    
    
always @(posedge clk)
begin
    alu_result_m 	<= 	alu_result_exe 	;
    write_data_m 	<= 	write_data_exe	;
    rd_m         	<= 	rd_exe			;
    pc_plus_4_m  	<= 	pc_plus_4_exe 	;
    reg_write_m  	<= 	reg_write_exe	;
    result_src_m 	<= 	result_src_exe	;
    mem_write_m  	<= 	mem_write_exe	;	  	        
end
endmodule

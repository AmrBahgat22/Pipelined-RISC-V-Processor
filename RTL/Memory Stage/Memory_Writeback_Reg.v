
module Memory_Writeback_Reg(
	input	wire			clk 		,
	input 	wire			reg_write_m	,
	input 	wire	[1:0]	result_src_m	,
	input 	wire	[4:0] 	rd_m		,
	input 	wire	[31:0]	alu_result_m	, 
	input 	wire	[31:0]	rd_m		, 
	input 	wire	[31:0]	pc_plus_4_m	,

	output 	reg 			reg_write_w	,
	output 	reg 	[1:0] 	result_src_w	,
	output 	reg 	[4:0] 	rd_w		,
	output 	reg 	[31:0] 	alu_result_w	,
	output 	reg 	[31:0] 	rd_w		, 
	output 	reg 	[31:0] 	pc_plus_4_w
);
      
always @(posedge clk)
begin
        alu_result_w 	<= alu_result_m	;	
        rd_w         	<= rd_m			;
        pc_plus_4_w    	<= pc_plus_4_m	;
        rd_w         	<= rd_m			;
        result_src_w  	<= result_src_m	;
        reg_write_w   	<= reg_write_m	;
end
endmodule

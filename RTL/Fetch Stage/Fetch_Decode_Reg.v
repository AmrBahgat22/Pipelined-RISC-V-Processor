module Fetch_Decode_Reg(
	
	input	wire				clk 		,
	input	wire				flush_d  	,
	input	wire				stall_d  	,
	input	wire	[31:0]		instr_rd_f	,
	input	wire	[31:0]		pc_f		,
	input	wire	[31:0]		pc_plus4_f	,
	
	
	
	output	reg		[31:0]	instr_rd_d	,
	output	reg		[31:0]	pc_d		,
	output	reg		[31:0]	pc_plus4_d 	 
	
	

);

always@(posedge clk)
begin 
	if(flush_d)begin
		instr_rd_d  <=	0 	;
		pc_d		<=	0	;
		pc_plus4_d	<=	0	;
	end else if (!stall_d) begin
		instr_rd_d  <=	instr_rd_f 		;
		pc_d		<=	pc_f		 	;
		pc_plus4_d	<=	pc_plus4_f  	;
	end 

end 

endmodule
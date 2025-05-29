module Decode_Execute_Reg(

	input	wire			clk             ,
    input	wire			reg_write_d 	,
							mem_write_d 	,
							jump_d			,
							branch_d		,
							alu_src_d		,
							Funct3_lsb_d    ,
							flush_exe       ,
	input	wire	[1:0]	result_src_d	,
	input	wire	[2:0]	alu_control_d	,
	input	wire	[4:0]	rs_1_d , rs_2_d ,
							rd_d			,
	input	wire	[31:0]	rd1_d  , rd2_d  ,
							pc_d			,
							imm_ext_d		,
							pc_plus4_out_d  ,
							
	output	reg				reg_write_exe 	,
							mem_write_exe 	,
							jump_exe		,
							branch_exe		,
							alu_src_exe		,
							Funct3_lsb_exe  ,
	output	reg		[1:0]	result_src_exe	,
	output	reg		[2:0]	alu_control_exe	,
	output	reg		[4:0]	rs_1_exe 		, 
							rs_2_exe 		,
							rd_exe			,
	output	reg		[31:0]	rd1_exe,rd2_exe ,
							pc_exe			,
							imm_ext_exe		,
							pc_plus4_out_exe							
);

always@(posedge clk) 
begin 
	if(flush_exe)begin
	// 32 bus 
		rd1_exe 			<= 32'b0	;
		rd2_exe 			<= 32'b0	;
		pc_exe  			<= 32'b0	;
		imm_ext_exe  		<= 32'b0	;
		pc_plus4_out_exe	<= 32'b0	;
	// 5 bus 
		rs_1_exe			<= 5'b0		;
		rs_2_exe			<= 5'b0		;
		rd_exe 				<= 5'b0		;
	// 3 bus 	
		alu_control_exe 	<= 3'b0		;
	// 2 bus 
		result_src_exe  	<= 2'b0		;
	// 1 bus 
		reg_write_exe 		<= 1'b0		;
		mem_write_exe 		<= 1'b0		;
		jump_exe			<= 1'b0		;
		branch_exe			<= 1'b0		;
		alu_src_exe			<= 1'b0		;
		Funct3_lsb_exe  	<= 1'b0		;		
	end else begin
		// 32 bus 
		rd1_exe 			<= rd1_d 			;
		rd2_exe 			<= rd2_d 			;
		pc_exe  			<= pc_d  			;
		imm_ext_exe  		<= imm_ext_d  		;
		pc_plus4_out_exe	<= pc_plus4_out_d	;
	// 5 bus 
		rs_1_exe			<= rs_1_d			;
		rs_2_exe			<= rs_2_d			;
		rd_exe 				<= rd_d				;
	// 3 bus 	
		alu_control_exe 	<= alu_control_d	;
	// 2 bus 
		result_src_exe  	<= result_src_d		;
	// 1 bus 
		reg_write_exe 		<= reg_write_d 		;
		mem_write_exe 		<= mem_write_d 		;
		jump_exe			<= jump_d			;
		branch_exe			<= branch_d			;
		alu_src_exe			<= alu_src_d		;
		Funct3_lsb_exe  	<= Funct3_lsb_d 	;	
	end
end

endmodule
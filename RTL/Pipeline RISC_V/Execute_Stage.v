module Execute_Stage(

	//Input Ports
	input	wire			reg_write_exe_in 	,
							mem_write_exe_in 	,
							jump_exe_in			,	
							branch_exe_in		,
							alu_src_exe_in		,
							funct3_lsb_exe_in  	,
	input	wire	[1:0]	result_src_exe_in	,
							sel_mux_1_exe		,
							sel_mux_2_exe		,
	input	wire	[2:0]	alu_control_exe		,
	input	wire	[4:0]	rs_1_exe_in 		, 
							rs_2_exe_in 		,
	                        rd_exe_in			,
	input	wire	[31:0]	rd1_exe_in			,
							rd2_exe_in 			,
	                        pc_exe_in			,
	                        imm_ext_exe_in		,
	                        pc_plus4_exe_in		,
							result_w			,
							alu_result_m		,
	// Output Port 
	output	wire			reg_write_exe_out	, 
	output	wire			mem_write_exe_out	, 
	output	wire			result_src_exe_lsb	,
	output	wire			pc_src_exe			,
	output	wire	[1:0] 	result_src_exe_out	,
	output 	wire 	[4:0] 	rs1_exe_out			,
							rs2_exe_out			, 
							rd_exe_out			,
	output	wire	[31:0]	alu_result_exe		, 
							write_data_exe		,
							pc_plus4_exe_out	, 
							pc_target_exe	
	
	
);

	wire			zero_exe	 	;
	wire	[31:0]	result_mux_1 	;
	wire	[31:0]	result_mux_2 	;
	wire	[31:0]	result_mux_alu 	;

	PCSrc_EXE_Generator(

		.zero_exe		(zero_exe			)	, 
		.jump_exe		(jump_exe_in		)	, 
		.branch_exe		(branch_exe_in		)	, 
		.funct3_lsb_exe	(funct3_lsb_exe_in	)	,
		
		.pc_scr_exe		(pc_src_exe			)
);

	MUX_Three_Input MUX_Three_Input_U_0(

		in_1	(rd1_exe_in					)	,
		in_2	(result_w					)	,
		in_3	(alu_result_m				)	,
		sel	 	(sel_mux_1_exe				)	,
	
		result	(result_mux_1				)
);
	MUX_Three_Input MUX_Three_Input_U_1(

		in_1	(rd2_exe_in					)	,
		in_2	(result_w					)	,
		in_3	(alu_result_m				)	,
		sel	 	(sel_mux_2_exe				)	,
	
		result	(result_mux_2				)
);
// 
	MUX_Two_Input MUX_Two_Input_U_2(

		in_1	(result_mux_2				)	,
		in_2	(imm_ext_exe_in				)	,
		sel	 	(alu_src_exe_in				)	,
	
		result	(result_mux_alu				)
);

// program counter branch "target "

PC_Branch PC_Branch_U(
	.PC 			(pc_exe_in				)	,
	.ImmExt 		(imm_ext_exe_in			)	,
	.PCTarget   	(pc_target_exe			)
);			

// ALU

ALU ALU_U(
    .in_A			(result_mux_1			)	,    
    .in_B			(result_mux_alu			)	,    
    .alu_sel		(alu_control_exe		)	,    
	
    .zero			(zero_exe				)	,       
    .alu_result 	(alu_result_exe			)	 
);
	
	//Internal Connections
      assign reg_write_exe_out  = reg_write_exe_in		;
      assign result_src_exe_out = result_src_exe_in		;
      assign mem_write_exe_out  = mem_write_exe_in		;
      
      assign rs1_exe_out 		= rs_1_exe_in			;
      assign rs2_exe_out 		= rs_2_exe_in			; 
      assign rd_exe_out 		= rd_exe_in				;
      
      assign result_src_exe_lsb = result_src_exe_in[0]	;   /* Least significant bit of ResultSrc_E*/
      assign write_data_exe 	= result_mux_2		;
      assign pc_plus4_exe_out	= pc_plus4_exe_in		;
	  
endmodule 
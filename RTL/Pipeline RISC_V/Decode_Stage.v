module Decode_Stage(
	input	wire			clk				,
	input	wire			rst_n			,
	input	wire			reg_write_w		,
	input	wire	[4:0]	rd_w			,
	input	wire	[31:0]	instr_rd_d  	,
							pc_in_d			,
                            pc_plus4_in_d  	,
							result_w    	,
							
	output	wire			reg_write_d 	,
							mem_write_d 	,
							jump_d			,
							branch_d		,
							alu_src_d		,
							Funct3_lsb_d    ,
							
	output	wire	[1:0]	result_src_d	,
							
	output	wire	[2:0]	alu_control_d	,
	
	output	wire	[4:0]	rs_1_d , rs_2_d ,
							rd_d			,
	
	output	wire	[31:0]	rd1_d  , rd2_d  ,
							pc_out_d		,
							imm_ext_d		,
							pc_plus4_out_d

);    

// Internal wires

// 1) Dclear Extend Unit
Extend_Unit Extend_Unit_U(
	.instr			(instr_rd_d[31:7]	) 	,        
	.immsrc			(immsrc				) 	,        	
	.immext     	(immext				)        	
);

// 2) Dclear Register File
Register_File Register_File_U(
	.clk 			(clk				)  	, 
	.A1  			(instr_rd_d[19:15]	)  	, 
	.A2  			(instr_rd_d[24:20]	) 	, 
	.A3	 			(rd_w				)	, 
	.WD3			(result_w			)	, 
	.WE  			(reg_write_w		)  	, 
	.RD1 			(in_A				)  	, 
	.RD2 			(RD2				)    
	
);

// 3 )Dclear Controller Unit
Controller_Unit Controller_Unit_U(
	.Zero			(Zero				)	,
    .Instr      	(instr_rd_d			)	,
    .MemWrite   	(mem_write_d		)	,
    .RegWrite   	(reg_write_d		)	,
    .ImmSrc     	(immsrc				)	,
    .ALUSrc     	(alu_src_d			)	,
    .ALUControl 	(alu_control_d		)	,
    .ResultSrc  	(result_src_d		)	,
	.Jump			(jump_d   			)   ,
	.Branch         (branch_d 			)
);

	assign 	pc_out_d 		= pc_in_d 				;
	assign 	pc_out_d 		= pc_plus4_in_d 		;
	assign	Funct3_lsb_d	= instr_rd_d[12] 		;
	assign	rs_1_d			= instr_rd_d[19:15] 	;
	assign 	rs_2_d			= instr_rd_d[24:20]		;
	assign 	Rd_D			= instr_rd_d[11:7]		;
	assign	pc_plus4_out_d  = pc_plus4_in_d         ;
	
	
endmodule
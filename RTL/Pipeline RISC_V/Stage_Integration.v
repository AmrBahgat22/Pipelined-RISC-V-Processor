module Stage_Integration(

    //Input Ports
    input	wire 			clk				, 
    input	wire 			rst_n			, 
    input	wire 			Stall_F			, 
    input	wire 			Flush_D			, 
    input	wire 			Stall_D			,
    input	wire 			Flush_E			,
    input 	wire	[1:0]	ForwardA_E		, 
    input 	wire	[1:0]	ForwardB_E		,
       
    //Output Ports
    output	wire 			PCSrc_E_out		, 
    output 	wire  			ResultSrc_E_lsb	, 
    output 	wire  			RegWrite_M_out	, 
    output 	wire  			RegWrite_W_out	,
    output 	wire 	[4:0] 	Rs1_D_out		, 
    output 	wire 	[4:0] 	Rs2_D_out		,  
    output 	wire 	[4:0] 	Rs1_E_out		, 
    output 	wire 	[4:0] 	Rs2_E_out		, 
    output 	wire 	[4:0] 	Rd_E_out		, 
    output 	wire 	[4:0] 	Rd_M_out		, 
    output 	wire 	[4:0] 	Rd_W_out 	
         

);
	//Internal wires
/*Fetch Stage Internal wires*/
	
	wire			PCSrcE 		;
	wire	[31:0]	PCTarget 	;
	wire	[31:0]	instr_rd_f 	;
	wire	[31:0]	pc_f	 	;
	wire	[31:0]	pc_plus4_f	;

/*Decode Stage Internal wires*/
	
	wire			reg_write_w 	;
	wire			reg_write_d 	;
	wire			mem_write_d 	;
	wire			jump_d			;
	wire			branch_d		;
	wire			alu_src_d		;
	wire			Funct3_lsb_d	;
	wire	[1:0]	result_src_d	;
	wire	[2:0]	alu_control_d	;
	wire	[4:0]	rd_w			;
	wire	[4:0]	rs_1_d			;
	wire	[4:0]	rs_2_d			;
	wire	[4:0]	rd_d			;
	wire	[31:0]	instr_rd_d		;
	wire	[31:0]	pc_d			;
	wire	[31:0]	pc_plus4_d		;
	wire	[31:0]	result_w		;
	wire	[31:0]	rd1_d			;
	wire	[31:0]	rd2_d			;
	wire	[31:0]	pc_out_d		;
	wire	[31:0]	imm_ext_d		;
	wire	[31:0]	pc_plus4_out_d	;
	
	
/*Execute Stage Internal wires*/
	
	wire			reg_write_exe 		;
	wire			mem_write_exe 		;
	wire			jump_exe      		;
	wire			branch_exe    		;
	wire			Funct3_lsb_exe 		;
	wire			alu_src_exe   		;
	wire			reg_write_exe_out	;
	wire			mem_write_exe_out  	;
	wire	[1:0]	result_src_exe		;
	wire	[1:0]	result_src_exe_out	;
	wire	[2:0]	alu_control_exe		;
	wire	[4:0]	rs_1_exe			;
	wire	[4:0]	rs_2_exe			;
	wire	[4:0]	rd_exe				;
	wire	[4:0]	rd_exe_out			;
	wire	[31:0]	rd1_exe				;
	wire	[31:0]	rd2_exe				;
	wire	[31:0]	pc_exe				;
	wire    [31:0]	imm_ext_exe			;
	wire    [31:0]  pc_plus4_out_exe	;
	wire    [31:0]  alu_result_m		;
	wire    [31:0]  alu_result_exe		;
	wire    [31:0]  write_data_exe		;
	wire    [31:0]  pc_plus4_exe_out	;
	

/*Memory Stage Internal wires*/
	
	wire			reg_write_m			;
	wire			result_src_m		;
	wire			mem_write_m			;
	wire			reg_write_m_out		;
	wire	[1:0]	result_src_m_out	;
	wire	[4:0]	rd_m				;
	wire	[4:0]	rd_m_out			;
	wire	[31:0]	write_data_m		;
	wire	[31:0]	pc_plus_4_m			;
	wire	[31:0]	alu_result_m_out	;
	wire	[31:0]	read_data_m			;
	wire	[31:0]	pc_plus_4_m_out		;
	
/*WriteBack Stage Internal wires*/

	wire	[1:0]	result_src_w		;
	wire	[31:0]	alu_result_w		;
	wire	[31:0]	read_data_w			;
	wire	[31:0]	pc_plus_4_w			;
//Blocks Instantiation
	// 1) Fetch Stage 
	Fetch_Stage	Fetch_Stage_U (

		.clk				(clk			)	,
		.rst_n 				(rst_n			)	,
		.PCSrcE				(PCSrcE			)	,
		.StallF				(Stall_F		)	,
		.PCTarget			(PCTarget		)	,
				
				
		.instr_rd_f			(instr_rd_f		)	,
		.pc_f				(pc_f			)	, 
		.pc_plus4_f 		(pc_plus4_f		)
);
	
	// 1.1) Fetch to Decode Register

	Fetch_Decode_Reg Fetch_Decode_Reg_U(
	
		.clk 				(clk			)	,
		.flush_d  			(Flush_D		)	,
		.stall_d  			(Stall_D		)	,
		.instr_rd_f			(instr_rd_f		)	,
		.pc_f				(pc_f			)	,
		.pc_plus4_f			(pc_plus4_f		)	,
				
		.instr_rd_d			(instr_rd_d		)	,
		.pc_d				(pc_d			)	,
		.pc_plus4_d 		(pc_plus4_d		)		 		
);

	// 2) Decode Stage 
	Decode_Stage Decode_Stage_U(
		.clk				(clk				)	,
		.rst_n				(rst_n				)	,
		.reg_write_w		(reg_write_w		)	,
		.rd_w				(rd_w				)	,
		.instr_rd_d  		(instr_rd_d			)	,
		.pc_in_d			(pc_d				)	,
		.pc_plus4_in_d  	(pc_plus4_d			)	,
		.result_w    		(result_w			)	,
			
		.reg_write_d 		(reg_write_d		)	,
		.mem_write_d 		(mem_write_d		)	,
		.jump_d				(jump_d				)	,
		.branch_d			(branch_d			)	,
		.alu_src_d			(alu_src_d			)	,
		.Funct3_lsb_d   	(Funct3_lsb_d		)	,
	
		.result_src_d		(result_src_d		)	,
		.alu_control_d		(alu_control_d		)	,
		.rs_1_d 			(rs_1_d				)	, 
		.rs_2_d 			(rs_2_d				)	,
		.rd_d				(rd_d				)	,
		.rd1_d  			(rd1_d				)	,	 
		.rd2_d  			(rd2_d				)	,
		.pc_out_d			(pc_out_d			)	,
		.imm_ext_d			(imm_ext_d			)	,
		.pc_plus4_out_d		(pc_plus4_out_d		)	
		
);    

	assign Rs1_D_out = rs_1_d ;
	assign Rs2_D_out = rs_2_d ;
	
	
	// 2.1) Decode to Execute Register 
	Decode_Execute_Reg Decode_Execute_Reg_U(

		.clk            	(clk				)	,
		.reg_write_d 		(reg_write_d		)	,
		.mem_write_d 		(mem_write_d		)	,
		.jump_d				(jump_d				)	,
		.branch_d			(branch_d			)	,
		.alu_src_d			(alu_src_d			)	,
		.Funct3_lsb_d   	(Funct3_lsb_d		)	,
		.flush_exe      	(Flush_E			)	,
		.result_src_d		(result_src_d		)	,
		.alu_control_d		(alu_control_d		)	,
		.rs_1_d 			(rs_1_d				)	, 
		.rs_2_d 			(rs_2_d				)	,
		.rd_d				(rd_d				)	,
		.rd1_d  			(rd1_d				)	,
		.rd2_d  			(rd2_d				)	,
		.pc_d				(pc_d				)	,
		.imm_ext_d			(imm_ext_d			)	,
		.pc_plus4_out_d 	(pc_plus4_out_d		)  ,
								
		.reg_write_exe 		(reg_write_exe		)	,
		.mem_write_exe 		(mem_write_exe		)	,
		.jump_exe			(jump_exe			)	,
		.branch_exe			(branch_exe			)	,
		.alu_src_exe		(alu_src_exe		)	,
		.Funct3_lsb_exe 	(Funct3_lsb_exe		)	,
		.result_src_exe		(result_src_exe		)	,
		.alu_control_exe	(alu_control_exe	)	,
		.rs_1_exe 			(rs_1_exe			)	, 
		.rs_2_exe 			(rs_2_exe			)	,
		.rd_exe				(rd_exe				)	,
		.rd1_exe			(rd1_exe			)	,
		.rd2_exe 			(rd2_exe			)	,
		.pc_exe				(pc_exe				)	,
		.imm_ext_exe		(imm_ext_exe		)	,
		.pc_plus4_out_exe	(pc_plus4_out_exe	)							
);
	// 3)Execute Stage 
	Execute_Stage Execute_Stage_U(
	
	//Input Ports
		.reg_write_exe_in 	(reg_write_exe		)	,
		.mem_write_exe_in 	(mem_write_exe		)	,
		.jump_exe_in		(jump_exe			)	,	
		.branch_exe_in		(branch_exe			)	,
		.alu_src_exe_in		(alu_src_exe		)	,
		.funct3_lsb_exe_in  (Funct3_lsb_exe		)	,
		.result_src_exe_in	(result_src_exe		)	,
		.sel_mux_1_exe		(ForwardA_E			)	,
		.sel_mux_2_exe		(ForwardB_E			)	,
		.alu_control_exe	(alu_control_exe	)	,
		.rs_1_exe_in 		(rs_1_exe			)	, 
		.rs_2_exe_in 		(rs_2_exe			)	,
		.rd_exe_in			(rd_exe				)	,
		.rd1_exe_in			(rd1_exe			)	,
		.rd2_exe_in 		(rd2_exe			)	,
		.pc_exe_in			(pc_exe				)	,
		.imm_ext_exe_in		(imm_ext_exe		)	,
		.pc_plus4_exe_in	(pc_plus4_out_exe	)	,
		.result_w			(result_w			)	,
		.alu_result_m		(alu_result_m		)	,
	// Output Port 
		.reg_write_exe_out	(reg_write_exe_out	)	, 
		.mem_write_exe_out	(mem_write_exe_out	)	, 
		.result_src_exe_lsb	(ResultSrc_E_lsb	)	,
		.pc_src_exe			(PCSrcE				)	,
		.result_src_exe_out	(result_src_exe_out	)	,
		.rs1_exe_out		(Rs1_E_out			)	,
		.rs2_exe_out		(Rs2_E_out			)	, 
		.rd_exe_out			(rd_exe_out			)	,
		.alu_result_exe		(alu_result_exe		)	, 
		.write_data_exe		(write_data_exe		)	,
		.pc_plus4_exe_out	(pc_plus4_exe_out	)	, 
		.pc_target_exe	    (PCTarget			)	
		
);
	assign  Rd_E_out 	= rd_exe_out	;                                                                       
    assign  PCSrc_E_out = PCSrcE 		;
	
	// 3.1) Execute to Memory Register
	Execute_Memory_Reg Execute_Memory_Reg_U(

		.clk				(clk				)	,
		.mem_write_exe		(mem_write_exe_out	)	,
		.reg_write_exe		(reg_write_exe_out	)	,
		.result_src_exe		(result_src_exe_out	)	,
		.rd_exe				(rd_exe_out			)	,
		.alu_result_exe 	(alu_result_exe		)	, 
		.write_data_exe 	(write_data_exe		)	,
		.pc_plus_4_exe 		(pc_plus4_exe_out	)	,
    
		.mem_write_m  		(mem_write_m		)	,
		.reg_write_m  		(reg_write_m		)	,
		.result_src_m 		(result_src_m				)	,
		.rd_m				(rd_m				)	,
		.alu_result_m		(alu_result_m		)	, 
		.write_data_m		(write_data_m		)	, 
		.pc_plus_4_m		(pc_plus_4_m		)	
);
	// 4) Memory Stage 
	Memory_Stage Memory_Stage_U(
	
	  //Input Ports
		.clk				(clk				)	,			
		.reg_write_m_in		(reg_write_m		)	,
		.mem_write_m		(mem_write_m		)	, 
		.result_src_m_in	(result_src_m		)	,
		.rd_m_in			(rd_m				)	,
		.alu_result_m_in	(alu_result_m		)	, 
		.write_data_m		(write_data_m		)	, 
		.pc_plus_4_m_in		(pc_plus_4_m		)	,

    //output ports
		.reg_write_m_out	(reg_write_m_out	)	,
		.result_src_m_out	(result_src_m_out	)	,
		.rd_m_out			(rd_m_out			)	,
		.alu_result_m_out	(alu_result_m_out	)	,
		.read_data_m		(read_data_m		)	, 
		.pc_plus_4_m_out    (pc_plus_4_m_out	)
);
	
	
	assign Rd_M_out	 		= rd_m_out			;    
	assign RegWrite_M_out 	= reg_write_m_out	;
    
	
	// 4.1) Memory to write_back regsiter
	Memory_Writeback_Reg Memory_Writeback_Reg_U(
		.clk 				(clk				)	,
		.reg_write_m		(reg_write_m_out	)	,
		.result_src_m		(result_src_m_out	)	,
		.rd_m				(rd_m_out			)	,
		.alu_result_m		(alu_result_m_out	)	, 
		.read_m				(read_data_m		)	, 
		.pc_plus_4_m		(pc_plus_4_m_out	)	,

		.reg_write_w		(reg_write_w		)	,
		.result_src_w		(result_src_w		)	,
		.read_w				(read_data_w		)	,
		.alu_result_w		(alu_result_w		)	,
		.rd_w				(rd_w				)	, 
		.pc_plus_4_w   		(pc_plus_4_w		)	
);
	// 5) write_back Stage 
	
	Write_Back_Stage Write_Back_Stage_U(
	
	//input ports
		.reg_write_w_in		(reg_write_w		)	,
		.result_src_w		(result_src_w		)	,
		.alu_result_w		(alu_result_w		)	, 
		.read_data_w		(read_data_w		)	, 
		.pc_plus_4_w		(pc_plus_4_w		)	,
        
    //oitput ports
		.reg_write_w_out	(RegWrite_W_out		)	,
		.result_w			(result_w			)
    );    
      
endmodule
        
   
module Pipeline_RISC_V(
            
	input	wire	clk		,
	input 	wire 	rst_n
);
	//internal wires
         wire			Stall_F			;
         wire 			Flush_D			;
         wire 			Stall_D			;
         wire 			Flush_E			;
         wire 			PCSrc_E_out		;
         wire 			ResultSrc_E_lsb	;
         wire 			RegWrite_M_out	;
         wire 			RegWrite_W_out	;
		 wire	[1:0]	ForwardA_E		;
		 wire 	[1:0] 	ForwardB_E		;
		 wire 	[4:0] 	Rs1_D_out		;
		 wire 	[4:0] 	Rs2_D_out		;
		 wire 	[4:0] 	Rd_W_out		;
		 wire 	[4:0] 	Rd_M_out		;
		 wire 	[4:0] 	Rd_E_out		;
		 
	Stage_Integration Stage_Integration_U(

    //Input Ports
		.clk			(clk				)	, 
		.rst_n			(rst_n				)	, 
		.Stall_F		(Stall_F			)	, 
		.Flush_D		(Flush_D			)	, 
		.Stall_D		(Stall_D			)	,
		.Flush_E		(Flush_E			)	,
		.ForwardA_E		(ForwardA_E			)	, 
		.ForwardB_E		(ForwardB_E			)	,
       
    //Output Ports
		.PCSrc_E_out	(PCSrc_E_out		)	, 
		.ResultSrc_E_lsb(ResultSrc_E_lsb	)	, 
		.RegWrite_M_out	(RegWrite_M_out		)	, 
		.RegWrite_W_out	(RegWrite_W_out		)	,
		.Rs1_D_out		(Rs1_D_out			)	, 
		.Rs2_D_out		(Rs2_D_out			)	,  
		.Rs1_E_out		(Rs1_E_out			)	, 
		.Rs2_E_out		(Rs2_E_out			)	, 
		.Rd_E_out		(Rd_E_out			)	, 
		.Rd_M_out		(Rd_M_out			)	, 
		.Rd_W_out 		(Rd_W_out			)
         
);

	Hazard_Unit Hazard_Unit_U(

		.reset			(rst_n				)	,  
		.rs_1_d			(Rs1_D_out			)	, 
		.rs_2_d			(Rs2_D_out			)	,
		.rd_exe			(Rd_E_out			)	, 
		.rs_1_exe		(Rs1_E_out			)	, 
		.rs_2_exe		(Rs2_E_out			)	,
		.pc_src_exe		(PCSrc_E_out		)	, 
		.result_src_exe	(ResultSrc_E_lsb	)	, 
		.reg_write_m	(RegWrite_M_out		)	, 
		.reg_write_w	(RegWrite_W_out		)	,
		.rd_m			(Rd_M_out			)	,
		.rd_w			(Rd_W_out			)	,
	
	
		.stall_f		(Stall_F			)	, 
		.stall_d		(Flush_D			)	,	 
		.flush_d		(Stall_D			)	,	 
		.flush_exe		(Flush_E			)	,
		.ForwardAE		(ForwardA_E			)	, 
		.ForwardBE      (ForwardB_E			)
);

endmodule
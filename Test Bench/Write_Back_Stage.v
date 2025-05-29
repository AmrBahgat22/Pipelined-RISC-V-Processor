module Write_Back_Stage(
	
	//input ports
    input	wire 			reg_write_w_in		,
    input 	wire	[1:0] 	result_src_w		,
    input 	wire 	[31:0] 	alu_result_w		, 
    input 	wire 	[31:0] 	read_data_w			, 
    input 	wire 	[31:0]	pc_plus_4_w			,
        
    //oitput ports
    output	wire 			reg_write_w_out		,
    output 	wire 	[31:0] 	result_w			
        
);
	MUX_Three_Input JLMUX(
		
		.in_1	(alu_result_w	)	,
		.in_2	(read_data_w	)	,
		.in_3	(pc_plus_4_w	)	,
		.sel	(result_src_w	) 	,

		.result (result_w		)
	);

	assign reg_write_w_out = reg_write_w_in ;
endmodule
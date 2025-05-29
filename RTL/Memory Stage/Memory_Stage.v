module Memory_Stage(
	
	  //Input Ports
    input 	wire 			clk					,			
    input	wire 			reg_write_m_in		,
    input 	wire 			mem_write_m			, 
    input 	wire 	[1:0]	result_src_m_in		,
    input 	wire 	[4:0] 	rd_m_in				,
    input 	wire	[31:0] 	alu_result_m_in		, 
    input 	wire	[31:0] 	write_data_m		, 
    input 	wire	[31:0] 	pc_plus_4_m_in		,

    //output ports
    output 	wire 			reg_write_m_out		,
    output 	wire 	[1:0] 	result_src_m_out	,
    output 	wire 	[4:0] 	rd_m_out			,
    output 	wire 	[31:0] 	alu_result_m_out	,
    output 	wire 	[31:0] 	read_data_m			, 
    output 	wire 	[31:0] 	pc_plus_4_m_out
	
);
    //Blocks Instantiation
    Data_Memory data_memory (
        .clk	(clk			),
        .WE		(mem_write_m		),
        .A		(alu_result_m_in	),
        .WD		(write_data_m		),
        .RD		(read_data_m		)
);
    
    assign reg_write_m_out = reg_write_m_in;
    assign result_src_m_out = result_src_m_in;
    assign alu_result_m_out = alu_result_m_in;
    assign rd_m_out = rd_m_in;
    assign pc_plus_4_m_out = pc_plus_4_m_in;

endmodule 
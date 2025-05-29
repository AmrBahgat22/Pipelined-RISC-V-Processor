module Fetch_Stage (

	input	wire				clk			,
	input	wire				rst_n 		,
    input 	wire				PCSrcE		,
    input 	wire				StallF		,
    input 	wire		[31:0] 	PCTarget	,
	
	
    output 	wire		[31:0] 	instr_rd_f	,
    output 	wire		[31:0] 	pc_f		, 
	output	wire		[31:0]	pc_plus4_f

);
	
	wire	[31:0]	PCPlus4		;
	wire	[31:0]	in_pc   	;
	wire	[31:0]	out_pc  	;
	wire	[31:0]	instruction ;
	

// 1) Declare first Multiplexer 
MUX MUX_U_1(
	.in_1			(PCPlus4			)	,
    .in_2			(PCTarget			)	,
    .sel 			(PCSrcE				)	,
    .out       		(in_pc				)  
);

// 2) Declare Program counter 
Program_Counter Program_Counter_U(
	
	.clk 			(clk				)	, 
	.rst_n 			(rst_n				)	,
	.enable			(StallF				)	,
	.in_pc 			(in_pc				)	,
	.out_pc 		(out_pc				)

);

// 3) Declare Instruction Memory
Instruction_Memory Instruction_Memory_U (
	.instr_address	(out_pc				) 	,
	.instruction  	(instruction		)  
);

// 4) Declare Program Counter Plus 4
PC_Plus_4 PC_Plus_4_U(
	.PC 			(out_pc				) 	,
	.PCPlus4 		(PCPlus4			)
	
);
	assign 	pc_f 		= out_pc 	  ;
	assign	pc_plus4_f 	= PCPlus4 	  ;
	assign	instr_rd_f    = instruction ;

		
endmodule
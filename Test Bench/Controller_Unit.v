module Controller_Unit(
    // input-output ports
    // input  wire 		Zero		,
    input  wire [31:0] 	Instr       ,
	
    output wire  		MemWrite    ,
    output wire  		RegWrite    ,
    output wire [1:0] 	ImmSrc      ,
    output wire  		ALUSrc      ,
    output wire [2:0] 	ALUControl  ,
    output wire [1:0] 	ResultSrc   ,

    output wire  		Jump        ,       
    output wire  		Branch               
);
    
    //internal signals
   // wire 			Jump, Branch	;
    wire	[1:0] 	AluOp			;
   
    //main decoder instantiation
    Main_Decoder Main_Decoder_U(
            .opcode		(Instr[6:0]	)	, 
            .Jump		(Jump		)	, 
            .Branch		(Branch		)	, 
            .MemWrite	(MemWrite	)	, 
            .RegWrite	(RegWrite	)	, 
            .AluSrc		(ALUSrc		)	, 
            .ImmSrc		(ImmSrc		)	, 
            .ResultSrc	(ResultSrc	)	, 
            .AluOp		(AluOp		)
        );
		
    
    //ALU Decoder instantiation
    ALU_Decoder ALU_Decoder_U (
        .opcode		(Instr[5]		)	,
        .funct3		(Instr[14:12]	)	, 
        .funct7b5	(Instr[30]		)	,
        .ALUOp		(AluOp			)	, 
        .ALUControl	(ALUControl		)
    );

endmodule 
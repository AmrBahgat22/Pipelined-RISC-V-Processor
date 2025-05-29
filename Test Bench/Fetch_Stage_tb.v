module Fetch_Stage_tb ();

	reg				clk		;
	reg				rst_n 	;
    reg				PcSrc	;
    reg				StallF	;
    reg		[31:0] 	PCTarget;
	
	
    wire 	[31:0] 	Instr_RD	;
    wire 	[31:0] 	PCD		;
	wire	[31:0]	PCPlus4D;

	// Instantiate DUT (Device Under Test)
	Fetch_Stage DUT(
		.clk		(clk		),
		.rst_n 		(rst_n 		),
		.PcSrc	    (PcSrc		),
		.StallF		(StallF		),
		.PCTarget   (PCTarget	),
		.Instr_RD	(Instr_RD	),
		.PCD		(PCD		),
	    .PCPlus4D   (PCPlus4D	)
	); 

	// Clock generation
	always #10 clk = ~clk;
	initial clk = 1'b0; // Set initial value

	// Initial block for initialization and test duration
	initial begin 
		rst_n = 1'b1;
	    PcSrc = 1'b0; 
		StallF = 1'b0;  
		PCTarget = 32'b00100; 
		#20;
		rst_n = 1'b0;
        PcSrc = 1'b0; 
		StallF = 1'b0;  
		PCTarget = 32'b00100;
		#20;
		rst_n = 1'b0;
        PcSrc = 1'b0; 
		StallF = 1'b0; 
		PCTarget = 32'b00100; 
		#20;
		rst_n = 1'b0; 
        PcSrc = 1'b0; 
		StallF = 1'b0; 
		PCTarget = 32'b00100; 
		#20;
		rst_n = 1'b0;
        PcSrc = 1'b0; 
		StallF = 1'b1;  
		PCTarget = 32'b00100;
		#20;
		rst_n = 1'b0;
        PcSrc = 1'b0; 
		StallF = 1'b0; 
		PCTarget = 32'b00100; 
		#20;
		rst_n = 1'b0; 
        PcSrc = 1'b1; 
		StallF = 1'b0; 
		PCTarget = 32'b10000; 
		#20;
		rst_n = 1'b0;
        PcSrc = 1'b0; 
		StallF = 1'b0; 
		PCTarget = 32'b00100; 
		#300;
             
		$stop;
	end

endmodule

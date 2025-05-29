module Instruction_Memory(

	input	wire	[31:0]	instr_address ,
	
	output	reg		[31:0]	instruction     
);

	
	reg [31:0] mem [0:32];  

    // Initialize memory (load from file or hardcoded)
    initial begin
        $readmemh("inst_mem.txt",mem);  // Load instructions from file
		instruction = 0 ;
    end
	
always@(*)
begin
	instruction = mem[instr_address[31:2]];  // Word-aligned read
end
/*
assign instruction = mem[instr_address<<2];
*/
endmodule
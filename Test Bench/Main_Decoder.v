module Main_Decoder(

    input	wire	[6:0]	opcode		,      
	
    output 	wire 			Branch		,       
    output 	wire 	[1:0]	ResultSrc	,      
    output 	wire 			MemWrite	,     	
    output 	wire 			AluSrc		,     	
    output 	wire 			Jump		,     	
    output 	wire 	[1:0]	ImmSrc		,     	
    output 	wire 			RegWrite	,       
    output 	wire 	[1:0] 	AluOp	  		

);
	reg [10:0] controller;
    assign {RegWrite,ImmSrc,AluSrc,MemWrite,ResultSrc,Branch,AluOp,Jump} = controller;

always@(*) begin
	case (opcode)
	
		7'b0000011: controller = 11'b10010010000;    // Load   (lw)
        7'b0100011: controller = 11'b00111xx0000;    // Store  (sw)								
        7'b0110011: controller = 11'b1xx00000100;    // R-type (add/sub/sll/srl/and/or/xor)		
        7'b1100011: controller = 11'b01000xx1010;    // Branch (beq/bne)						
        7'b0010011: controller = 11'b10010000100;    // I-type (addi/slli/srli/andi/ori/xori)
        7'b1101111: controller = 11'b111x0100xx1;    // Jump   (jal)								
		
        default:    controller = 11'b00000000000;    // Default (invalid)						
	
	endcase
end

endmodule 
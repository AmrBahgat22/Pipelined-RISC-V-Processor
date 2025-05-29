module ALU (
    input  wire [31:0] in_A,       // First input
    input  wire [31:0] in_B,       // Second input
    input  wire [2:0]  alu_sel,    // ALU operation selector

    output reg         zero,       // Zero flag
    output reg [31:0]  alu_result  // Result
);
initial begin 
	alu_result = 0;
	zero = 0;
end 
always @(*) begin
    case (alu_sel)
		// ADD
        3'b000: alu_result = in_A + in_B;       
		// SUB
        3'b001: alu_result = in_A - in_B;       	

		// AND
        3'b010: alu_result = in_A & in_B ; 
        
		// OR gate
		3'b011: alu_result = in_A | in_B ;
		
		// XOR gate 
		3'b100: alu_result = in_A ^ in_B ;
		
		// SLT (Set Less Than)
		3'b101: alu_result = (in_A < in_B) ? 1 : 0 ;
		
		// Shift Left Logical (SLL)
		3'b110:  alu_result = in_A << in_B ;  
		
		// Shift Right Logical (SRL)
		3'b111:  alu_result = in_A >> in_B ;
		
		default: alu_result = 32'bx;
    endcase

    zero = (alu_result == 32'd0) ? 1'b1 : 1'b0;
end

endmodule

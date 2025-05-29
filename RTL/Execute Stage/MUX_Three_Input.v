module MUX_Three_Input(

	input	wire	[31:0]	in_1	,
    input	wire	[31:0]	in_2	,
    input	wire	[31:0]	in_3	,
    input 	wire 	[1:0] 	sel	 	,
	
    output 	reg 	[31:0] result
);
    
always @(*) begin
    case (sel)
	
        2'b00: 	 result 	= in_1		; 
        2'b01: 	 result 	= in_2		;   
        2'b10: 	 result 	= in_3		;     
        default: result     = 32'b0		; 
		
    endcase
end
    
endmodule

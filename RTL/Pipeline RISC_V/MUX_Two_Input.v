module MUX_Two_Input(
   
	input	wire [31:0] 	in_1		,
    input 	wire [31:0] 	in_2		,
    input 	wire 			sel 		,

    output wire [31:0] 		result
);

	assign result = (sel) ? in_2 : in_1;

endmodule

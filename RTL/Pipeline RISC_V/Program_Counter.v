module Program_Counter(
	
	input	wire			clk , rst_n ,
	input	wire	[31:0]	in_pc ,
	input	wire			enable ,
	
	output	reg		[31:0]	out_pc 

);

always@(posedge clk or negedge rst_n)	
begin 
	if(!rst_n) begin
		out_pc <= 0 ;
	end else if (!enable) begin
		out_pc <= in_pc ;
	end
end

endmodule 
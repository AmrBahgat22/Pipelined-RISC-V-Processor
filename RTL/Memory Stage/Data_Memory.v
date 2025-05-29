module Data_Memory (

    input  wire        clk,
    input  wire [31:0] A,      // Address input (byte address)
    input  wire [31:0] WD,     // Write data input
    input  wire        WE,     // Write enable
	
    output reg  [31:0] RD      // Read data output
);
	// Memory declaration
    reg [31:0] RAM [0:127];    // 128 words = 512 bytes


// Write to memory
always @(posedge clk) begin
	if(WE) begin
		RAM[A[31:2]] <= WD ;
	end
end

   // Asynchronous read  && Continuous assignment for read data
always @(*) begin
    RD = RAM[A[31:2]];	// Word-aligned read
end

endmodule

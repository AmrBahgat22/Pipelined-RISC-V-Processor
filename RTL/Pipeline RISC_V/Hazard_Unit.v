module Hazard_Unit(

    input	wire			reset						,  
    input  	wire	[4:0]	rs_1_d, rs_2_d				,
    input  	wire	[4:0] 	rd_exe, rs_1_exe, rs_2_exe	,
    input  	wire			pc_src_exe, result_src_exe	, reg_write_m, reg_write_w,
    input  	wire	[4:0] 	rd_m, rd_w					,
	
	
    output 	wire			stall_f, stall_d, flush_d, flush_exe,
    output 	reg 	[1:0] 	ForwardAE, ForwardBE
);

    reg lw_stall;
    reg stall_d_i, flush_d_i, flush_exe_i; 
    wire stall_f_i;
    
    // Forwarding logic for rs_1_exe
    always @(*) begin
        if (((rs_1_exe == rd_m) & reg_write_m) & (rs_1_exe != 0)) 
            ForwardAE = 2'b10; // Forward from Memory Stage
        else if (((rs_1_exe == rd_w) & reg_write_w) & (rs_1_exe != 0))
            ForwardAE = 2'b01; // Forward from Writeback Stage
        else 
            ForwardAE = 2'b00; // No Forwarding
    end
    
    // Forwarding logic for rs_2_exe
    always @(*) begin
        if (((rs_2_exe == rd_m) & reg_write_m) & (rs_2_exe != 0)) 
            ForwardBE = 2'b10; 
        else if (((rs_2_exe == rd_w) & reg_write_w) & (rs_2_exe != 0))
            ForwardBE = 2'b01; 
        else 
            ForwardBE = 2'b00; 
    end
 
    // Load-use hazard detection
    always @(*) begin
        lw_stall = result_src_exe & ((rs_1_d == rd_exe) | (rs_2_d == rd_exe));
    end
    
    // MUX implementation for stall_d
    always @(*) begin
        if (reset)
            stall_d_i = 1'b0;
        else
            stall_d_i = lw_stall;
    end

    // MUX implementation for flush_exe
    always @(*) begin
        if (reset)
            flush_exe_i = 1'b0;
        else
            flush_exe_i = (lw_stall | pc_src_exe);
    end

    // MUX implementation for flush_d
    always @(*) begin
        if (reset)
            flush_d_i = 1'b0;
        else
            flush_d_i = pc_src_exe;
    end
	
	assign stall_f_i = stall_d_i;
//     //For FPGA
//    assign stall_d = stall_d_i;
//    assign stall_f = stall_f_i;
//    assign flush_d = flush_d_i;
//    assign flush_exe = flush_exe_i;
    

      //For Simulation
      assign stall_d 	= (stall_d_i   !== 1'b0 && stall_d_i   !== 1'b1) ? 1'b0 : stall_d_i   ;
      assign stall_f 	= (stall_f_i   !== 1'b0 && stall_f_i   !== 1'b1) ? 1'b0 : stall_f_i   ;
      assign flush_d	= (flush_d_i   !== 1'b0 && flush_d_i   !== 1'b1) ? 1'b0 : flush_d_i   ;
      assign flush_exe 	= (flush_exe_i !== 1'b0 && flush_exe_i !== 1'b1) ? 1'b0 : flush_exe_i ;


endmodule

module PCSrc_EXE_Generator(

	input	wire 	zero_exe			, 
	input	wire	jump_exe			, 
	input	wire  	branch_exe			, 
	input	wire 	funct3_lsb_exe		,
	
    output 	wire 	pc_scr_exe
);

    wire pc_scr_internal;
    
    assign pc_scr_internal = jump_exe | ((zero_exe ^ funct3_lsb_exe) & branch_exe);
    
//    assign pc_scr_exe = rst ? 1'b0 : pc_scr_internal;
    assign pc_scr_exe = (pc_scr_internal !== 1'b0 && pc_scr_internal !== 1'b1) ? 1'b0 : pc_scr_internal;

endmodule

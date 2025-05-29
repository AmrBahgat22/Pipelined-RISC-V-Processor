`timescale 1ns / 1ps

module Pipeline_RISCV_tb();

    // 1) Declare local reg and wire identifiers with _tb suffix
    reg 	Clk, rst_n;

    // 2) Instantiate the module under test
    Pipeline_RISCV DUT (
        .clk(clk), 
        .rst(rst_n)
    );

    // 3) Generate stimuli, using initial and always
    // Clock generation
    initial Clk = 1'b0; // Set initial value

    always #25 clk = ~clk; // Toggle every 10 time units

    // Test Cases
    initial begin
        Reset = 1'b1;
        #15;
        Reset = 1'b0;
        #4000;
        $stop;
    end


endmodule

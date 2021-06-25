module tb_hw ;
	reg short_timeout;
	reg long_timeout;
	reg clk;
	
	//clk circuitry
	initial clk = 1'b0;
	
	always #10 clk = ~clk;
	
endmodule

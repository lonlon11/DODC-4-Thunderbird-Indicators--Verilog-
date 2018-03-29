module ThunderBird( input 	clk,
					input	left,
					input 	right,
					input 	reset,
					output	[5:0] TailLights);

	wire w0;

	clk_div ticker(	.clk(clk),
	                .rst(reset),
					.clk_en(w0));

	Indicators lights( 	.clk(w0),
						.left(left),
						.right(right),
						.reset(reset),
						.TailLights(TailLights));

endmodule
module tb(
	input clk,
	input rst,
	output logic _done
);

	logic [63:0] c;


	counter cc(
		.n_rst(rst),
		.clk(clk),
		.counter_w(c)
	);
	always@(posedge clk)begin
		if(c == 'd64)begin
			_done <= 1;
		end else begin
			_done <= 0;
		end
	end

endmodule

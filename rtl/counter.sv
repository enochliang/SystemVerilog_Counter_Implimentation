module counter (
	input n_rst,
	input clk,
	output [63:0] counter_w
);

	logic [63:0] counter;
	assign counter_w = counter;

	always_ff @(negedge n_rst or posedge clk) begin
		if(!n_rst)begin
			counter <= 0;
		end else begin
			counter <= counter + 1;
		end
	end

endmodule

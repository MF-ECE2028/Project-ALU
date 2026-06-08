/*
Project: 8 Bit ALU
Author: Nolan Kessler
Sources: Based on my counter implementation from lab 5

A configurable counter
*/

module Counter
#(
parameter IN_WIDTH = 4,
parameter OUT_WIDTH = 4
)
(
	input logic clock,
	input logic reset_n,
	input logic enable,
	input logic [IN_WIDTH-1:0] addBy,
	output logic [OUT_WIDTH-1:0] count
);

	logic [OUT_WIDTH-1:0] count_next;

	always_comb begin
		count_next = count + (addBy & {IN_WIDTH{enable}});
	end

	Register_en_rstn #(OUT_WIDTH) register(
		.clk(clock),
		.rst_n(reset_n),
		.in(count_next),
		.out(count),
        .enable(1'b1)
	);

endmodule
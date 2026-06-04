module A_pass(
	input logic [7:0] A,
	input logic enable,
	output logic [7:0] Y
);

	assign Y = enable ? A : 8'bz;


endmodule
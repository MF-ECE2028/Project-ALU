module Xor(
	input logic [7:0] A, B,
	input logic enable,
	output logic [7:0] Y
);


	assign Y = enable ? (A ^ B) : 8'bz;

endmodule
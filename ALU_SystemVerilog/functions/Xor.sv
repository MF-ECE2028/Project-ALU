module Xor(
	input logic [7:0] A, B,
	input logic enable,
	output logic [7:0] Y,
	output logic done,
	output logic overflow
);


	assign Y = enable ? (A ^ B) : 8'bz;
	assign done = enable ? 1'b1 : 1'bz;
    assign overflow = enable ? 1'b0 : 1'bz;

endmodule
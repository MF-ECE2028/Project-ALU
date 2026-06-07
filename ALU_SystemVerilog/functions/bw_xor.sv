/*
Project: 8-Bit ALU
Author: John O'Connor
Sources: N/A

Module for Bitwise XOR.
*/

module Bitwise_XOR (
	input logic [7:0] A, B,
	input logic enable,
	output logic [7:0] Y,
	output logic done,
	output logic overflow
);


	assign Y = enable ? (A ^ B) : 8'bz;  // Assigns Y when enable is high, otherwise Y is floating
	assign done = enable ? 1'b1 : 1'bz;  // Done is high when enable is high
    assign overflow = enable ? 1'b0 : 1'bz;  // No overflow occurs with bitwise XOR

endmodule
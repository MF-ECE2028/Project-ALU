module B_pass(
	input logic [7:0] B,
	input logic enable,
	output logic [7:0] Y
);


	assign Y = enable ? B : 8'bz;


endmodule
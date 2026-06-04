module Xor(
	input logic [7:0] A,
	input logic [7:0] B,
	input logic [3:0] opcode,
	output logic [7:0] Y
);

always_comb begin

	if (opcode == // ADD OPCODE ONCE DEFINED)
		Y = A ^ B;
	else
		Y = 8'b0;
end

endmodule
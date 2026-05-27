module A_pass(
	input logic [7:0] A,
	input logic [3:0] opcode,
	output logic [7:0] Y
);

always_comb begin
	
if (opcode == // TODO ADD ONCE DEFINED (TRUE CASE))
	Y = A;
else
	Y = 8'b0;

end

endmodule
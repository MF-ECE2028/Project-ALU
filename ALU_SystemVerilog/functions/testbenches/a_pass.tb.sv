/*
Project: 8-Bit ALU
Author: John O'Connor
Sources: N/A

Testbench file for the A passthorugh module (A_pass.sv).
*/

module A_pass_tb;
	// Inputs
	logic [7:0] A;
	logic enable;
	// Outputs
	logic [7:0] Y;
	logic done;
	logic overflow;
	
	A_pass dut(
		.A(A),
		.enable(enable),
		.Y(Y),
		.done(done),
		.overflow(overflow)
	);
	
	initial begin

	 	enable = 1;
		
		// Test all possible values for A
		// Expected: Y = A for every test
		for (int i=0; i<256; i++) begin
			A = i;
			#10;
			if (Y !== A || done !== 1'b1 || overflow !== 1'b0) begin
				$display("Test Failed for A = %0d", i);
				$stop;
			end
		end
		
		$display("All Tests Passed");

	end
	
endmodule
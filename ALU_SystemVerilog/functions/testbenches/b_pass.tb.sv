/*
Project: 8-Bit ALU
Author: John O'Connor
Sources: N/A

Testbench file for the B passthrough module (b_pass.sv).
*/

module B_pass_tb;
	// Inputs
	logic [7:0] B;
	logic enable;
	// Outputs
	logic [7:0] Y;
	logic done;
	logic overflow;
	
	B_pass dut(
		.B(B),
		.enable(enable),
		.Y(Y),
		.done(done),
		.overflow(overflow)
	);
	
	initial begin

		enable = 1;
		
		// Test every possible value for B
		// Expected: Y = B for each value
		for (int i=0; i<256; i++) begin
			B = i;
			#10;
			// Check Y is correct, done is high, overflow is low
			if (Y !== B || done !== 1'b1 || overflow !== 1'b0) begin
				$display("Test Failed for B = %0d", i);
				$stop;
			end
		end
		
		$display("All Tests Passed");

	end
	
endmodule
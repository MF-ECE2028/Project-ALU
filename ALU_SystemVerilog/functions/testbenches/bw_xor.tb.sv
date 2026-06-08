/*
Project: 8-Bit ALU
Author: John O'Connor
Sources: N/A

Testbench file for the Bitwise XOR (bw_xor.sv).
*/

module Xor_tb;
	// Inputs
	logic [7:0] A, B;
	logic enable;
	// Outputs
	logic [7:0] Y;
	logic done;
	logic overflow;
	
	Bitwise_XOR dut(
		.A(A),
		.B(B),
		.enable(enable),
		.Y(Y),
		.done(done),
		.overflow(overflow)
	);
	
	initial begin

		// Test case where enable is lwo
		enable = 0;

		A = 8'b0;
		B = 8'b1;
		#10;
		// Y, done, and overflow should all be floating
		if (Y !== 8'bz || done !== 1'bz || overflow !== 1'bz) begin
			$display("Test Failed enable low case");
			$stop;
		end

		// Test cases where enbale is high
		enable = 1;
		
		// Test every possible combination of A and B
		for(int i=0; i<256; i++) begin
			for (int j=0; j<256; j++) begin
				A = i;
				B = j;
				#10;
				// Check Y is correct, done is high, and overflow is low
				if (Y!== (A^B) || done !== 1'b1 || overflow !== 1'b0) begin
					$display("Test Failed");
					$stop;
				end
			end
		end
		
		$display("All Tests Passed");
	end
		
endmodule
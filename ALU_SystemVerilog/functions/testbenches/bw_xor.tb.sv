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
	
	Xor dut(
		.A(A),
		.B(B),
		.enable(enable),
		.Y(Y),
		.done(done),
		.overflow(overflow)
	);
	
	initial begin
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
module B_pass_tb;

	logic [7:0] B;
	logic enable;
	logic [7:0] Y;
	logic done;
	logic overflow;
	
	B_pass uut(
		.B(B),
		.enable(enable),
		.Y(Y),
		.done(done),
		.overflow(overflow)
	);
	
	initial begin

		enable = 1;
		
		for (int i=0; i<256; i++) begin
			B = i;
			#10;
			if (Y !== B || done !== 1'b1 || overflow !== 1'b0) begin
				$display("Test Failed for B = %0d", i);
				$stop;
			end
		end
		
		$display("All Tests Passed");

	end
	
endmodule
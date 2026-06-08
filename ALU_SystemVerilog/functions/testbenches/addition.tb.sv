module AdditionTestbench();

//Module Inputs
logic [7:0] A_input, B_input;
logic enable;

//Module Outputs
logic [7:0] Y_test;
logic done, overflow;

//Expected Outputs
logic [7:0] Y_exp;
logic overflow_exp;

Addition dut(
    .A(A_input), .B(B_input),
    .enable(enable),
    .Y(Y_test),
    .overflow(overflow), .done(done)
);

initial begin

    // Test case where enable is low
    enable = 0;
    A_input = 8'b0;
    B_input = 8'b1;
    #10;
    // Y, done, and overflow should all be floating
    if (Y_test !== 8'bz || done !== 1'bz || overflow !== 1'bz) begin
        $display("Test Failed enable low case");
        $stop;
    end

    // Test cases where enable is high
    enable = 1;

    // Test all possible values for A and B
    for(int A = 0; A < 256; A++) begin
        for(int B = 0; B < 256; B++) begin
            A_input = A; B_input = B;
            {overflow_exp, Y_exp} = A + B;
            #10;
            // Check Y is correct, done is high, and overflow is correct
            if (Y_test !== Y_exp || done !== 1'b1 || overflow !== overflow_exp) begin
                $display("Failed at %dA + %dB; Y=%d and Y_exp=%d and overflow=%d and overflow_exp=%d",
                    A, B, Y_test, Y_exp, overflow, overflow_exp);
                $stop;
            end
        end
    end

    $display("All Tests Passed");
end

endmodule
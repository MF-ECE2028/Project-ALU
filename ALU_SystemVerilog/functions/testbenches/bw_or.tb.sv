/*
Project: 8-Bit ALU
Author: Max Fabian
Sources: N/A

Testbench file for the OR module (bw_or.sv).
*/

module Or_tb();

    //Module Inputs
    logic [7:0] A_input, B_input;
    logic enable;

    //Module Outputs
    logic [7:0] Y_test;
    logic done, overflow;

    //Module Call
    Bitwise_OR dut(
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
                #10;
                // Check Y is correct, done is high, and overflow is low
                if (Y_test !== (A_input | B_input) || done !== 1'b1 || overflow !== 1'b0) begin
                    $display("Failed at %dA | %dB; Y=%d", A, B, Y_test);
                    $stop;
                end
            end
        end

        $display("All Tests Passed");
    end

endmodule
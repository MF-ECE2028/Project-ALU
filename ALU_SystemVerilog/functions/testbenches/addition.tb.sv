module AdditionTestbench();

//Module Inputs
logic [7:0] A_input, B_input;
logic enable;

//Module Outputs
logic [7:0] Y_test;
logic cout_test, Done_test;

//Expected Outputs
logic [7:0] Y_exp;
logic cout_exp, Done_exp;

Addition dut(
    .A(A_input), .B(B_input),
    .enable(enable),
    .Y(Y_test),
    .carry(cout_test), .Done(Done_test)
);


task validate();
    for(int A = 0; A < 256; A++) begin
            if(enable == 0) begin
                $display("Function not yet enabled %dY_test %dcout_test",
                    Y_test, cout_test);
                break;
            end
        for(int B = 0; B < 256; B++) begin
            A_input = A; B_input = B;
            {cout_exp, Y_exp} = A + B;

            #5;
            
            if(cout_exp == cout_test && Y_exp == Y_test && Done_test == Done_exp) begin
                $display("Calculation Correct");
            end else begin
                $display("Failed at %dA + %dB; Y=%d and Y_exp=%d and cout=%d and cout_exp=%d",
                    A, B, Y_test, Y_exp, cout_test, cout_exp);
                //$stop;
            end
        end
    end
endtask

initial begin
    enable  = 1'b0;
    A_input = 0;
    B_input = 0;
    Done_exp= 1;

    validate();

    enable = 1'b1;

    validate();

    #100;
    $stop;
end

endmodule

    



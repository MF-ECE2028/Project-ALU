/*
Project: 8-Bit ALU
Author: Max Fabian

Bitwise AND Testbench, tests all possible outputs of running bitwise AND across two 8-bit busses
*/
module Bitwise_ANDTestbench();

//Module Inputs
logic [7:0] A_input, B_input;
logic enable;

//Module Outputs
logic [7:0] Y_test;
logic cout_test, Done_test;

//Expected Outputs
logic [7:0] Y_exp;
logic cout_exp, Done_exp;

//Module Call
Bitwise_AND dut(
    .A(A_input), .B(B_input),
    .enable(enable),
    .Y(Y_test),
    .carry(cout_test), .Done(Done_test)
);


task validate();
/*
* Validate Task:
    * Iterates through all values of A and B and compares the calculated
    *  values of bitwise AND to the implimented bitwise AND module
*/
    for(int A = 0; A < 256; A++) begin
        //If enable is off we should see a floating output
        if(enable == 0) begin
            $display("Function not yet enabled %dY_test",
                Y_test);
            break;
        end
        for(int B = 0; B < 256; B++) begin
            //Assigns the module bus inputs to current values
            A_input = A; B_input = B;
            //Calculates expacted values and outputs them to expected
            Y_exp = A & B;

            #5; //Pause to let module run
            
            //Checks every output against expected and displays where it fails
            // if it does
            if(cout_exp !== cout_test && Y_exp !== Y_test && Done_test !== Done_exp) begin
                $display("Failed at %dA & %dB; Y=%d and Y_exp=%d",
                    A, B, Y_test, Y_exp);
                //Does not stop at fail to identify the pattern of failure
                // from test results
            end
        end
    end
endtask

initial begin
    //Initialize Variables
    enable  = 1'b0; //First test enable at 0
    A_input = 0;
    B_input = 0;
    Done_exp= 1;    //Expected Done flag will always be 1
    cout_exp= 0;    //Overflow should always be 0 for bitwise operations

    validate();     //Should display the not yet enables messaeg

    enable = 1'b1;  //Now test enable at 1

    validate();     //Should pass with no error

    #100;           //Take a short breather
    $stop;
end

endmodule

    



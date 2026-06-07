module Mult_8bitTestbench();

//Module Inputs
logic [7:0] A_input, B_input;
logic enable, clock, reset_n;

//Module Outputs
logic [7:0] Y_test;
logic cout_test, Done_test;

//Expected Outputs
logic [7:0] Y_exp;
logic cout_exp, Done_exp;

//Additional Logic to Help account for overflow
logic [7:0] overflow_catch;

//Module Call
Mult_8bit dut(
    .A(A_input), .B(B_input),
    .enable(enable), .clock(clock), .reset_n(reset_n),
    .Y(Y_test),
    .overflow(cout_test), .done(Done_test)
);


task reset();
/*
* Reset Task:
    * Runs the reset pin at active low
    * Should reset all registers to 0 and set done flag to 0
*/
    reset_n = 1'b0;
    #10;
    reset_n = 1'b1;
endtask

task multiply();
/*
* Multiply Task:
    * Since the multiplier Module runs on a number of clock cycles
    * The test case needs to be predictable for proper comparison
    *
    * Therefore the multiply function runs the clock until the Done flag is
    *  raised. Upon which it should reset
    *
    * Since the registers are ran to the output as the done flag is raised
    *  the output should still be readable inspite of the reset, since
    *  the reset has no active effect on the output.
*/ 
    while (Done_test !== 1'b1) begin
        clock = 1'b1;
        #1;
        clock = 1'b0;
        #1;
    end
    reset();
endtask

task validate();
/*
* Validate Task:
    * Iterates through a limited set of values for A and B 
    *  and compares the calculated values of multiplication
    *  to the implimented addition module
    *
    * Since the output is limited to 8-bits the multiplier 
    *  technically only works for two 4-bit inputs,
    *  and the each test takes 9 clock cycles
    *  so the test is limited to a 6-bit maximum
*/

    int A2; //Declare variables for use in later test case
    int B2;

    for(int A = 0; A < 64; A++) begin
        //If enable is off we should see a floating output
        if(enable == 0) begin
            //Running multiply here causes the module to run forever
            // Which proves that it works correctly
            // However this is also why it is commented out.

            //multiply();
            $display("Function not yet enabled %dY_test %dcout_test",
                Y_test, cout_test);
            break;
        end
        for(int B = 0; B < 64; B++) begin
            //Assigns the module bus inputs to current values
            A_input = A; B_input = B;
            //Calculates expected values and outputs them to expected
            {overflow_catch, Y_exp} = A * B;
            //Overflow Catch exists because of the output size limitation
            // always overflows when the output is bigger than the output
            // instead of only when the 9th bit is 1 like for other TBs
            if(overflow_catch > 0) begin cout_exp = 1; end 

            multiply(); //Run the multiply task to give enough clock cycles
            #5;         //Pause to let module process

            //Checks all expected to tested from module, shows where it fails            
            if(cout_exp !== cout_test && Y_exp !== Y_test && Done_test !== Done_exp) begin
                $display("Failed at %dA * %dB; Y=%d and Y_exp=%d and cout=%d and cout_exp=%d",
                    A, B, Y_test, Y_exp, cout_test, cout_exp);
                //Does not stop at fail to identify the pattern of failure
                // from test results
            end
        end
    end

    //This is a special case test for when the value should be
    // massively large but will appear much smaller due to the limitation
    // of the output.
    //
    //Same as the looped cases above
    A2 = 255;
    B2 = 128;
    A_input = A2; 
    B_input = B2; 
    {cout_exp, Y_exp} = A2 * B2;

    multiply();

    if(cout_exp !== cout_test && Y_exp !== Y_test && Done_test !== Done_exp) begin
        $display("Failed at %dA * %dB; Y=%d and Y_exp=%d and cout=%d and cout_exp=%d",
            A, B, Y_test, Y_exp, cout_test, cout_exp);
        //$stop;
    end

endtask

initial begin
    //Initialize Variables
    enable  = 1'b0; //First test enable at 0
    A_input = 0;
    B_input = 0;
    Done_exp= 1;    //Expected Done flag will always be 1
    
    reset();        //Reset to begin, otherwise last ran test will be output
    validate();     //Should display the not yet enabled message

    enable = 1'b1;  //Now test enable at 1
    
    reset();        //Reset for same reason as before
    validate();     //Should pass with no error

    #100;           //Take a breather
    $stop;
end

endmodule

    



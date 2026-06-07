/*
Project: 8-Bit ALU
Author: Max Fabian
Sources:
    *https://en.wikipedia.org/wiki/Binary_multiplier#Single-cycle_multiplier
    *https://stackoverflow.com/questions/63655634/8-bit-sequential-multiplier-using-add-and-shift

Sequential Multiplier, functions similarly to doing long multiplication by hand
*/
module Mult_8bit (
    input logic [7:0] A, B,//8-bit Operand inputs 
    input logic clock, 
    input logic reset_n, 
    input logic enable,//Enable - sets output of operator to floating
    output logic [7:0] Y, // 8-bit Output
    output logic done, //Done Flag 
    output logic overflow //Overflow Flag
);

//Registers for helping track the current sequence in the multiplication 
logic [15:0] result; 
logic [7:0]  cout;
logic [7:0]  multiplicand; 
logic [4:0]  i;

    //Needs to trigger only when enable is on or when reseting
    always @(posedge (clock && enable) or negedge reset_n or negedge(enable)) begin
        //Sets the outputs to floating when the enable is off
        if(~enable)begin
            Y        <= 8'bz;
            done     <= 1'bz;
            overflow <= 1'bz;
        end else begin
            //Resets all the registers and the done flag to initial states
            if(~reset_n) begin
                done            <= 1'b0;
                result          <= 0;
                multiplicand    <= A;
                i               <= 0;
            end else begin
                //For loop created using a counter and comparitor
                //Functionally same as:
                //  for(int i = 0; i < 8; i++) 
                //  counts from 0 to 7 inclusively
                if(i < 8) begin
                    //Performed on every iteration so the current
                    // sequence in multiplication is correct
                    multiplicand <= multiplicand << 1; //Logical Left Shift
                                                       //I.E. multiplied by 2

                    //Reads each bit of B and increases the result by the 
                    // current left shifted multiplicand
                    if(B[i] == 1) begin
                        result <= result + multiplicand;
                    end
                //Iterand counting by one to complete for loop functionality
                i <= i + 1;   

                //Once the loop has finished the result can be thrown to
                // the outputs, and the done flag can be raised so the ALU
                // knows the operation has concluded.
                end else begin
                    {cout, Y}   <= result;
                    //Since the output of a multiplier is 2x number of
                    // input bits and our output is staying at 8 bits
                    // the overflow flag needs to be raised whenever
                    // the result exceeds 8 bits
                    if(cout > 0) begin overflow <= 1; end
                    //Raising the done flag should always be the last
                    // thing it does
                    done        <= 1'b1;
                end
            end
        end
    end

endmodule



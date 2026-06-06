/*
Project: 8-Bit ALU
Author: Max Fabian
Sources: N/A

Module for running the Subtractor in the ALU
*/
module Subtraction (
    input logic [7:0] A, B, //8-bit Operand inputs
    input logic enable,     //Enable - sets output of operator to floating
    output logic [7:0] Y,   //8-bit Output
    output logic done,      //Done Flag
    output logic overflow   //Overflow Flag
);

    //Assigns Y to the output of a subtractor when enable is high
    assign Y = enable ? (A - B) : 8'bz;

    //Simple Functions like this one have simple done and overflow flags
    assign done     = enable ? 1'b1:1'bz;
    assign overflow = enable ? 1'b0:1'bz;

endmodule

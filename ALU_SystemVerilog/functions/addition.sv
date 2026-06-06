/*
Project: 8-Bit ALU
Author: Max Fabian
Sources: N/A

Module for running the adder in the ALU
*/
module Addition(
    input logic [7:0] A, B, //8-bit operand inputs
    input logic enable,     //Enable - sets output of operator to floating
    output logic [7:0] Y,   //8-bit output
    output logic overflow,  //Overflow Flag   
    output logic done       //Done Flag
);
    //Assigns overflow as 9th bit to Y and takes adder when enable is high
    assign {overflow, Y} = enable ? (A + B) : 9'bz; 

    //Done flag on enable high
    assign done = enable ? 1'b1:1'bz;

endmodule

/*
Project: 8-Bit ALU
Authors: Nolan Kessler, Maxwell Fabian, John O'Connor
Soruces: TODO

Main file for 8-Bit ALU implementation. Integrates modular functions with selection and execution system.
*/

module ALU_8 (
    input logic [7:0] a, b //8 bit operand inputs
    input logic [3:0] op, //4 bit opcode input
    input logic en, //Enable - ALU copies current inputs to internal registers and begins execution on rising edge. All outputs are zero unless this input is high.
    output logic [7:0] y, //8 bit result
    output logic overflow, //Overflow flag
    output logic done, //done flag, goes high when operation is complete
);

    //Note differently from how it is indicated in my desgin sketch, enable of CS multiplexer should be connected to RLK

endmodule
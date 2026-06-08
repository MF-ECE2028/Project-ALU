/*
Project: 8-Bit ALU
Author: Max Fabian

Bus 2:1 Multiplexer, 2 N-bit busses, with capability to select one of them.
*/
module Bus_Multiplexer_1 #(parameter BUS_WIDTH) ( //Parameter for choosing Width of N number of bits
    input logic [BUS_WIDTH - 1 : 0] in0, //N-bit bus input
    input logic [BUS_WIDTH - 1 : 0] in1, //N-bit bus input
    input logic sel,                     //1-bit selector
    output logic [BUS_WIDTH - 1 : 0] out //N-bit bus output
);

    assign out = sel ? in1 : in0; //Out is selected dependant on selector

endmodule

/*
Project: 8-Bit ALU
Author: Max Fabian

Bus 1:4 Reverse Multiplexer, Takes one N-bit Bus and selector passes said bus to specific output
*/
module Bus_Demultiplexer_2 #(parameter BUS_WIDTH) ( //Parameter to choose bus Width with N number of bits
    input logic [BUS_WIDTH - 1 : 0] in,    //N-bit bus input
    input logic [1:0] sel,                 //2-bit selector   
    output logic [BUS_WIDTH - 1 : 0] out0, //N-bit bus output
    output logic [BUS_WIDTH - 1 : 0] out1, //N-bit bus output
    output logic [BUS_WIDTH - 1 : 0] out2, //N-bit bus output
    output logic [BUS_WIDTH - 1 : 0] out3  //N-bit bus output
);

    //All outputs will pass 0 when not selected
    assign out0 = sel[1] ? 0: (sel[0] ? 0 : in); //out0 passes in when selector is 00
    assign out1 = sel[1] ? 0: (sel[0] ? in : 0); //out1 passes in when selector is 01
    assign out2 = sel[1] ? (sel[0] ? 0 : in) :0; //out2 passes in when selector is 10
    assign out3 = sel[1] ? (sel[0] ? in : 0) :0; //out3 passes in when selector is 11

endmodule

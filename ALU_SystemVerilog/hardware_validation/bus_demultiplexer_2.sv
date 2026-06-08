module Bus_Demultiplexer_2 #(parameter BUS_WIDTH) (
    input logic [BUS_WIDTH - 1 : 0] in,
    input logic [1:0] sel,
    output logic [BUS_WIDTH - 1 : 0] out0,
    output logic [BUS_WIDTH - 1 : 0] out1,
    output logic [BUS_WIDTH - 1 : 0] out2,
    output logic [BUS_WIDTH - 1 : 0] out3
);

endmodule
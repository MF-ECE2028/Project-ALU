module Bus_Multiplexer_1 #(parameter BUS_WIDTH) (
    input logic [BUS_WIDTH - 1 : 0] in0,
    input logic [BUS_WIDTH - 1 : 0] in1,
    input logic sel,
    output logic [BUS_WIDTH - 1 : 0] out
);

    assign out = sel ? in1 : in0;

endmodule

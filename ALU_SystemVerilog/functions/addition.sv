module addition(
    input logic [7:0] A, B,
    input logic enable,
    output logic [7:0] Y,
    output logic carry, Done
);

    assign {carry, Y} = enable ? (A + B);
    assign Done = 1;

endmodule

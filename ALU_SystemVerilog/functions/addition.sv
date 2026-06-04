module addition(
    input logic [7:0] A, B,
    output logic [7:0] Y,
    output logic carry
);

    assign (carry, Y) = A + B;

endmodule

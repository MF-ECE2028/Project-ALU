module bitwise (
    input logic [7:0] A, B,
    output logic [7:0] Y
);

    assign Y = A | B;

endmodule

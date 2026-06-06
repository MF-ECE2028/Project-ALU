module Bitwise_AND(
    input logic [7:0] A, B,
    input logic enable,
    output logic [7:0] Y,
    output logic Done, carry
);

    assign Y = enable ? (A & B) : 8'bz;
    assign Done = 1;
    assign carry = 0;

endmodule

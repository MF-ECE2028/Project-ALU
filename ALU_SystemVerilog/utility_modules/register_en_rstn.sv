/*
Project: 8-Bit ALU
Author: Nolan Kessler
Sources: Based on my register implementation from Lab 5

Implements a parameterized width register with enable and active low reset.
*/

module Register_en_rstn #(parameter WIDTH = 1) (
    input logic clk,
    input logic enable, //Enable - copy in to out on rising edge of clk only when high
    input logic rst_n, //Active low reset - set out to zero on falling edge
    input logic [WIDTH - 1 : 0] in,
    output logic [WIDTH - 1 : 0] out
);

    always_ff @(posedge clk, negedge rst_n) begin

        if (rst_n == 0) begin
            out <= 0;
        end

        else begin
            if (enable != 0) begin
                out <= in;
            end
        end

    end

endmodule

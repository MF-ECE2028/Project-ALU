module alu_test(
    input logic key_n,
    input logic rst_n,
    input logic clk,
    input logic [7:0] switches,
    output logic [2:0] set_leds,
    output logic done_led,
    output logic overflow_led,
    output logic [6:0] seven_seg0,
    output logic [6:0] seven_seg1
);

    logic key = !key_n //Invert button input for use with active high logic
    

endmodule
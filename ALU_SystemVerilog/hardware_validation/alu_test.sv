/*
Project: 8-Bit ALU
Author: Nolan Kessler

Implements interactive testing of ALU on hardware
*/

module alu_test(
    input logic key_n,
    input logic rst_n,
    input logic clk,
    input logic [7:0] switches,
    output logic [2:0] step_leds,
    output logic done_led,
    output logic overflow_led,
    output logic [6:0] seven_seg0,
    output logic [6:0] seven_seg1
);

    logic key;
    logic state;
    logic last_step;
    logic running;
    logic [8:0] reg_a_bus;
    logic [8:0] reg_b_bus;
    logic [8:0] reg_op_bus;
    logic [7:0] alu_a;
    logic [7:0] alu_b;
    logic [7:0] alu_op_wide;
    logic [2:0] alu_op;
    logic [7:0] alu_y;
    logic [3:0] digit0;
    logic [3:0] digit1;
    
    assign key = ~key_n; //Inverted version of button for use with active high modules
    assign last_step = state == 3; //Comparator to track when state machine is on last step, and ALU is running
    assign alu_op = alu_op_wide[2:0];
    assign step_leds[0] = reg_a_bus[8]; //Leds to indicate which step system is on
    assign step_leds[1] = reg_b_bus[8];
    assign step_leds[2] = reg_op_bus[8];

    CounterNbit #(2) state_counter (
        .clock(key),
        .reset_n(rst_n),
        .enable_n(last_step),
        .addBy(1'b1),
        .count(state)
    );

    Register_en_rstn #(8) reg_a (
        .clk(clk),
        .enable(reg_a_bus[8]),
        .rst_n(rst_n),
        .in(reg_a_bus[7:0]),
        .out(alu_a)
    );

    Register_en_rstn #(8) reg_b (
        .clk(clk),
        .enable(reg_b_bus[8]),
        .rst_n(rst_n),
        .in(reg_b_bus[7:0]),
        .out(alu_b)
    );

    Register_en_rstn #(8) reg_op (
        .clk(clk),
        .enable(reg_op_bus[8]),
        .rst_n(rst_n),
        .in(reg_op_bus[7:0]),
        .out(alu_op_wide)
    );

    Register_en_rstn #(1) reg_start (
        .clk(~clk),
        .enable(last_step),
        .rst_n(rst_n),
        .in(1),
        .out(running)
    );

    Bus_Demultiplexer_2 #(9) reg_selector (
        .in({1'b1, switches}),
        .sel(state),
        .out0(reg_a_bus),
        .out1(reg_b_bus),
        .out2(reg_op_bus)
    );

    Bus_Multiplexer_1 #(8) disp_source_selector (
        .in0(switches),
        .in1(alu_y),
        .sel(last_step),
        .out({digit1, digit0})
    );

    SevenSegmentDecode disp0 (
        .digit(digit0),
        .segments(seven_seg0)
    );

    SevenSegmentDecode disp1 (
        .digit(digit1),
        .segments(seven_seg1)
    );

    alu ALU (
        .en(running),
        .clk(clk),
        .rst_n(rst_n),
        .a(alu_a),
        .b(alu_b),
        .op(alu_op),
        .y(alu_y),
        .overflow(overflow_led),
        .done(done_led)
    );



endmodule
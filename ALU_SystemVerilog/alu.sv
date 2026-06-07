/*
Project: 8-Bit ALU
Authors: Nolan Kessler, Maxwell Fabian, John O'Connor
Soruces: TODO

Main file for 8-Bit ALU implementation. Integrates modular functions with selection and execution system.
*/

module alu (
    input logic en, //Enable - ALU copies current inputs to internal registers and begins execution when high. All outputs are zero unless this input is high.
    input logic clk,
    input logic rst_n, //Active low reset
    input logic [7:0] a, b, //8 bit operand inputs
    input logic [3:0] op, //4 bit opcode input
    output logic [7:0] y, //8 bit _y
    output logic overflow, //Overflow flag
    output logic done //done flag, goes high when operation is complete
);
    
    logic [7:0] cs; //operation select lines
	 logic _rlk;
	 logic [7:0] _a;
	 logic [7:0] _b;
	 logic [2:0] _op;
    logic [7:0] _y;
	 logic reg_en;
    logic _overflow;
    logic _done;
	 assign reg_en = en & _rlk; //Enable or disable updating input registers
    assign y = _y & {8{en}};
    assign overflow = _overflow & en;
    assign done = _done & en;

    Register_en_rstn #(1) Rlk ( //Lock register - prevents output of Ra and Rb and Rop from changing after rising edge of en
        .clk(~clk),
        .enable(en),
        .rst_n(rst_n),
        .in(en),
		  .out(_rlk)
    );

    Register_en_rstn #(8) Ra ( //Operand A register
        .clk(clk),
        .enable(reg_en),
        .rst_n(rst_n),
        .in(a),
		  .out(_a)
    );

    Register_en_rstn #(8) Rb ( //Operand B register
        .clk(clk),
        .enable(reg_en),
        .rst_n(rst_n),
        .in(b),
		  .out(_b)
    );

    Register_en_rstn #(4) Rop ( //Opcode Register
        .clk(clk),
        .enable(reg_en),
        .rst_n(rst_n),
        .in(op),
		  .out(_op)
    );
    
    Multiplexer_3_en M_cs (
        .in(_op),
        .enable(_rlk),
        .out(cs)
    );

    //Operation Instances
    A_pass a_pass (
        .A(_a),
        .enable(cs[0]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    B_pass b_pass (
        .B(_b),
        .enable(cs[1]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    Bitwise_AND bw_and (
        .A(_a),
        .B(_b),
        .enable(cs[2]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    Bitwise_OR bw_or (
        .A(_a),
        .B(_b),
        .enable(cs[3]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    Bitwise_XOR bw_xor (
        .A(_a),
        .B(_b),
        .enable(cs[4]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    Addition addition (
        .A(_a),
        .B(_b),
        .enable(cs[5]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    Subtraction subtraction (
        .A(_a),
        .B(_b),
        .enable(cs[6]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );

    Mult_8bit multiplication (
        .A(_a),
        .B(_b),
        .clock(clk),
        .reset_n(rst_n),
        .enable(cs[7]),
        .Y(_y),
        .done(_done),
        .overflow(_overflow)
    );


endmodule
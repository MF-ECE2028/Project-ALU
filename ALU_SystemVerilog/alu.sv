/*
Project: 8-Bit ALU
Authors: Nolan Kessler, Maxwell Fabian, John O'Connor
Soruces: TODO

Main file for 8-Bit ALU implementation. Integrates modular functions with selection and execution system.
*/

module ALU_8 (
    input logic en, //Enable - ALU copies current inputs to internal registers and begins execution on rising edge. All outputs are zero unless this input is high.
    input logic clk,
    input logic rst_n, //Active low reset
    input logic [7:0] a, b //8 bit operand inputs
    input logic [3:0] op, //4 bit opcode input
    output logic [7:0] y, //8 bit result
    output logic overflow, //Overflow flag
    output logic done, //done flag, goes high when operation is complete
);
    
    logic [15:0] cs; //chip select lines
    logic reg_en = en & ~Rlk.out; //Enable or disable updating input registers

    Register_en_rstn Rlk #(1) ( //Lock register - prevents output of Ra and Rb and Rop from changing after rising edge of en
        .clk(~clk),
        .enable(en),
        .rst_n(rst_n),
        .in(en)
    );

    Register_en_rstn Ra #(8) ( //Operand A register
        .clk(clk),
        .enable(reg_en),
        .rst_n(rst_n),
        .in(a)
    );

    Register_en_rstn Rb #(8) ( //Operand B register
        .clk(clk),
        .enable(reg_en),
        .rst_n(rst_n),
        .in(b)
    );

    Register_en_rstn Rop #(4) ( //Opcode Register
        .clk(clk),
        .enable(reg_en),
        .rst_n(rst_n),
        .in(op)
    );
    
    Multiplexer_4_en M_cs (
        .in(op),
        .enable(Rlk.out),
        .out(cs)
    );

    //TODO Create instances of functions here



endmodule
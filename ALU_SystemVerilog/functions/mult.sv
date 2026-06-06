/*
Project: 8-Bit ALU
Author: Max Fabian
Sources:
    *https://en.wikipedia.org/wiki/Binary_multiplier#Single-cycle_multiplier
    *https://stackoverflow.com/questions/63655634/8-bit-sequential-multiplier-using-add-and-shift
*/
module Mult_8bit (
    input logic [7:0] A, B,//8-bit Operand inputs 
    input logic clock, 
    input logic reset_n, 
    input logic enable,//Enable - sets output of operator to floating
    output logic [7:0] Y, // 8-bit Output
    output logic done, //Done Flag 
    output logic overflow //Overflow Flag
);

logic [8:0] result;
logic [7:0] multiplicand; 
logic [4:0] i;
logic trig_addstore, trig_iterator;

    always @(posedge clock or posedge reset_n) begin
        if(reset_n) begin
            done            <= 0;
            result          <= 0;
            multiplicand    <= A;
            i               <= 0;
            trig_iterator   <= 0;
            trig_addstore   <= 0;
        end else begin

            if(i < 8) begin
                multiplicand <= multiplicand << 1;

                if(B[i] == 1) begin
                    trig_addstore <= 1'b1;
                end
                
            trig_iterator <= 1'b1;

            end else begin
                {overflow, Y}   <= result;
                done            <= 1;
            end

            trig_addstore <= 0;
            trig_iterator <= 0;
        end
    end


CounterNbit #(.N(7)) Iterator (
    .clock(clock),
    .reset_n(reset_n), .enable_n(trig_iterator),
    .addBy(1),
    .count(i)
);

CounterNbit #(.N(8)) AddStore (
    .clock(clock),
    .reset_n(reset_n), .enable_n(trig_addstore),
    .addBy(multiplicand),
    .count(result)

);
endmodule



//https://en.wikipedia.org/wiki/Binary_multiplier#Single-cycle_multiplier
//

module Mult_8bit (
    input logic [7:0] A, B,
    input logic clock, reset_n, enable,
    output logic [7:0] Y,
    output logic Done, carry
);

logic [8:0] result;
logic [7:0] adder, i, condition;


assign condition    = B >> 1;

    always_ff @(posedge clock) begin
        if(i == condition) begin

            {carry, Y} <= result;
            Done <= 1;

        end else if(i == 0 && B[0] == 0)begin
            
            adder <= 0;
        
        end else if(i == 0 && B[0] == 1) begin

            adder <= A;

        end else if(i == 1) begin

            adder <= A << 1;
        
        end else begin

            adder <= adder << 1;
        end
    end


CounterNbit #(.N(7)) ForLoop (
    .clock(clock),
    .reset_n(reset_n), .enable_n(enable),
    .addBy(1),
    .count(i)
);

CounterNbit #(.N(8)) AddStore (
    .clock(clock),
    .reset_n(reset_n), .enable_n(enable),
    .addBy(adder),
    .count(result)

);
endmodule



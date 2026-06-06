module CounterNbit #(parameter N = 3)(
    input logic clock,
    input logic reset_n, enable_n,
    input logic [N:0] addBy,
    output logic [N:0] count
);

logic [N:0] count_next;
 
always_comb begin //@(posedge clock || reset_n) begin
    if (reset_n == 1'b0) begin
        count_next <= count + addBy;
    end else begin
        count_next <= 0;
    end
end

Register_en_rstn #(.WIDTH(N+1)) RegNBit (
   .clk(clock),
   .rst_n(reset_n), .enable(enable_n),
   .in(count_next),
   .out(count)
);

endmodule 


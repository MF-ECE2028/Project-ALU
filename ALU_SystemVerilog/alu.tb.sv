module ALU_tb;
    //inputs
    logic        en;
    logic        clk;
    logic        rst_n;
    logic [7 : 0]  a, b;
    logic [2 : 0]  op;
    //outputs 
    logic [7:0]  y;
    logic        overflow;
    logic        done;
    
    alu dut (
        .en(en),
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(b),
        .op(op),
        .y(y),
        .overflow(overflow),
        .done(done)
    );
    
    always #5 clk = ~clk;
    
    // task to reset between operations
    task reset();
        en    = 0;
        rst_n = 0;
        #10;
        rst_n = 1;
    endtask
    
    // executing task
    task execute();
        @(negedge clk);
        en = 1;
        #5;
        @(posedge done);
        #5;
    endtask

    initial begin
        clk = 0;
        a   = 0;
        b   = 0;
        op  = 0;
        en  = 0;
        reset();
        
        // a_pass (0x0)
        reset();
        a = 8'hAA; b = 8'h55; op = 4'h0;
        execute();
        if (y !== 8'hAA || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: A_pass");
            $stop;
        end
        
        // B_pass (0x1)
        reset();
        a = 8'hAA; b = 8'h55; op = 4'h1;
        execute();
        if (y !== 8'h55 || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: B_pass");
            $stop;
        end
        
        // Bitwise AND (0x2)
        reset();
        a = 8'hAA; b = 8'h55; op = 4'h2;
        execute();
        if (y !== 8'h00 || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: Bitwise AND");
            $stop;
        end
        
        // Bitwise OR (0x3)
        reset();
        a = 8'hAA; b = 8'h55; op = 4'h3;
        execute();
        if (y !== 8'hFF || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: Bitwise OR");
            $stop;
        end
        
        // Bitwise XOR (0x4)
        reset();
        a = 8'hAA; b = 8'h55; op = 4'h4;
        execute();
        if (y !== 8'hFF || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: Bitwise XOR");
            $stop;
        end
        
        // Addition (0x5)
        reset();
        a = 8'h01; b = 8'h02; op = 4'h5;
        execute();
        if (y !== 8'h03 || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: Addition");
            $stop;
        end
        
        // Addition with overflow (0x5)
        reset();
        a = 8'hFF; b = 8'h01; op = 4'h5;
        execute();
        if (y !== 8'h00 || done !== 1'b1 || overflow !== 1'b1) begin
            $display("FAILED: Addition overflow");
            $stop;
        end
        
        // Subtraction (0x6)
        reset();
        a = 8'h05; b = 8'h03; op = 4'h6;
        execute();
        if (y !== 8'h02 || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: Subtraction");
            $stop;
        end
        
        // Multiplication (0x7)
        reset();
        a = 8'h05; b = 8'h03; op = 4'h7;
        execute();
        if (y !== 8'h0F || done !== 1'b1 || overflow !== 1'b0) begin
            $display("FAILED: Multiplication");
            $stop;
        end
        
        $display("All Tests Passed!");
        $stop;
    end
endmodule
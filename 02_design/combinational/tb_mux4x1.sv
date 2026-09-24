`timescale 1ns/1ps

module tb_mux4x1
    logic [3:0] a4,b4,c4,d4;
    logic [1:0] sel4
    logic [3:0] y4;
    // instantiate the design
    mux4x1 u_mux4x1 (
        .a(a4), .b(b4), .c(c4), .d(d4), .sel(sel4), .y(y4)
    );
    initial begin
        $display("\n=== STARTING 4-BIT WIDE MULTIPLEXER SIMULATION ===");
        a4 = 4'h1; b4 = 4'h2; c4 = 4'h3; d4 = 4'h4;
        
        sel4 = 2'b00; #10;
        $display("Mux4x1 -> sel=%b | Out y=%h (Expected: 1)", sel4, y4);
        
        sel4 = 2'b01; #10;
        $display("Mux4x1 -> sel=%b | Out y=%h (Expected: 2)", sel4, y4);
        
        sel4 = 2'b10; #10;
        $display("Mux4x1 -> sel=%b | Out y=%h (Expected: 3)", sel4, y4);
        
        sel4 = 2'b11; #10;
        $display("Mux4x1 -> sel=%b | Out y=%h (Expected: 4)", sel4, y4);

        $display("=== SIMULATION COMPLETE ===\n");
        $finish;
    end
endmodule
module mux2x1 (
    input  logic [3:0] a,    // 4-bit input A
    input  logic [3:0] b,    // 4-bit input B
    input  logic       sel,  // 1-bit select line
    output logic [3:0] y     // 4-bit output
);
    // If sel is 1, y gets the 4-bit value of b. If 0, y gets a.
    assign y = sel ? b : a;
endmodule

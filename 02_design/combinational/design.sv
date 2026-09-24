// 02_design/combinational/design.sv

// 1. A 4-bit wide 2-to-1 Multiplexer
module mux2x1 (
    input  logic [3:0] a,    // 4-bit input A
    input  logic [3:0] b,    // 4-bit input B
    input  logic       sel,  // 1-bit select line
    output logic [3:0] y     // 4-bit output
);
    // If sel is 1, y gets the 4-bit value of b. If 0, y gets a.
    assign y = sel ? b : a;
endmodule


// 2. A 4-bit wide 4-to-1 Multiplexer
module mux4x1 (
    input  logic [3:0] a,    // 4-bit input A
    input  logic [3:0] b,    // 4-bit input B
    input  logic [3:0] c,    // 4-bit input C
    input  logic [3:0] d,    // 4-bit input D
    input  logic [1:0] sel,  // 2-bit select line
    output logic [3:0] y     // 4-bit output
);
    always_comb begin
        case (sel)
            2'b00:   y = a;
            2'b01:   y = b;
            2'b10:   y = c;
            2'b11:   y = d;
            default: y = 4'bxxxx; // Handles uninitialized edge cases
        endcase
    end
endmodule

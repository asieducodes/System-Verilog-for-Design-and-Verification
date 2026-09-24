module seven_seg (
    input  logic A, B, C, D,
    output logic a, b, c, d, e, f, g
);
    logic [3:0] sig1;
    logic [6:0] sig2;

    // Line 8: Inputs drive sig1
    assign sig1 = {A, B, C, D};

    // Ternary chain mapping sig1 to sig2
    assign sig2 = (sig1 == 4'b0000) ? 7'b0000001 : // 0
                  (sig1 == 4'b0001) ? 7'b1100111 : // 1
                  (sig1 == 4'b0010) ? 7'b1001000 : // 2
                  (sig1 == 4'b0011) ? 7'b1000010 : // 3
                  (sig1 == 4'b0100) ? 7'b0100110 : // 4
                  (sig1 == 4'b0101) ? 7'b0010010 : // 5
                  (sig1 == 4'b0110) ? 7'b0010000 : // 6
                  (sig1 == 4'b0111) ? 7'b1000111 : // 7
                  (sig1 == 4'b1000) ? 7'b0000000 : // 8
                  (sig1 == 4'b1001) ? 7'b0000110 : // 9
                  (sig1 == 4'b1010) ? 7'b0110011 : // L
                  (sig1 == 4'b1011) ? 7'b0001100 : // P
                  (sig1 == 4'b1100) ? 7'b0100100 : // H
                  (sig1 == 4'b1101) ? 7'b0100001 : 7'b1110000; // Final default value & semicolon

    // Line 25: sig2 drives the outputs
    assign {a, b, c, d, e, f, g} = sig2;

endmodule

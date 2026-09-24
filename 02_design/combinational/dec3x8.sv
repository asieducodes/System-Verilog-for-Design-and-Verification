module dec3x8(
    input  logic A, B, C,
    output logic y7, y6, y5, y4, y3, y2, y1, y0
);
    logic [2:0] sig1;
    logic [7:0] sig2;
    
    assign sig1 = {A, B, C};

    always_comb begin:dec_block
        case(sig1) 
            3'b000:  sig2 = 8'b0000_0001; 
            3'b001:  sig2 = 8'b0000_0010;
            3'b010:  sig2 = 8'b0000_0100;
            3'b011:  sig2 = 8'b0000_1000;
            3'b100:  sig2 = 8'b0001_0000;
            3'b101:  sig2 = 8'b0010_0000;
            3'b110:  sig2 = 8'b0100_0000;
            3'b111:  sig2 = 8'b1000_0000;
            default: sig2 = 8'b0000_0000;
        endcase
    end

    assign {y7, y6, y5, y4, y3, y2, y1, y0} = sig2;

endmodule

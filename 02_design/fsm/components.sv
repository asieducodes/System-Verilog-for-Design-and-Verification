// module1: register
module reg8(
    input  logic [7:0] D,
    input  logic       reg_load, reg_rst, clk,
    output logic [7:0] Q
);
    always_ff @(posedge clk) begin
        if (reg_rst) begin
            Q <= 8'd0;
        end else if (reg_load) begin
            Q <= D;
        end
    end
endmodule

// module2: down counter
module down_counter(
    input  logic [7:0] D,
    input  logic       nCnt_en, nCnt_load, clk,
    output logic [7:0] Q
);
    logic [7:0] cnt_sig;
    
    always_ff @(posedge clk) begin
        if (nCnt_load) begin
            cnt_sig <= D;
        end else if (nCnt_en) begin
            cnt_sig <= cnt_sig - 8'd1;
        end
    end
    assign Q = cnt_sig;
endmodule

// module3: comparator
module comp(
    input  logic [7:0] A,
    output logic       Y
);
    assign Y = (A != 8'd0) ? 1'b1 : 1'b0;
endmodule

// module4: tristate buffer
module tristate_buff(
    input  logic [7:0] A,
    input  logic       en,
    output logic [7:0] Y
);
    assign Y = (en == 1'b1) ? A : 8'hzz;
endmodule

// module5: adder
module adder8(
    input  logic [7:0] A, B,
    output logic [7:0] Y
);
    assign Y = A + B;
endmodule

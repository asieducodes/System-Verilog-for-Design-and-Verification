 module datapath(
    input  logic       clk,
    input  logic       sum_rst,
    input  logic       sum_load,
    input  logic       nCnt_en,
    input  logic       nCnt_load,
    input  logic       out_en,
    input  logic [7:0] cnt_in,
    output logic [7:0] out,
    output logic       neq0
);

    logic [7:0] sum_in, sum_out, cnt_out;

    // Register instance 
    reg8 regA (
        .clk,
        .reg_load(sum_load),
        .reg_rst(sum_rst),
        .D(sum_in),
        .Q(sum_out)
    );

    // Counter instance
    down_counter cnt1 (
        .clk,
        .nCnt_en,
        .nCnt_load,
        .D(cnt_in),
        .Q(cnt_out)
    );

    // Adder instance
    adder8 adder1 (
        .A(sum_out),
        .B(cnt_out),
        .Y(sum_in)
    );

    // Comparator instance
    comp comparator1 (
        .A(cnt_out),
        .Y(neq0)
    );

    // Tristate Buffer instance
    tristate_buff tri_buff (
        .A(sum_out),
        .en(out_en),
        .Y(out)
    );

endmodule

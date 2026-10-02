module top(
    input  logic       clk,
    input  logic       rst,
    input  logic [7:0] cnt_in,
    output logic [7:0] out
);

    // Internal interconnect control signals
    logic neq0;
    logic sum_rst;
    logic sum_load;
    logic nCnt_en;
    logic nCnt_load;
    logic out_en;

    // Instantiate the fsm (FSM)
    fsm control_unit (
        .clk        (clk),
        .rst        (rst),
        .neq0       (neq0),
        .sum_rst    (sum_rst),
        .sum_load   (sum_load),
        .nCnt_en    (nCnt_en),
        .nCnt_load  (nCnt_load),
        .out_en     (out_en)
    );

    // Instantiate the Datapath
    datapath datapath_unit (
        .clk        (clk),
        .sum_rst    (sum_rst),
        .sum_load   (sum_load),
        .nCnt_en    (nCnt_en),
        .nCnt_load  (nCnt_load),
        .out_en     (out_en),
        .cnt_in     (cnt_in),
        .out        (out),
        .neq0       (neq0)
    );

endmodule

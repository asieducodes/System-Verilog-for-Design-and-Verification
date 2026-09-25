module shift_reg(
    input logic clk,
    input logic rst,
    input logic load,
    input logic shift_en,
    input logic[7:0] D,
    output logic [7:0] Q
);
// signal declaration for the output
logic [7:0] Q_sig;
// on the positive edge of the clock
always_ff @(posedge clk) begin
    if(rst) begin
        Q_sig <= 8'h0;
    end
    else if (load) begin
        Q_sig <= D;
    end 
    else if (shift_en) begin
        Q_sig <= {Q_sig[6:0],1'b0};
    end
end
// assign the output of the ff to the intermediate signal
assign Q = Q_sig;
endmodule
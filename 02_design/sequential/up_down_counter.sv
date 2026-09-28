module up_down_counter(
    input  logic [7:0] D,
    input  logic clk, rst, up_down, load,
    output logic [7:0] Q
); 

logic [7:0] Q_sig;

always_ff @ (posedge clk, posedge rst) begin
    if(rst) begin
        Q_sig <= 8'd0;
    end
    else begin 
        if(load) begin
            Q_sig <= D;
        end
        else if (!load && up_down) begin
            Q_sig <= Q_sig + 8'd1;
        end
        else if (!load && !up_down)begin
            Q_sig <= Q_sig - 8'd1;
        end
    end
end
assign Q = Q_sig;
endmodule
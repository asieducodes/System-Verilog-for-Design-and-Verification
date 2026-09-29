// NOT Gate
module not_gate(
    input logic in,
    output logic out
);
assign out = ~in;
endmodule
// AND Gate
module and2_gate(
    input logic in1,
    input logic in2,
    output logic out
);
assign out = in1;
endmodule

// OR Gate
module or2_gate(
    input logic in1,
    input logic in2,
    output logic out
)
assign out = in1 | in2;
endmodule
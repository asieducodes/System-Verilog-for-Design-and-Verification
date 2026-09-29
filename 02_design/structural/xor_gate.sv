module xor2_gate(
    input logic A,B,
    output logic Y
);

// internal wires or signals
logic A_not,B_not,And1_out,And2_out;

// instantiating the components 
// OR Gates
not_gate not_A(.out(A_not), .in(A));
not_gate not_B(.out(B_not), .in(B));

// AND  Gates
and2_gate and_gate1 (.out(And1_out), .in1(A_not), .in2(B));
and2_gate and_gate2 (.out(And2_out), in1(A), .in2(B_not));

//OR Gate
or2_gate or_gate(.out(Y), .in1(And1_out), .in2(And2_out));



endmodule
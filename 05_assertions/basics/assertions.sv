
// A concise way of validating the functional checker of a property
// immediate: executed as statements in procedural code

module tb_assert1;
bit a,b,c,d;
bit clk;

// generating the clk
always #10 clk = ~clk;
initial begin 
    for(int i=0; i<20;i++) begin 
        {a,b,c,d} = $random;
        $display("[%0t], a, b, c, d", $time, a,b,c,d);
        @(posedge clk);
    end
    #10 $finish;
end
//1> Boolean expressions and our sequencing

sequence s_ab; 
    a ##1 b;
endsequence

sequence s_cd;
    c ##1 d;
endsequence
    // Property
property p_expr;
    @(posedge clk) s_ab ##1 s_cd;
endproperty
// assert it 
assert property(p_expr);
endmodule

//3. Building a Two-Sequence Property
module test1; 
//1. sequence 1
sequence s_start_busy;
    req ##1 busy;
endsequence

//sequence 2
sequence s_busy_done;
   busy ##3 done;
endsequence


// property 
property p1_expr;
    @(posedge clk) s_ab1 ##1 s_cd1;
endproperty

// assert the property 
assert property(p1_expr);
endmodule
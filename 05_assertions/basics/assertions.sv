
// // A concise way of validating the functional checker of a property
// // immediate: executed as statements in procedural code

// module tb_assert1;
// bit a,b,c,d;
// bit clk;

// // generating the clk
// always #10 clk = ~clk;
// initial begin 
//     for(int i=0; i<20;i++) begin 
//         {a,b,c,d} = $random;
//         $display("[%0t], a, b, c, d", $time, a,b,c,d);
//         @(posedge clk);
//     end
//     #10 $finish;
// end
// //1> Boolean expressions and our sequencing

// sequence s_ab; 
//     a ##1 b;
// endsequence

// sequence s_cd;
//     c ##1 d;
// endsequence
//     // Property
// property p_expr;
//     @(posedge clk) s_ab ##1 s_cd;
// endproperty
// // assert it 
// assert property(p_expr);
// endmodule

// //3. Building a Two-Sequence Property
// module test1; 
// //1. sequence 1
// sequence s_start_busy;
//     req ##1 busy;
// endsequence

// //sequence 2
// sequence s_busy_done;
//    busy ##3 done;
// endsequence


// // property 
// property p1_expr;
//     @(posedge clk) s_ab1 ##1 s_cd1;
// endproperty

// // assert the property 
// assert property(p1_expr);
// endmodule
// immediate Assertions used in the SVA: executed based on simulation event semantics
// module my_des(my_if, _if);
//     always @(posedge _if.clk) begin 
//         if(_if.push) begin 
//             a_push : assert(!_if.full) begin 
//                 $display("[PASS] Push when FIFO not full");
//             end else begin 
//                 $display("[FAIL] Push when FIFO full");
//             end
//         end
//     end

// endmodule

// //a simple interface for the design under test
// interface my_if(input bit clk);
//     logic pop;
//     logic push;
//     logic empty;
//     logic full;
// endinterface

// module tb;
//     bit clk;
//     always #10 clk = ~clk;
//     // ---- //

//     initial begin 
//         for(int i=0; i<5; i++) begin 
//             //----
//             $strobe("[time: %0t]",$time);
//         end

//     end
// endmodule

class my_class;
    bit a,b,c;
    //bit clk;

    constraint c_abc{
        a == 1; c==1;
    }


endclass

module tb; 
bit a, b, c;
my_class mc;
// clk generation
bit clk;
always #10 clk = ~clk;
initial begin 
mc = new;
for(int i=0; i<10; i++) begin 
    @(posedge clk);
    a <= $random;
    b <= $random;
    c <= $random;
    $display("[%t] a: %b, b: %b, c:%b", $time, a, b, c);
end
#10 $finish;
end
assert property(@(posedge clk) !(!a ^ b) ); // simply means a != b
endmodule



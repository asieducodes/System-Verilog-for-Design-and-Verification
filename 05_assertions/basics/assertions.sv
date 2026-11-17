
// // // A concise way of validating the functional checker of a property
// // // immediate: executed as statements in procedural code

// // module tb_assert1;
// // bit a,b,c,d;
// // bit clk;

// // // generating the clk
// // always #10 clk = ~clk;
// // initial begin 
// //     for(int i=0; i<20;i++) begin 
// //         {a,b,c,d} = $random;
// //         $display("[%0t], a, b, c, d", $time, a,b,c,d);
// //         @(posedge clk);
// //     end
// //     #10 $finish;
// // end
// // //1> Boolean expressions and our sequencing

// // sequence s_ab; 
// //     a ##1 b;
// // endsequence

// // sequence s_cd;
// //     c ##1 d;
// // endsequence
// //     // Property
// // property p_expr;
// //     @(posedge clk) s_ab ##1 s_cd;
// // endproperty
// // // assert it 
// // assert property(p_expr);
// // endmodule

// // //3. Building a Two-Sequence Property
// // module test1; 
// // //1. sequence 1
// // sequence s_start_busy;
// //     req ##1 busy;
// // endsequence

// // //sequence 2
// // sequence s_busy_done;
// //    busy ##3 done;
// // endsequence


// // // property 
// // property p1_expr;
// //     @(posedge clk) s_ab1 ##1 s_cd1;
// // endproperty

// // // assert the property 
// // assert property(p1_expr);
// // endmodule
// // immediate Assertions used in the SVA: executed based on simulation event semantics
// // module my_des(my_if, _if);
// //     always @(posedge _if.clk) begin 
// //         if(_if.push) begin 
// //             a_push : assert(!_if.full) begin 
// //                 $display("[PASS] Push when FIFO not full");
// //             end else begin 
// //                 $display("[FAIL] Push when FIFO full");
// //             end
// //         end
// //     end

// // endmodule

// // //a simple interface for the design under test
// // interface my_if(input bit clk);
// //     logic pop;
// //     logic push;
// //     logic empty;
// //     logic full;
// // endinterface

// // module tb;
// //     bit clk;
// //     always #10 clk = ~clk;
// //     // ---- //

// //     initial begin 
// //         for(int i=0; i<5; i++) begin 
// //             //----
// //             $strobe("[time: %0t]",$time);
// //         end

// //     end
// // endmodule

// // class my_class;
// //     bit a,b,c;
// //     //bit clk;

// //     constraint c_abc{
// //         a == 1; c==1;
// //     }


// // endclass

// // module tb; 
// // bit a, b, c;
// // my_class mc;
// // // clk generation
// // bit clk;
// // always #10 clk = ~clk;
// // initial begin 
// // mc = new;
// // for(int i=0; i<10; i++) begin 
// //     @(posedge clk);
// //     a <= $random;
// //     b <= $random;
// //     c <= $random;
// //     $display("[%t] a: %b, b: %b, c:%b", $time, a, b, c);
// // end
// // #10 $finish;
// // end
// // assert property(@(posedge clk) !(!a ^ b) ); // simply means a != b
// // endmodule

// // A simple Sequence
// module tb; 
//     bit a, clk;
//     // sequence that a should be high on every posedge
//     // sequence a_seq; 
//     //     @(posedge clk) a;
//     // endsequence
//     // using the $rose()
//     sequence a_seq;
//        // @(posedge clk) $rose(a);
//        //  @(posedge clk) $fell(a);
//        @(posedge clk) $stable(a);
//     endsequence
//     // assert the property
   
//     always #10 clk = ~clk;
//     initial begin 
//         for(int i=0; i<10; i++) begin 
//             a = $random;
//             $display("[%0t], a: %0d", $time, a);
//             @(posedge clk);
//         end
//         #20 $finish;
//     end
//      assert property(a_seq);
// endmodule
// SVA with time delays 
module tb;
bit a,b;
bit clk;

//
// sequence
sequence s_ab;
    @(posedge clk) a ##2 b;
endsequence
// assert property
assert property (s_ab)
$display("Assertion Passed: %0t", $time);
// generating clk
always #10 clk = ~clk;
initial begin 
    for(int i=0; i<10; i++) begin 
        @(posedge clk);
        a <= $random;
        b <= $random;
        $display("[%0t] a: %b b: %b", $time, a,b);
    end
  #20 $finish;  
end

endmodule

module tb1; 
    bit req1, req2;
    bit clk;

    // clock generation 
    always #10 clk = ~clk;
    // sequence, once req1 is seen, req2 should stay on for three consecutive times
    sequence s_consec;
        @(posedge clk) req1 ##1 req2[*2:3];
    endsequence
    // using the goto 
    sequence s_goto;
       @(posedge clk) req1 [->2] ##1 req2;
    endsequence
    // using the non consecutive
    sequence non_consecutive;
        req1[=2] ##1 req2;
    endsequence
    // assert the property
    assert property(s_goto)
    $display("[%0t] Match: req held high for 3 consecutive cycles", $time);
    initial begin 
       for(int i=0; i<10; i++) begin 
         @(posedge clk);
         req1 <= $random;
         req2 <= $random;
         $display("The [%0t], req1: %0b req2: %0b", $time, req1,req2);
       end
       #20 $finish;

    end
endmodule

// combining sequences
module tb2;
bit clk, a,b,p,q;

// clk generation
always #10 clk = ~clk;

sequence seq1;
    a ##1 b;
endsequence
sequence seq2;
    // for and operation
   // p ##2 q;
   // for intersect operation
   p ##1 q;
endsequence
// combining the sequences
sequence seq_and;
  // @(posedge clk) seq1 and seq2;
 // @(posedge clk) seq1 intersect seq2;
  // or 
  @(posedge clk) seq1 or seq2;
endsequence
assert property(seq_and)
    $display("Match ends at: %0t", $time);
initial begin 
    for(int i=0; i<10; i++) begin 
        @(posedge clk);
        a <= $random;
        b <= $random;
        p <= $random;
        q <= $random;
        $display("[%0t] a:%0b, b: %0b, p:%0b, q:%0b", $time,a,b,p,q);
    end
    #15 $finish; 
end
endmodule
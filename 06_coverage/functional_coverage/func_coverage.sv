// // // Functional Coverage
// // // explicitly defining the coverpoint to track specific values
// // /*
// // coverpoint mode{
// //     bins featureA = {0};
// //     bins featureB = {[1:3]};
// // }
// // // Can be activated using the sample() method or the event type
// // covergroup CovGrp @(posedge clk);

// // // How to conditionally call enable the coverage 

// // covergroup CovGrp;
// //     coverpoint mode iff (!_if.reset){
// //     //bins
// //     }

// // endgroup

// // */
// // class myCov;
// //     covergroup CovGroup;
// //     endgroup
// //     // function to instantiate the covergroup
// //     function new();

// //     CovGroup = new;
// //     endfunction
    
  


// // endclass

// // module tb;
// //     myCov CovGroup0;
// //     initial begin 
// //         CovGroup0 = new();
// //         // calling the sample method
// //         CovGroup0.CovGroup.sample();
// //     end 
// // endmodule

// // class myCovGroup;
// //     covergroup myCovGrp;
// //     coverpoint key{
// //         bins low = {[0:1]};
// //         bins high = {[2:3]};
// //     }

// //     function new();
// //         myCovGroup = new;
// //     endfunction
    
// //     endgroup


// // endclass

// // a single coverpoint in action 
// module tb;
//     // declare variables
//     bit[1:0] mode;
//     bit[2:0] cfg;
//     // clk to be used for sampling
//     bit clk;
//     always #20 clk = ~clk;
//     // Create a cg covergroup that is sampled at every posedge of clk
//     covergroup cg @(posedge clk);
//         coverpoint mode;
//     endgroup
//     // create an instance of this cg
//     cg cg_inst;
//     initial begin 
//         cg_inst = new();
//        // stimulus to be assigned to the random variablws
//        for(int i=0; i<5;i++) begin 
//         @(negedge clk);
//         mode = $random;
//         cfg = $random;
//         $display("[%0t] mode=0x%0h cfg=0x%0h",$time, mode, cfg);
//        end 
//     end
//     // At the end of 500ns terminate and print the covergroup
//     initial begin 
//         #500 $display("Coverage = %0.2f %%",cg_inst.get_inst_coverage());
//         $finish();
//     end

// endmodule

// // Multiple Coverpoints in one Covergroup 
// module tb1;
//     bit[1:0] mode;
//     bit[1:0] cfg;
//     bit clk;

//     // Generating clk
//     always #20 clk = ~clk;
//     // covergroups
//     covergroup cg @(posedge clk);
//     // coverpoints can be given names
//     cp_mode : coverpoint mode;
//     cp_cfg : coverpoint cfg;
//     cp_cfg_10: coverpoint cfg[1:0];
//     cp_cfg_lsb: coverpoint cfg[0];
//     cp_sum : coverpoint (mode + cfg);

//     endgroup
//     // an instance of the covergroup 
//     cg cg_inst;
//     initial begin 
//         cg_inst = new();
//         for(int i=0; i<5; i++) begin 
//             @(negedge clk);
//             mode = $random;
//             cfg = $random;
//             $display("time[%0t], mode: 0x%0d, cfg: 0x%0d", $time, mode, cfg);
//         end
//     end 
//     initial begin 
//         #500 
//         $display("The functional coverage is: %0.2f%%",cg_inst.get_inst_coverage());
//         $finish;
//     end
// endmodule
// // BINS SYNTAX
// /*
// coverpoint mode{
// // manually create the bins
// bins zero = {0};
// bins one = {1};

// // Allow SV to create them automatically
// bins range[] = [{0:$}]; // from 0 to the last maximum


// }

// */

// module tb2;
//     bit[2:0] mode;
//     bit[3:0] addr;
//     // coverpoint for the mode
//     covergroup cg;
//         coverpoint mode {
//            // bins zero ={0};
//            // bins range[] = {[1:$]};
//            bins range[3] = {0,[1:4], 7};
//         }   
//         coverpoint addr{
//             bins range[2]={[0:$]};
//         }
//     endgroup
//     cg cg_inst;
//     initial begin 
//         cg_inst = new();
//         for(int i=0; i<5; i++) begin 
//             #10 mode = $random; addr = $random;
//          //   $display("[%0t] and the mode: 0x%0d", $time, mode);
//             $display("[%0t] and the addr: 0x%0d", $time, addr);
//             cg_inst.sample();
//         end
//         $display("Coverage: %0.2f%%", cg_inst.get_inst_coverage());
//     end
// endmodule
// // A basic cross coverage

// covergroup master_slave_interaction @(posedge clk);
//     master_id_cp:coverpoint{
//         bins master0 = {0};
//         bins master1 = {1};
//         bins master2 = {2};
//         bins master3 = {3};
//     }
//     slave_id : coverpoint {
//         bins slave0 = {0};
//         bins slave1 = {1};
//     }
//     // master slave cross
//     ms_cross: cross master_id_cp, slave_id_cp{
//         master_slavee0 = binsof(mas)
//     }
// endgroup

// // user defined cross coverage
// covergroup cg;
//     cp_dir: coverpoint dir{
//         bins read = {0};
//         bins write = {1};
//     }
//     cp_region: coverpoint region{
//         bins low = {0};
//         bins high = {1};
//     }
//     dir_region_cross:cross cp_dir, cp_region{
//         bins_of_all = binsof(cp_region) intersect {1};
//     }

// endgroup

// class vif_transaction;
//     rand bit[3:0] mode;
//     rand bit[3:0] data;

//     constraint c_mode{ mode >= 2; mode < 15;}

// endclass

// module tb3;

//     bit[3:0] mode;
//     bit[3:0] data;
//     bit clk;
//     always #10 clk = ~clk;

//     covergroup cg @(posedge clk);
//         cp_addr: coverpoint mode{
//             option.at_least = 4;
//             bins low = {[0:7]};
//             bins high ={[8:15]};
//             // option to check the coverage
            
//         }
//     endgroup
//     cg cg_inst;
//     initial begin 
//         cg_inst = new;
//         //@(negegde clk);
//        for(int i=0; i<8; i++) begin 
//         #10
//         mode = $random;
//         data = $random;
//             $display("[%0t], mode: %0d, data: %0d",$time, mode, data);
//         end
//         cg_inst.sample();
//         $display("Coverage: %0.2f%%", cg_inst.get_inst_coverage());
//         $finish;
//     end

// endmodule




// testing the code 
// module test1;
//  logic[3:0] a,b;

//  initial begin 

//     a = 5;
//     b = 2;

//      a<= #10 b;
//      b<= #5 a;
//  end  
// initial begin 
//     #10
//     $display("a: %0d, and b: %0d", a,b);
// end

// endmodule

// Cover options
// goal: sets the target percentage that needs to be achieved to be considered complete 

module tb4;
    bit[3:0] mode, addr;
    bit clk;

    always #10 clk = ~clk;

covergroup cg @(posedge clk);
    option.goal = 80; // target completed once 80% is reached
    option.comment="coverage scheduled by Ing. Seth";
    option.per_instance = 1;
    cp_mode : coverpoint mode{
        bins low[] = {[0:$]};
    }


endgroup
 cg cg_inst;
initial begin 
    cg_inst = new;
    @(negedge clk);
    for(int i=0; i<10; i++) begin 
        #10 mode = $random;
        $display("[%0t], mode: %0d",$time,mode);
    end
    cg_inst.sample();
end
     initial begin 
        #100 $display("the functional coverage: %0.2f%%", cg_inst.get_inst_coverage());
        $finish;  

     end
endmodule



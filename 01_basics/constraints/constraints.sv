// // // class Packet;
// // //     rand bit[7:0] addr;
// // //     rand bit[7:0] data;
// // //     constraint addr_range {addr inside {[8'h00 : 8'h7F]};}
// // // endclass

// // // // 2. Transaction
// // // class BusTransaction;
// // //     rand bit[7:0] addr;
// // //     rand bit[31:0] data;
// // //     rand bit[1:0] burst_len;

// // //     // addr must be 4 byte aligned
// // //     constraint align_addr {addr[1:0] == 2'b00;}
// // //     // burstlen between 1 and 3
// // //     constraint valid_burst {burst_len >= 1; burst_len <=4;}

// // // endclass

// // // /*constraint c3 {opcode inside{READ, WRITE, IDLE};}
// // // // using the dist 
// // // constraint cmd_dist{
// // //     cmd dist{
// // //         READ:= 70, WRITE:= 30
// // //     };
// // // }
// // // */

// // // Exercise: Combine dist and implication
// // class Frame;
// //     rand bit[2:0] kind;
// //     rand bit[7:0] len;
// //     constraint c_kind_dist{
// //         kind dist {0:=60, 1 := 30, 2:= 10};
// //     }
// //     // len to be 0 when kind is IDLE
// //     constraint c_idle_len{
// //         (kind == 2) -> (len == 0);
// //     }
// //     function new(bit[2:0] k = 0, bit[7:0] l = 10); begin 
// //         kind = k;
// //         len = l;
// //     end
// //     endfunction
// // endclass

// // module tb;
// //   Frame frame;

// //   initial begin
// //     frame = new(); // Create the object
    
// //     // Wrap the randomization in a mandatory asset check
// //     assert(frame.randomize() with { kind == 2; }) else begin
// //       $fatal(1, "Randomization failed! Check for conflicting constraints.");
// //     end
    
// //     // This line only runs if randomization succeeds
// //     $display("SUCCESS: The frame is: %0d and the len is: %0d", frame.kind, frame.len);
// //   end
// // endmodule
// // // Additional Notes to be added

// // class Packet;
// //     rand bit[3:0] mode;
// //     rand bit[3:0] result;
// //     // adding the constraint 
// //     constraint c_mode{
// //         mode > 2; mode <= 6;
// //     }
// //     constraint result_mode{
// //         (mode > 4) -> (result == 5); | (mode < 5) -> (result == 2);
// //     }
// // endclass

// // module tb1;
// //     Packet pkt1;

// //     initial begin 
// //         pkt1 = new();
// //         for(int i=0; i<5; i++) begin 
// //             assert(pkt1.randomize()) else $fatal(1,"Randomization failed");
// //             $display("mode = %0d and the result: %0d",pkt1.mode, pkt1.result);
// //         end
// //     end

// // endmodule

// // class BusTransaction;
// //     rand bit [31:0] addr;
// //     rand bit [7:0]  data;
// //     rand bit [2:0]  burst_len;
// //     rand bit        read_write;  // 0 = read, 1 = write

// //     // Address must be 4-byte aligned
// //     constraint c_addr_align {
// //         addr[1:0] == 2'b00;
// //     }

// //     // Address must be within a valid MMIO window
// //     constraint c_addr_range {
// //         addr >= 32'hF000_0000;
// //         addr <= 32'hFACE_FACE;
// //     }

// //     // Burst length is 1 to 4 beats
// //     constraint c_burst {
// //         burst_len >= 1;
// //         burst_len <= 4;
// //     }

// //     // Read transactions carry no write data
// //     constraint c_read_data {
// //         (read_write == 0) -> (data == 8'h0);
// //     }
// // endclass

// // // External Constraint Example

// // class ABC;
// //     rand bit[3:0] mode;
// //     constraint c_implicit;
// //     extern constraint c_explicit;
// // endclass
// // //  Writing the constraint body
// // constraint ABC::c_implicit {mode > 2;}
// // constraint ABC::c_explicit {mode <= 6;}
// // module tb2;
// // ABC abc;
// // initial begin 
// //     abc = new();
// //     for(int i =0; i<5; i++) begin 
// //         abc.randomize();
// //         $display("mode: %0d", abc.mode);
// //     end
// // end
// // endmodule
// // // Challenge
// // class BaseCmd;
// //     rand bit[3:0] opcode;
// //     constraint c_op {opcode inside {[0:15]};}
// // endclass

// // // Subclass
// // class RestrictedCmd extends BaseCmd;
// //     constraint c_op {opcode inside {[0:3]};}
// // endclass

// // module tb3;
// //     RestrictedCmd rcmd;

// //     initial begin 
// //         rcmd = new();
// //         for (int i =0; i<5; i++) begin 
// //             assert(rcmd.randomize()) else $fatal(1,"Error, Randomization Failed");
// //             $display("The value is: %0d",rcmd.opcode);
// //         end
// //     end

// // endmodule
// // // Example 
// // module tb4;
// // bit[3:0] m_data;
// // bit     flag;
// // initial begin 
// // for (int i=0; i<10; i++) begin 
// //     m_data = $random;
// //     // A ternary flag
// //     flag = m_data inside {[4:9]} ? 1 : 0;
// //     // Used with "if - else clauses"
// //     if (m_data inside {[4:9]})
// //         $display("INSIDE[4:9] m_data: %0d and flag: %0d",m_data,flag);
// //     else $display("OUTSIDE[4:9] m_data: %0d and flag: %0d",m_data,flag);
// // end
// // end

// // endmodule
// // // Inverted or negating the constraint 
// // // constraint c_od {! code inside {[11:20]};}
// // //constraint addr_rng {! addr inside {[16'h8000:16'h80FF]}}

// // // Examples of Constraints
// // class MyClass;
// //     rand bit[7:0] typ;
// //     // constraint dist1{
// //     //     typ dist {0:=20, [1:5]:=50, 6:=40, 7:=10};
// //     // }
// //     constraint dist2{
// //         typ dist {0:/20, [1:5]:/50, 6:/40, 7:/10};
// //     }
// // endclass
// // // Class for transaction
// // class Trans;
// //     rand bit[7:0] data;
// //     rand bit is_write;
// //     // constraint for is_write
// //     constraint write_en{
// //         if(is_write) data != 0;
// //         else data ==0;
// //     }
// // endclass

// // module tb5;

// // MyClass myclass;
// // Trans trans;
// // SolveClass abc;
// // initial begin 
// //     for(int i=0; i<5; i++) begin 
// //         myclass = new();
// //         abc = new();
// //         assert(myclass.randomize()) else $fatal(1,"ERROR OCCURRED");
// //         $display("number: %0d typ: %0d", i,myclass.typ);
// //     end
// //     for(int i=0; i<10; i++)begin 
// //         abc.randomize();
// //         $display("value of a: %0d and b: %0d",abc.a,abc.b);
// //     end
// // end

// // endmodule

// // // solve and before 
// // class SolveClass;
// //     rand bit a;
// //     rand bit[2:0] b;
// //     constraint c_ab{
// //         a -> b == 3'h3;
// //     // solve a before
// //     solve a before b; //solve for the value of a before the value of b
// //     }
// // endclass

// // Dynamic Arrays and Queues
// // class ABD;
// //     rand bit[3:0] array[];
// //     rand bit[3:0] queue[$];
// //     // Assign size constraint to the queue
// //     constraint c_qsize{
// //         queue.size() == 5;
// //     }
// //     // Constraint each element of both the arrays
// //     constraint c_array{
// //         foreach(array[i])
// //             array[i] == i;
// //             foreach(queue[i])
// //                 queue[i] ==i+1;
// //     }
// //     function new() begin 
// //         array = new[5];
// //     end
// //     endfunction
// // endclass
// // // Multi dimensional array
// // class ABC;
// //   rand bit[4:0][3:0] md_array [3][5]; 	// Multidimensional Arrays

// //   constraint c_md_array {
// //     foreach (md_array[i]) {
// //     	foreach (md_array[i][j]) {
// //           foreach (md_array[i][j][k]) {
// //             if (k %2 == 0)
// //               md_array[i][j][k] == 'hF;
// //             else
// //               md_array[i][j][k] == 0;
// //         }
// //       }
// //     }
// //   }


// // endclass

// // module tb;

// //   initial begin
// //     ABC abc = new;
// //     abc.randomize();
// //     $display ("md_array = %p", abc.md_array);
// //   end

// // endmodule

// // Non static constraint 
// class vif_transaction1;
//   rand bit[3:0] operand_a;
//   rand bit[3:0] operand_b;
//   // Non static constraints
//   constraint c1 {operand_a > 2;}
//   //constraint c2 {operand_b > 0;}
//   // static constraint
//   static constraint c2 {operand_b == 10;}
  
// endclass
// // sot constraint 
// class vif_verification2;
//   rand bit[3:0] data;
//   constraint c1{soft data > 5;}
// endclass

// class vif3_verification extends vif_verification2;
//   constraint c_new{
//     disable soft data;
//     soft data inside {0,1,5};
//   }
// endclass
// module tb;
// // instantiate the class
// vif_transaction1 vif1,vif2;
// vif_verification2 vif3;
// initial begin 
//   vif1 = new;
//   vif2 =new;
//   vif3 =new;
//   // randomize in a for loop
//   // Turn off non static constraint
//   // vif1.c1.constraint_mode(0);
//   // for(int i=0; i<5; i++) begin 
//   // //assert(vif1.randomize()) else $fatal(1,"ERROR OCCURED");
//   // vif1.randomize();
//   // vif2.randomize();
//   // $display(" VIF1 %0d and %0d\n VIF2 %0d and %0d", vif1.operand_a, vif1.operand_b, vif2.operand_a,vif2.operand_b);
//   // //$display("Values [operand_a]: %0d and [operand_b]: %0d", vif2.operand_a, vif2.operand_b);
//   // end

//   vif1.c2.constraint_mode(0);
//   for(int i=0; i<5; i++) begin 
//   //assert(vif1.randomize()) else $fatal(1,"ERROR OCCURED");
//  // vif1.randomize();
//   //vif2.randomize();
//   vif3.randomize() with {vif3.data inside {[0:3]};};
//   //$display(" VIF1 %0d and %0d\n VIF2 %0d and %0d", vif1.operand_a, vif1.operand_b, vif2.operand_a,vif2.operand_b);
//   //$display("Values [operand_a]: %0d and [operand_b]: %0d", vif2.operand_a, vif2.operand_b);
//   $display("Value: %0d", vif3.data);
//   end
// end
// endmodule

// // Burst [ 0 -> 1 byte, 1 -> 2 bytes, 2 -> 3 bytes, 3 -> 4 bytes]
// // Length -> max 8 transactions per burst
// // Protocol expects to send only first addr, and slave should calculate all
// // other addresses from burst and length properties
// class BusTransaction;
//   rand int 			m_addr;
//   rand bit [31:0]	m_data;
//   rand bit [1:0] 	m_burst; 	// Size of a single transaction in bytes (4 bytes max)
//   rand bit [2:0] 	m_length; 	// Total number of transactions
//   constraint c_addr {addr % 4 == 0;}
//   // function to display
//   function void display(int idx = 0); begin
//     $display("--------------------Transaction %0d");
//     $display ("------ Transaction %0d------", idx);
//     $display (" Addr 	= 0x%0h", m_addr);
//     $display (" Data 	= 0x%0h", m_data);
//     $display (" Burst 	= %0d bytes/xfr", m_burst + 1);
//     $display (" Length  = %0d", m_length + 1);
//    end    
  
//  endfunction
// endclass

// module tb1;
// int slave_start;
// int slave_end;
//  BusTransaction bt;
//  initial begin 
//   slave_start = 32'h200;
//   slave_end = 32'h800;
//   bt = new;
//   // inline randomization
//   bt.randomize() with { m_addr >= slave_start;
//                          m_addr < slave_end;
//                          (m_burst + 1) * (m_length + 1) + m_addr < slave_end;
//                         };
//     bt.display();
//  end
// endmodule

// //Memoery Block Randomization
// class MemoryBlock;
//   // start and end address
//   bit[31:0] m_ram_start;
//   bit[31:0] m_ram_end;
//   // randomize values
//   rand bit[31:0] m_start_addr,m_end_addr;
//   rand int m_block_size;
//   // constraints
//   constraint c_addr{
//     m_start_addr >= m_ram_start; // block addr > ram start
//     m_end_addr <= m_ram_end;
//     m_start_addr % 4 == 0; // 4 byte bond
//     m_end_addr == m_start_addr + m_block_size - 1;
//   }
//    constraint c_blk_size { m_block_size inside {64, 128, 512 }; }; 	// Block's size should be either 64/128/512 bytes

//   function void display();
//     $display ("------ Memory Block --------");
//     $display ("RAM StartAddr   = 0x%0h", m_ram_start);
//     $display ("RAM EndAddr     = 0x%0h", m_ram_end);
// 	$display ("Block StartAddr = 0x%0h", m_start_addr);
//     $display ("Block EndAddr   = 0x%0h", m_end_addr);
//     $display ("Block Size      = %0d bytes", m_block_size);
//   endfunction
// endclass

// module tb1;
//   initial begin
//     // MemoryBlock mb = new;
//     // mb.m_ram_start = 32'h0;
//     // mb.m_ram_end   = 32'h7FF; 		// 2KB RAM
//     // mb.randomize();
//     // mb.display();

//   end
// endmodule

// unique constraint 
// better to use this unique than to use the != for all pairs
class ABC;
  rand bit[1:0] a,b,c;
  rand bit[1:0] arr[4];
  constraint c_unique {unique {a,b,c};}
  // excluding an element from the uniqueness
  constraint c_pin {a==0; b==1;}
  

endclass

module tb;
ABC myABC;
initial begin 
  myABC =new;
  for(int i =0; i<5; i++) begin 
    assert(myABC.randomize()) else $fatal(1,"Error Occurred");
    $display("the values: [a]: %0d, [b]: %0d, [c]: %0d",myABC.a,myABC.b,myABC.c);
  end
end

endmodule
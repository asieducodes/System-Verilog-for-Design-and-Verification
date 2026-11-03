// class Packet;
//     rand bit[7:0] addr;
//     rand bit[7:0] data;
//     constraint addr_range {addr inside {[8'h00 : 8'h7F]};}
// endclass

// // 2. Transaction
// class BusTransaction;
//     rand bit[7:0] addr;
//     rand bit[31:0] data;
//     rand bit[1:0] burst_len;

//     // addr must be 4 byte aligned
//     constraint align_addr {addr[1:0] == 2'b00;}
//     // burstlen between 1 and 3
//     constraint valid_burst {burst_len >= 1; burst_len <=4;}

// endclass

// /*constraint c3 {opcode inside{READ, WRITE, IDLE};}
// // using the dist 
// constraint cmd_dist{
//     cmd dist{
//         READ:= 70, WRITE:= 30
//     };
// }
// */

// Exercise: Combine dist and implication
class Frame;
    rand bit[2:0] kind;
    rand bit[7:0] len;
    constraint c_kind_dist{
        kind dist {0:=60, 1 := 30, 2:= 10};
    }
    // len to be 0 when kind is IDLE
    constraint c_idle_len{
        (kind == 2) -> (len == 0);
    }
    function new(bit[2:0] k = 0, bit[7:0] l = 10); begin 
        kind = k;
        len = l;
    end
    endfunction
endclass

module tb;
  Frame frame;

  initial begin
    frame = new(); // Create the object
    
    // Wrap the randomization in a mandatory asset check
    assert(frame.randomize() with { kind == 2; }) else begin
      $fatal(1, "Randomization failed! Check for conflicting constraints.");
    end
    
    // This line only runs if randomization succeeds
    $display("SUCCESS: The frame is: %0d and the len is: %0d", frame.kind, frame.len);
  end
endmodule
// Additional Notes to be added

class Packet;
    rand bit[3:0] mode;
    rand bit[3:0] result;
    // adding the constraint 
    constraint c_mode{
        mode > 2; mode <= 6;
    }
    constraint result_mode{
        (mode > 4) -> (result == 5); | (mode < 5) -> (result == 2);
    }
endclass

module tb1;
    Packet pkt1;

    initial begin 
        pkt1 = new();
        for(int i=0; i<5; i++) begin 
            assert(pkt1.randomize()) else $fatal(1,"Randomization failed");
            $display("mode = %0d and the result: %0d",pkt1.mode, pkt1.result);
        end
    end

endmodule

class BusTransaction;
    rand bit [31:0] addr;
    rand bit [7:0]  data;
    rand bit [2:0]  burst_len;
    rand bit        read_write;  // 0 = read, 1 = write

    // Address must be 4-byte aligned
    constraint c_addr_align {
        addr[1:0] == 2'b00;
    }

    // Address must be within a valid MMIO window
    constraint c_addr_range {
        addr >= 32'hF000_0000;
        addr <= 32'hFACE_FACE;
    }

    // Burst length is 1 to 4 beats
    constraint c_burst {
        burst_len >= 1;
        burst_len <= 4;
    }

    // Read transactions carry no write data
    constraint c_read_data {
        (read_write == 0) -> (data == 8'h0);
    }
endclass

// External Constraint Example

class ABC;
    rand bit[3:0] mode;
    constraint c_implicit;
    extern constraint c_explicit;
endclass
//  Writing the constraint body
constraint ABC::c_implicit {mode > 2;}
constraint ABC::c_explicit {mode <= 6;}
module tb2;
ABC abc;
initial begin 
    abc = new();
    for(int i =0; i<5; i++) begin 
        abc.randomize();
        $display("mode: %0d", abc.mode);
    end
end
endmodule
// Challenge
class BaseCmd;
    rand bit[3:0] opcode;
    constraint c_op {opcode inside {[0:15]};}
endclass

// Subclass
class RestrictedCmd extends BaseCmd;
    constraint c_op {opcode inside {[0:3]};}
endclass

module tb3;
    RestrictedCmd rcmd;

    initial begin 
        rcmd = new();
        for (int i =0; i<5; i++) begin 
            assert(rcmd.randomize()) else $fatal(1,"Error, Randomization Failed");
            $display("The value is: %0d",rcmd.opcode);
        end
    end

endmodule
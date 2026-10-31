// // System Verilog Randomization:

// class myPacket;
//     rand bit[3:0] mode;
// endclass

// module tb_top;

// myPacket pkt;
// initial begin 
//     int addr, data;
//     for(int i=0; i<4;i++) begin 
//     pkt = new();
//     pkt.randomize();
//     $display("mode = %0d", pkt.mode); end
//     if(std::randomize(addr, data) with {addr inside {[0:255]}; data < 100;}) begin
//      $display("addr = %0d data = %0d", addr, data);
//     end else begin
//       $display("randomization failed");
//     end
// end
// endmodule

// class Packet;
//     rand bit[1:0] mode;
//     constraint c_mode {mode < 3;} // mode can only be 0, 1,2
// endclass
// module mytb1;
// Packet pkt;
// //int delay;
// initial begin 
// pkt = new();
// for(int i=0; i<5; i++) begin 
//     if(pkt.randomize()) begin 
//     $display("OK -> mode: %0d", pkt.mode);
// end
// else begin 
//     $display("FAILED: -> mode: %0d", pkt.mode);
// end
// end
// int delay;
// if(std::randomize(delay) with {delay inside {[5:20]};}) begin 
//     $display("OKAY: delay=%0d", delay);
// end
// else begin 
//     $display("FAILED: delay=%0d", delay);
// end
// end

// // This can never be satisfied
// // if(pkt.randomize() with {mode == 5;}) begin 
// //     $display("Randomization OK-> %0d", pkt.mode);
// // end
// // else begin 
// //     $display("Randomization FAILED-> %0d", pkt.mode);
// // end


// // Randomize a delay inside with the std::randomize

// endmodule


// module ex1;

// initial begin 
//     int delay;
//     for(int i=0; i<5; i++) begin
//     if(std::randomize(delay) with {delay inside {[5:20]};}) begin 
//         $display("OKAY: value: %0d", delay);
//     end
//     else begin 
//         $display("FAILED: value: %0d", delay);
//     end end
// end
// endmodule

// simple test

// class myTest;
//     randc bit[3:0] data;
//     randc bit[1:0] dt;
// endclass

// module tb4;
// myTest mt1;
// initial begin 
// mt1 = new();
// for(int i=0; i<5;i++) begin 
//     mt1.randomize();
//     $display("The current iter: %0d and the value is: %0d\tand dt1: %0d",i,mt1.data,mt1.dt);
// end
// end

// endmodule
// pre_randomize and post_randomize
class Beverage;
    rand bit[7:0] beer_id;
    bit[7:0] checksum;
    constraint c_beer_id {beer_id >= 10; beer_id <=50;};

    function void pre_randomize(); begin 
        $display("This function will be called just before randomization");
    end endfunction
    function void post_randomize(); begin
        checksum = ~beer_id; 
        $display("This function will be called just after randomization");
        $display("checksum: %d", checksum);
    end endfunction
endclass

module tb5;
Beverage b;
initial begin
      b = new ();
      $display ("Initial beerId = %0d", b.beer_id);
      if (b.randomize ())
      	$display ("Randomization successful !");
      $display ("After randomization beerId = %0d", b.beer_id);
    end
endmodule
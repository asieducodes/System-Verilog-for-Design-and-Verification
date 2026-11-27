// // // // // // a way of bundling the same signals together in a single block to be reusable in other components
// // // // // // A Basic Interface is the APB interface 
// // // // // interface apb_if(input pclk);
// // // // // logic[31:0] paddr;
// // // // // logic[31:0] pwdata;
// // // // // logic[31:0] prdata;
// // // // // logic penable;
// // // // // logic pwrite;
// // // // // logic psel;
// // // // // endinterface

// // // // // simple interface 

// // // // interface myBus(input clk);
// // // //     // signals
// // // //     logic[7:0] data;
// // // //     logic enable;
// // // // // modport from testbench perspective
// // // // modport TB( input data,clk, output enable);

// // // // // modport from the DUT, data is output
// // // // modport DUT(output data, input enable, clk);
// // // // endinterface

// // // // //connecting the interface to the DUT
// // // // module dut(myBus busIf);
// // // // always @(posedge busIf.clk)
// // // //     if(busIf.enable)
// // // //         busIf.data <= busIf.data + 1;
// // // //     else
// // // //         busIf.data <= 0;
// // // // endmodule

// // // // // Top testbench module
// // // // module tb_top;
// // // // bit clk;
// // // // // create a clk
// // // // always #10 clk = ~clk;

// // // // // create an interface object
// // // // myBus my_if(clk);

// // // // // instantiate DUT and pass modport dut to it
// // // // dut dut0(my_if.DUT);

// // // // initial begin 
// // // //     my_if.enable<=0;
// // // //     #10 my_if.enable <= 1;
// // // //     #40 my_if.enable <= 0;
// // // //     #20 my_if.enable <= 1;
// // // //     #100 $finish;
// // // // end

// // // // endmodule

// // // // //a producer to a consumer
// // // // interface stream_if;
// // // // logic valid, ready;
// // // // logic[7:0] data;
// // // // //modports
// // // // modport src(output data,valid, input ready);
// // // // modport dst (input data,valid, output ready);
// // // // endinterface 

// // // // // module for the DUT
// // // // module producer(input logic clk,rst_n, stream_if.src);
// // // // always_ff @(posedge clk or negedge rst_n) begin 
// // // //     if(!rst_n) begin s.valid <= 1'b0; s.data <= 8'0; end 
// // // //     else if(!s.valid || s.ready) begin 
// // // //         s.valid <= 1'b1; s.data <= s.data + 1'8d;
// // // //     end
// // // // end
// // // // endmodule

// // // // module consumer(input logic clk, rst_n, stream_if.dst d, output logic[7:0] data);
// // // //     always_ff @(posedge clk || negedge rst) begin 
// // // //         if(!rst_n) last <= 0'8d;
// // // //         else if (d.valid) last <= d.data;
// // // //     end
// // // // endmodule


// // // // // Tasks, Functions, Assertions, and Coverages inside an Interface
// // // // interface cnt_if #(parameter WIDTH = 4)(input logic clk);
// // // // // signals in the interface
// // // //     logic rstn,
// // // //     logic load_en,
// // // //     logic[WIDTH-1:0] data,
// // // //     logic[WIDTH-1:0] count.
// // // //     logic down,
// // // //     logic rollover
// // // //     // task: it called by other modules 
// // // //     task automatic reset (input int cycles = 3);
// // // //         rst_n <= 0;
// // // //         repeat(cycles) @(posedge clk);
// // // //         rstn <= 1;
// // // //     endtask
// // // //     property p_reset_holds_count;
// // // //     @(posedge clk) !rst_n |-> count == 0;
// // // //     endproperty
// // // //     // a minimal coverpoint
// // // //     covergroup cg_load_en(@ posedge clk);
// // // //     cp_enable: coverpoint load_en;
// // // //     endgroup
// // // //     cg_load_en cg_inst = new();
// // // // endinterface


// // // // // Using the Generic Interface 
// // // // // module myDesign(interface a, input logic clk);
// // // // //     always @(posedge clk)
// // // // //             ....
// // // // // endmodule
// // // // //clocking: a way preventing race conditions
// // // // clocking c_clock a(posedge clk);

// // // // endclocking


// // // module des(input logic clk, req, output logic gnt);
// // //     always @(posedge clk)
// // //     gnt <= req;
// // // endmodule
// // // //2. Interface with a clocking block
// // // interface req_gnt_if(input logic clk);
// // // // declaring the signals
// // // logic req;
// // // logic gnt;
// // // // clocking 
// // // clocking cb @(posedge clk);
// // //     default input #1step output #1ns;
// // //     // signal directions
// // //     input gnt;
// // //     output req;
// // // endclocking
// // // endinterface

// // // //3. Testbench
// // // module tb;
// // // logic clk;
// // // // generate clk
// // // initial clk=0;
// // // always #5 clk = ~clk;
// // // // instantiate the interface and the design
// // // req_gnt_if vif(.clk(clk));
// // // des dut(.clk(clk), .gnt(vif.gnt), .req(vif.req));

// // // initial begin 
// // //     //Drive req through the clocking block
// // //     vif.req <= 0;
// // //     @(vif.cb); // wait for one clk edge 
// // //     vif.cb.req <= 1; // assert request
// // //     @(vif.cb);
// // //     @(vif.cb); // gnt is sampled 1 step before
// // //     $display("gnt= %b",vif.gnt);
// // //     @(vif.cb);
// // //     vif.cb.req <= 0;
    
// // // end
// // // endmodule
// // // // Clocking block
// // // module tb1;
// // // logic clk;
// // // initial clk = 0;
// // // always #10 clk = ~clk;

// // // endmodule

// // // input skew in Detail
// // module my_module(
// //     output logic[3:0] out; 
// // );
// // endmodule

// // //2. interface
// // interface my_if (input logic clk);
// // logic[3:0] out;

// // clocking cb @(posedge clk);
// // default input #0 out;
// // endclocking

// // clocking cb_1 @(posedge clk);
// // default input #1step out;
// // endclocking
// // endinterface
// // // There are two types of connecting; generic and named port
// // Design Example: two modules master and slave connected by a single bus
// //1. Interface
// interface ms_if(input logic clk);
// // signals
// logic sready; // indicate when a slave wants to send
// logic rstn; // active low reset
// logic[1:0] addr; // address
// logic [7:0] data;
// //2. modports
// modport slave(input addr, data, rstn, clk, output sready);
// modport master(output addr, data, input clk, sready, rstn);
// endinterface

// // 3. Design
// module master (ms_if.master mif);
// always @(posedge mif.clk) begin 
//     if(!mif.rstn) begin 
//         mif.addr <= 0;
//         mif.data <= 0;
//     end
//     else begin 
//         // send new addr and data
//         if(mif.sready) begin 
//             mif.addr <= mif.addr + 1;
//             mif.data <= mif.addr * 4;
//         end
//         else begin 
//             mif.addr <= mif.addr;
//             mif.data <= mif.data;
//         end
//     end
// end
// endmodule 

// module slave (ms_if.slave sif);
//   reg [7:0] reg_a;
//   reg [7:0]	reg_b;
//   reg 		reg_c;
//   reg [3:0] reg_d;

//   reg		dly;
//   reg [3:0] addr_dly;

//   always @ (posedge sif.clk) begin
//     if (! sif.rstn) begin
//       addr_dly <= 0;
//     end else begin
//       addr_dly <= sif.addr;
//     end
//   end

//   always @ (posedge sif.clk) begin
//     if (! sif.rstn) begin
//       	reg_a <= 0;
//     	reg_b <= 0;
//     	reg_c <= 0;
//     	reg_d <= 0;
//   	end else begin
//       case (addr_dly)
//         0 : reg_a <= sif.data;
//         1 : reg_b <= sif.data;
//         2 : reg_c <= sif.data;
//         3 : reg_d <= sif.data;
//       endcase
//     end
//   end

//   assign sif.sready = ~(sif.addr[1] & sif.addr[0]) | ~dly;

//   always @ (posedge sif.clk) begin
//     if (! sif.rstn)
//       dly <= 1;
//     else
//       dly <= sif.sready;
//   end

// endmodule

// // tying them together with the same instance'
// module tb_top(mif tif);
//     // pass the master modport to master and same for the slave
//     master m0(tif.master);
//     slave s0 (tif.slave);
// endmodule

// // Testbench
// module tb; 
// reg clk;
// always #10 clk = ~clk;

// ms_if if0(clk);
// tb_top d0 (if0);
// initial begin 
//     clk <= 0;
//     if0.rstn <= 0;
//     repeat(5) @(posedge clk);
//     if0.rstn <= 1;
//     repeat(20) @(posedge clk);
//     $finish;
// end
// endmodule
// // combining modport with clocking

// interface req_gnt_if(input logic clk);
// logic req;
// logic gnt;
// logic rstn;

// clocking cb @(posedge clk);
//     default input #1step output #2ns;
//     input req; // testbench drives and goes into design
//     output gnt; // testbench reads
// endclocking
// modport TB (clocking cb, output rstn);
// modport DUT (input req,rstn,clk, output gnt);
// endinterface

// // Parameterizing the Interfaces
// interface myBus #(parameter D_WIDTH = 31)(input logic clk);
//   logic [D_WIDTH-1 :0] data;
//   logic enable;
//   clocking cb @(posedge clk);
//     default input #1step output #2ns;
//     input data;
//     output enable;
//   endclocking
// endinterface

// module bus_slave #(parameter D_WIDTH = 31)(myBus myBus_if);
//   logic[D_WIDTH-1: 0] captured_data;
//   always @(posedge myBus_if.clk)
//     if (myBus_if.enable)
//       captured_data <= myBus_if.data;

// endmodule

// //top module
// module top_tb;
// myBus #(.D_WIDTH(8)) mybus(clk);


// endmodule

// // Declaring a type parameter: to be able to use different types
// // declared with parameter type
// module generic_reg #(
//   parameter type T = logic[7:0],
//   parameter T RESET_VAL = '0
// )(
//   input logic clk,
//   input logic rst_n,
//   input logic en,
//   input T d,
//   output T q
// );
// always @(posedge clk)
//   if(!rst_n) q <=RESET_VAL;
//   else if(en) q <= d;

// endmodule
// // Overriding the parameter type at instantiation
// module top(
//   logic clk, en, rst_n
// );

// generic_reg g_reg #(.T(logic[15:0]), .clk, .rst_n, .en, .d(16'BEEF), .q());


// endmodule
// // Type parameter also works on interfaces
// interface generic_if #(
//   parameter type T = logic[7:0]);

//   T data,
//   logic valid,
//   logic ready
//   clocking cb @(posedge clk);

//   endclocking
//   modport();
// endinterface

// // Exercise 
// module generic_eq #(
//   parameter type T = logic[7:0]
// )(
//   T a ,
//   T b,
//   logic match
// );
// assign match = (a == b);
// endmodule

// // top module
// module eq_top(
//   logic[7:0] a,b,
//   logic match
// );

// generic_eq my_eq (.a,.b,.match);
// generic_eq #(.T(logic[31:0])) my_32_eq(.a,.b.match);
// endmodule
// Virtual Interfaces

interface req_gnt_if(input logic clk);
  logic req;
  logic gnt;
  logic rstn;
  // clocking
  clocking cb@(posedge clk)
    default input #1step output #2ns;
    output req;
    input gnt;
  endclocking
  // modports
  modport TB(clocking cb, output rstn);
endinterface: reg_gnt_if

//  A driver class
class Driver;
  //virtual interface handler
  virtual req_gnt_if.TB vif;

  function new();
  this.vif = vif;
  endfunction:new
  // task 
  task drive_req(bit value);
    vif.cb.req <= value;
  endtask:drive_task
endclass:Driver

// module 
module des(
  input logic clk,
  input logic rstn,
  input logic req,
  output logic gnt
);
always @(posedge clk)
  if(!rstn)
    gnt <= 0;
  else 
    gnt <= req;

endmodule: des

// testbench module
module tb;
  logic clk;
  always #10 clk = ~clk;
  req_gnt_if vif(.clk(clk));
  des dut(.req(vif.req), .rstn(vif.rstn), .clk(clk) .gnt(gnt));
  Driver drv;
  initial begin 
    vif.rstn <= 0;
    repeat(3) @(posedge clk);
    vif.rstn <= 1;
    // Pass the physical interface instance into the class into its constructor
    drv = new(vif);
    repeat(5) @(posedge clk);
    $finish;
  end
endmodule


// Class Monitor
class Monitor;
virtual req_gnt_if.TB vif;

function new;
    this.vif <= vif;
endfunction

task sample_gnt(output bit gnt_value);
    @(vif.cb);
    gnt_value = vif.cb.gnt;
endtask
endclass

module tb2;
    Monitor mon;
    bit g;
    req_gnt_if vif;
    initial begin 
        mon = new(vif);
        mon.sample_gnt(g);
        $display("gnt: %b", gnt);
    end
endmodule
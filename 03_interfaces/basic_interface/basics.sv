// // // a way of bundling the same signals together in a single block to be reusable in other components
// // // A Basic Interface is the APB interface 
// // interface apb_if(input pclk);
// // logic[31:0] paddr;
// // logic[31:0] pwdata;
// // logic[31:0] prdata;
// // logic penable;
// // logic pwrite;
// // logic psel;
// // endinterface

// // simple interface 

// interface myBus(input clk);
//     // signals
//     logic[7:0] data;
//     logic enable;
// // modport from testbench perspective
// modport TB( input data,clk, output enable);

// // modport from the DUT, data is output
// modport DUT(output data, input enable, clk);
// endinterface

// //connecting the interface to the DUT
// module dut(myBus busIf);
// always @(posedge busIf.clk)
//     if(busIf.enable)
//         busIf.data <= busIf.data + 1;
//     else
//         busIf.data <= 0;
// endmodule

// // Top testbench module
// module tb_top;
// bit clk;
// // create a clk
// always #10 clk = ~clk;

// // create an interface object
// myBus my_if(clk);

// // instantiate DUT and pass modport dut to it
// dut dut0(my_if.DUT);

// initial begin 
//     my_if.enable<=0;
//     #10 my_if.enable <= 1;
//     #40 my_if.enable <= 0;
//     #20 my_if.enable <= 1;
//     #100 $finish;
// end

// endmodule
// // How it is synthesized

// // // a way of bundling the same signals together in a single block to be reusable in other components
// // // A Basic Interface is the APB interface 
// // interface apb_if(input pclk);
// // logic[31:0] paddr;
// // logic[31:0] pwdata;
// // logic[31:0] prdata;
// // logic penable;
// // logic pwrite;
// // logic psel;
// // endinterface

// // simple interface 

// interface myBus(input clk);
//     // signals
//     logic[7:0] data;
//     logic enable;
// // modport from testbench perspective
// modport TB( input data,clk, output enable);

// // modport from the DUT, data is output
// modport DUT(output data, input enable, clk);
// endinterface

// //connecting the interface to the DUT
// module dut(myBus busIf);
// always @(posedge busIf.clk)
//     if(busIf.enable)
//         busIf.data <= busIf.data + 1;
//     else
//         busIf.data <= 0;
// endmodule

// // Top testbench module
// module tb_top;
// bit clk;
// // create a clk
// always #10 clk = ~clk;

// // create an interface object
// myBus my_if(clk);

// // instantiate DUT and pass modport dut to it
// dut dut0(my_if.DUT);

// initial begin 
//     my_if.enable<=0;
//     #10 my_if.enable <= 1;
//     #40 my_if.enable <= 0;
//     #20 my_if.enable <= 1;
//     #100 $finish;
// end

// endmodule

// //a producer to a consumer
// interface stream_if;
// logic valid, ready;
// logic[7:0] data;
// //modports
// modport src(output data,valid, input ready);
// modport dst (input data,valid, output ready);
// endinterface 

// // module for the DUT
// module producer(input logic clk,rst_n, stream_if.src);
// always_ff @(posedge clk or negedge rst_n) begin 
//     if(!rst_n) begin s.valid <= 1'b0; s.data <= 8'0; end 
//     else if(!s.valid || s.ready) begin 
//         s.valid <= 1'b1; s.data <= s.data + 1'8d;
//     end
// end
// endmodule

// module consumer(input logic clk, rst_n, stream_if.dst d, output logic[7:0] data);
//     always_ff @(posedge clk || negedge rst) begin 
//         if(!rst_n) last <= 0'8d;
//         else if (d.valid) last <= d.data;
//     end
// endmodule


// // Tasks, Functions, Assertions, and Coverages inside an Interface
// interface cnt_if #(parameter WIDTH = 4)(input logic clk);
// // signals in the interface
//     logic rstn,
//     logic load_en,
//     logic[WIDTH-1:0] data,
//     logic[WIDTH-1:0] count.
//     logic down,
//     logic rollover
//     // task: it called by other modules 
//     task automatic reset (input int cycles = 3);
//         rst_n <= 0;
//         repeat(cycles) @(posedge clk);
//         rstn <= 1;
//     endtask
//     property p_reset_holds_count;
//     @(posedge clk) !rst_n |-> count == 0;
//     endproperty
//     // a minimal coverpoint
//     covergroup cg_load_en(@ posedge clk);
//     cp_enable: coverpoint load_en;
//     endgroup
//     cg_load_en cg_inst = new();
// endinterface


// // Using the Generic Interface 
// // module myDesign(interface a, input logic clk);
// //     always @(posedge clk)
// //             ....
// // endmodule
// //clocking: a way preventing race conditions
// clocking c_clock a(posedge clk);

// endclocking


module des(input logic clk, req, output logic gnt);
    always @(posedge clk)
    gnt <= req;
endmodule
//2. Interface with a clocking block
interface req_gnt_if(input logic clk);
// declaring the signals
logic req;
logic gnt;
// clocking 
clocking cb @(posedge clk);
    default input #1step output #1ns;
    // signal directions
    input gnt;
    output req;
endclocking
endinterface

//3. Testbench
module tb;
logic clk;
// generate clk
initial clk=0;
always #5 clk = ~clk;
// instantiate the interface and the design
req_gnt_if vif(.clk(clk));
des dut(.clk(clk), .gnt(vif.gnt), .req(vif.req));

initial begin 
    //Drive req through the clocking block
    vif.req <= 0;
    @(vif.cb); // wait for one clk edge 
    vif.req <= 1; // assert request
    @(vif.clk); 

end
endmodule
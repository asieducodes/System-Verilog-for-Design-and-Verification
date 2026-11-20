// // a way of bundling the same signals together in a single block to be reusable in other components
// // A Basic Interface is the APB interface 
// interface apb_if(input pclk);
// logic[31:0] paddr;
// logic[31:0] pwdata;
// logic[31:0] prdata;
// logic penable;
// logic pwrite;
// logic psel;
// endinterface

// simple interface 

interface myBus(input clk);
    // signals
    logic[7:0] data;
    logic enable;
// modport from testbench perspective
modport TB( input data,clk, output enable);

// modport from the DUT, data is output
modport DUT(output data, input enable, clk);
endinterface

//connecting the interface to the DUT
module dut(myBus busIf);
always @(posedge busIf.clk)
    if(busIf.enable)
        busIf.data <= busIf.data + 1;
    else
        busIf.data <= 0;
endmodule

// Top testbench module
module tb_top;
bit clk;
// create a clk
always #10 clk = ~clk;

// create an interface object
myBus my_if(clk);

// instantiate DUT and pass modport dut to it
dut dut0(my_if.DUT);

initial begin 
    my_if.enable<=0;
    #10 my_if.enable <= 1;
    #40 my_if.enable <= 0;
    #20 my_if.enable <= 1;
    #100 $finish;
end

endmodule
// How it is synthesized
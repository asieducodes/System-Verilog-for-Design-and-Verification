module tb;
  logic clk;
  logic [7:0] a;

  always #10 clk = ~clk;

  initial begin 
    a = 0; clk=0;
  end

  // Updates a - the actual write is deferred to NBA
  always @ (posedge clk) begin
    a <= 5;
  end
    // FIX 2: Explicitly terminate the simulation after 100 time units
  initial begin
    #40;
    $finish;
  end
  // Reads immediately, in Active
  always @ (posedge clk) begin
    $display ("[%0t] immediate read (Active):    a=%0d", $time, a);
  end

  // Reads after a #0 delay, in Inactive - still before NBA!
  always @ (posedge clk) begin
    #0;
    $display ("[%0t] #0-delayed read (Inactive): a=%0d", $time, a);
  end

  // Reads via $strobe, deferred to Postponed - after NBA has settled
  always @ (posedge clk) begin
    $strobe ("[%0t] strobe read (Postponed):    a=%0d", $time, a);
  end
endmodule

// Example: 1

module tb1;
logic[7:0] a;
logic clk;


// Generating clk
always #10 clk = ~clk;

initial begin 
    a = 10;
    clk = 0;
end
initial begin 
    #30;
    $finish;
end
always @(posedge clk) begin 
    a <= a + 1;
end
// Printing out the value
always @(posedge clk) begin 
    $display("At time [%0t] (In the active region) the value is: %0d", $time, a);
end
// using the #0 delay
always @(posedge clk) begin 
    #0;
    $display("At time [%0t](Inactive before NBA) the value is: %0d", $time, a);
end
// using $strobe
always @(posedge clk) begin 
    $strobe("At time [%0t] (postponed region) the value is: %0d", $time, a);
end
endmodule

// Delta Cycles
module tb2;
  reg a;
  wire b, c, d;

  assign b = a;
  assign c = b;
  assign d = c;

  initial begin
    a = 0;
    #10 a = 1;
    #1 $display ("[%0t] a=%b b=%b c=%b d=%b", $time, a, b, c, d);
  end
endmodule
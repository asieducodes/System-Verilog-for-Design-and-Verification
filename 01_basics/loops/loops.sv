// forever loop
module tb1;
bit clk;
bit[3:0] counter;
initial begin

// forever begin
//     #5 $display("Hello World, im looping");
// end end

// initial begin 
//     #20 $display("Looping Done");
//     $finish;
// end
// initial begin 
//     #5 repeat(3) $display("I will be in Dresden in 2028");
$display("Counter: %0d", counter);
// for(counter = 0; counter<14; counter = counter+2) begin 
//     @(posedge clk);
//     //counter++;
//     $display("Counter: %0d", counter);
// end
//  end
for ( counter = 0; counter < 11; counter++)begin 
    $display("Counter= %0d", counter);
end
 // clk generation 
// always begin 
//     #10 clk = ~clk;
// end
end
endmodule

module priority_encoder(
    input logic[3 : 0] req,
    output logic[$clog2(3)-1:0] grant,
    output logic valid
);
always_comb begin 
    grant = '0;
    valid = 1'b0;
    // Procees from low to high priority so lower ones can overwrite the higher ones
    for(int i=0; i<3;i++) begin 
        if(req[i]) begin 
            grant = i;
            valid = 1'h1;
        end
    end
end

endmodule

// Using the for loop in verification 
module tb;
string array[5] = '{"apple","orange","pear","blueberry","lemon"};
initial begin 
    for(int i=0; i<$size(array); i++)begin 
        $display("array[%0d]: %s", i, array[i]);
    end 
end


endmodule

module ex1(
    input logic[7:0] data,
    output logic[3:0] ones
);
//assign  data = 8'b1100_0101; 
always_comb begin
    ones = '0;
    for(int i=0; i<8;i++)begin 
      ones += data[i];
    end
   $display("Final output: %0b", data);
end



endmodule 

// ex3: on picking a random address 
module pick_multiple_4;
int tries;
int unsigned num;
//bit my_checker;
initial begin
do begin 
    num = $urandom_range(0,63);
    tries++;
end while(num % 4 != 0);
$display("Had %0d after %0d number of tries",num,tries);
end
endmodule
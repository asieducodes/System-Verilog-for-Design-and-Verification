module ty_alias;
typedef shortint unsigned u_shorti;
typedef enum {RED,GREEN,YELLOW} e_light1;
typedef bit[7:0] ubyte;
//examples on the alias: used specifically for the net
wire[7:0] mydata;
wire[7:0] data;
alias mydata = data;
reg[7:0] src_reg;
assign data = 8'hAA;
// Use these new data types to create variables
initial begin 
u_shorti my_data = 32'hface_cafe;
e_light1 traffic_light = GREEN;
ubyte cnt = 8'hff;
//src_reg = 8'hA5;
$display ("light=%s data=0x%0h cnt=%0d", light.name(), data, cnt);
$display("The value of the data is: %0h",data);
end
endmodule
typedef bit[11:0] u_adder;
module tb_exercise;
u_adder my_u_adder;
initial begin
my_u_adder = 16'hABCD;
$display("After truncating the 16-bit wide, the value held is: %b_%b_%b",my_u_adder[11:8],my_u_adder[7:4],my_u_adder[3:0]);
end


endmodule
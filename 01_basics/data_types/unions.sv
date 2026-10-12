//Unions
// comparing struct and union 
typedef struct packed{
   bit[31:0] raw;
   bit[15:0] high;
   bit[15:0] low;
}data_struct;
// same idea but as a union
typedef union packed{
   bit[31:0] raw;
   struct packed{
      bit[15:0] high;
      bit[15:0] low;
   }halves;
}data_t;
module tb;
initial begin
   data_struct d;
   data_t d1;
   d= 32'hDEAD_BEEF;
   d1=32'hDEAD_BEEF;
   d1.halves.low =16'h1234;
   $display("Raw: 0x%0h\tHigh: 0x%0h\tLow: 0x%0h",d.raw,d.high,d.low);
   $display("Raw: 0x%0h\tHigh: 0x%0h\tLow: 0x%0h",d1.raw,d1.halves.high,d1.halves.low);
   //$display("Raw: 0x%0o\tHigh: 0x%0o\tLow: 0x%0o",d1.raw,d1.halves.high,d1.halves.low);
end
endmodule



// Practice exercise 
typedef union packed{
   bit[15:0] word;
   struct packed{
      bit[7:0] msb,lsb;
   }bytes;
}word_t;
module u_exercise;
initial begin 
   word_t word;
   word = 16'hA5C3;
   $display("The entire word is: 0x%0d\tMSB: 0x%0d\tLSB: 0x%0d",word,word.bytes.msb,word.bytes.lsb);
end
endmodule
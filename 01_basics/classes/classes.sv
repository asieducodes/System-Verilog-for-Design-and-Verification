class myPacket;
bit[2:0] header;
bit encode;
bit[2:0] mode;
bit stop;
// Constructor (new)
function new(bit[2:0] header = 3'h1, bit[2:0] mode=5); begin
    this.header = header;
    this.encode = 0;
    this.mode = mode;
    this.stop = 1;
 end endfunction

function void display(); begin
    $display("Header: 0x%0h, Encode= 0x%0b, Mode= 0x%0h, Stop= 0x%0b",this.header,this.encode,this.mode,this.stop);
 end endfunction

endclass
// Practice Exericse:
class myConfig; 
    bit[7:0] addr_width;
    bit[7:0] data_width;
    function new(bit[7:0] addr_width = 8'd8, bit[7:0] data_width = 8'd32); begin 
        this.addr_width = addr_width;
        this.data_width = data_width;
    end endfunction
    function void display(); begin
        $display("Address Width: 0x%0d, Data Width: 0x%0d",this.addr_width, this.data_width);
     end endfunction
endclass
module classes;
myPacket mypkt;
// An aray of classes for the objects
myPacket pkt[3];
myConfig config1, config2;
initial begin 
    config1 = new();
    config2 = new(8'h16,8'h64);
    mypkt = new(3'h4,3'h2);
    mypkt.display();
    for(int i=0; i<$size(pkt); i++) begin 
        pkt[i] = new();
        pkt[i].display();
    end
    config1.display();
    config2.display();
end

endmodule
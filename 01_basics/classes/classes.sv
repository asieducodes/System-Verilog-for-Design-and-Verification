// class myPacket;
// bit[2:0] header;
// bit encode;
// bit[2:0] mode;
// bit stop;
// // Constructor (new)
// function new(bit[2:0] header = 3'h1, bit[2:0] mode=5); begin
//     this.header = header;
//     this.encode = 0;
//     this.mode = mode;
//     this.stop = 1;
//  end endfunction

// function void display(); begin
//     $display("Header: 0x%0h, Encode= 0x%0b, Mode= 0x%0h, Stop= 0x%0b",this.header,this.encode,this.mode,this.stop);
//  end endfunction

// endclass
// // Practice Exericse:
// class myConfig; 
//     bit[7:0] addr_width;
//     bit[7:0] data_width;
//     function new(bit[7:0] addr_width = 8'd8, bit[7:0] data_width = 8'd32); begin 
//         this.addr_width = addr_width;
//         this.data_width = data_width;
//     end endfunction
//     function void display(); begin
//         $display("Address Width: 0x%0d, Data Width: 0x%0d",this.addr_width, this.data_width);
//      end endfunction
// endclass

// // Class for fixed size array
// class Information; 
// int count;
// function new(int c= 0) begin 
//     this.count = c;
// end
// endfunction
// endclass
// module classes;
// myPacket mypkt;
// // An aray of classes for the objects
// myPacket pkt[3];
// myConfig config1, config2;
// initial begin 
//     config1 = new();
//     config2 = new(8'h16,8'h64);
//     mypkt = new(3'h4,3'h2);
//     mypkt.display();
//     for(int i=0; i<$size(pkt); i++) begin 
//         pkt[i] = new();
//         pkt[i].display();
//     end
//     config1.display();
//     config2.display();
// end

// endmodule

// Practicing the fixed array of objects in the classes

class Information;
    int count;
    function new(int c=0);
        this.count = c;
    endfunction

endclass

class baseClass;
bit[15:0] data;
function new();
    data = 16'hface;
endfunction

endclass

// Inherited class
class subClass extends baseClass; 
    bit[3:0] id;
    bit[2:0] mode = 3;

    function new(int val=2); 
        super.new();
        id = val;
    endfunction
    function void display(); begin 
        $display("data: 0x%0h, id=%0d, mode=%0d",data,id,mode);
    end
    endfunction
endclass

// Grandchild class
class grandChildClass extends subClass; 
bit[3:0] tag = 7;
function new(bit[3:0] id = 0); begin 
    super.new();
    this.id = id;
end endfunction
    function void display(); begin 
        $display("data: 0x%0h, id=%0d, mode=%0d, tag = %0d",data,id,mode,tag);
    end
    endfunction
endclass
module testFixedArr;
Information inf[5];
subClass sc1, sc2;
grandChildClass gdc1;

initial begin
    // Initializing the fixed array of objects 
    for(int i =0; i<5;i++)begin 
        inf[i] = new(i * 10);
    end
    // printing them to the screen 
    for(int i =0; i<$size(inf);i++)begin 
       $display("Instance[%0d]: %0d",i+1,inf[i]);
    end
    sc1 = new();
    sc2 = new(4);
    sc1.display();
    sc2.display();
    // Testing the grandchild class
    gdc1 = new(5);
    gdc1.display();
end

endmodule


// Inheritance
class Packet;
    int addr;
    function new (int addr); begin 
        this.addr = addr;
    end endfunction
    function display(); begin 
        $display("[Base] addr = 0x%0h", this.addr);
    end endfunction
endclass
// Extend and override the display function of the base class
class ExtPacket extends Packet;
    int data;
    function new(int addr, data); begin 
        super.new(addr);
        this.data = data;
    end endfunction
    // overriding the display function for the subclass
    function  display(); begin 
        $display("[Derived], addr = 0x%0h, data = 0x%0h", addr, data);
    end endfunction
endclass

module inheritClass;
Packet bc;
ExtPacket sc;
initial begin 
bc = new(32'hface_cafe);
sc = new(32'h1234_5678, 32'hface_deaf);
bc.display();
sc.display();
end


endmodule
// Structures
typedef struct {
string fruit;
int count;
byte expiry;
}ts_fruits;
// array of structs
typedef struct{
   int data;
   string name;
}MyStruct;

typedef struct packed{
   bit[2:0] opcode;
   bit[4:0] operand;
}instrut_t;
module tb;

// struct {
//    string fruit;
//    int count;
//    byte expiry;
// }st_fruit;
// using typedef to get more instances 
MyStruct fixed_array[5];
// Dynamic
MyStruct dynamic_array[];
// Associative
MyStruct associative_array[int];

instrut_t myinstruct = 8'hA6;
initial begin
// initialize 
//st_fruit = {"apple", 4, 15};
//$display("st_fruit: %p",st_fruit);
// making changes 
//st_fruit.fruit = "pineapple";
//st_fruit.count = 20;
//$display("st_fruit: %p",st_fruit);
// initiating multiple instances
ts_fruits fruit1= '{"mango",3,22};
ts_fruits fruit2= '{"orange",5,12};
ts_fruits fruit3= '{"pawpaw",13,2};
$display("Fruit1: %p\nFruit2: %p\nFruit3: %p",fruit1,fruit2,fruit3);


$display("Fixed Array Example");
for(int i=0; i< 5; i++) begin 
   fixed_array[i].data = i*10;
   fixed_array[i].name = $sformatf("Fixed_%0d", i);
   $display("fixed_array[%0d]: data=%0d, name=%s", i, fixed_array[i].data, fixed_array[i].name);
end
 $display("
--- Dynamic Array Example ---");
    // Initialize and populate the dynamic array
    dynamic_array = new[3]; // Allocate space for 3 elements

    dynamic_array[0].data = 100;
    dynamic_array[0].name = "Dynamic_A";

    dynamic_array[1].data = 200;
    dynamic_array[1].name = "Dynamic_B";

    dynamic_array[2].data = 300;
    dynamic_array[2].name = "Dynamic_C";

    for (int i = 0; i < dynamic_array.size(); i++) begin
      $display("dynamic_array[%0d]: data=%0d, name=%s", i, dynamic_array[i].data, dynamic_array[i].name);
    end
   $display("
--- Associative Array Example ---");
// Populate the associative array using keys
    associative_array[10] = '{101, "Assoc_X"};
    associative_array[25] = '{202, "Assoc_Y"};
	associative_array[5]  = '{303, "Assoc_Z"}; // Keys don't need to be in order
   // Iterating the associative array
   $display("Iterating the associative array");
   foreach(associative_array[key]) begin 
      $display("associative_array[%0d]: data=%0d name=%s",key,associative_array[key].data,associative_array[key].name);
   end
$display("Packed Structure: %p, opcode: %b, operand %b",myinstruct, myinstruct.opcode,myinstruct.operand);
end


endmodule 
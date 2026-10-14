// Array ordering with classes
class Register;
    string name;
    rand bit[3:0] rank;
    rand bit[3:0] pages;
    function new(string name);
        this.name = name;
    endfunction
    function void print();
    $display("name=%s\trank=%0d\tpages=%0d",name,rank,pages);
     endfunction
endclass
//Arrays: 
//1. Packed Arrays
module tb;
bit[7:0] data;
bit[3:0][7:0] my_data;
bit[1:0][7:0] channel_data;
initial begin
    data = 8'hAE;
    for(int i=0; i<$size(data);i++)begin
        $display("Data[%0d] is: %b",i,data[i]);
end
$display("The size of the array: %0d",$size(data));
// 2D Array example
my_data = 32'hface_cafe;
for(int i=0; i<$size(my_data);i++)begin
    $display("Value at my_data[%0d] is %0h",i,my_data[i]);
end
channel_data = 16'hface_cafe;
foreach(channel_data[i]) begin 
    $display("channel_data[%0d]: %0b",i,channel_data[i]);
end
end
endmodule

//3D: Array: packed
module array_3d;
bit[2:0][3:0][7:0] my_data;
initial begin 
    my_data = 96'hface_cafe_fade_c0de_bade_face;
    foreach(my_data[i]) begin 
        $display("my_data[%0d]: %0h",i,my_data[i]);
        foreach(my_data[i][j]) begin
            $display("my_data[%0d][%0d] is: %0h",i,j,my_data[i][j]);
        end
    end
end
endmodule


// Array manipulation
module array_m;
  int array[9] = '{4, 7, 2, 5, 7, 1, 6, 3, 1};
  int res[$];

  initial begin
    res = array.find(x) with (x > 3);
    $display ("find(x)         : %p", res);

    res = array.find_index with (item == 4);
    $display ("find_index      : res[%0d] = 4", res[0]);

    res = array.find_first with (item < 5 & item >= 3);
    $display ("find_first      : %p", res);

    res = array.find_first_index(x) with (x > 5);
    $display ("find_first_index: %p", res);

    res = array.find_last with (item <= 7 & item > 3);
    $display ("find_last       : %p", res);

    res = array.find_last_index(x) with (x < 3);
    $display ("find_last_index : %p", res);

    res = array.min();
    $display("min: %p",res);
    res = array.max();
    $display ("max          : %p", res);

    res = array.unique();
    $display ("unique       : %p", res);

    res = array.unique(x) with (x < 3);
    $display ("unique       : %p", res);

    res = array.unique_index;
    $display ("unique_index : %p", res);
  end
endmodule


// Array Ordering
module array_ord;
int array[9] = '{4,7,2,5,7,1,6,3,1};
Register rt[4];
string name_arr[4] = '{"alexa","siri","chrome","gemini"};

initial begin
array.reverse();
$display("array.reverse: %p",array);
array.sort();
$display("array.sort: %p",array);
array.rsort();
$display("array.rsort: %p",array);
for(int i=0;i<5;i++)begin 
    array.shuffle();
    $display("Shuffled array: %p",array);
end
// Array ordering with classes
foreach(rt[i]) begin
    rt[i] = new(name_arr[i]);
    rt[i].randomize();
    rt[i].print();
end
// Sorting by name
$display("sort by name:");
rt.sort(x) with (x.name);
foreach(rt[i]) rt[i].print();
// Sorting with rank and pages
$display("Sorting by pages and rank");
rt.sort(x) with({x.pages,x.rank});
foreach(rt[i]) rt[i].print();
// Array Reduction
$display("sum of array elements: %0d",array.sum());
$display("product of array elements: %0d",array.product());
$display("and of array elements: %0d",array.and());
$display("or of array elements: %0d",array.or());
$display("xor of array elements: %0d",array.xor());
end
endmodule

//Exercise: Filter, Sort, and Reduce
module exercise;
int vals[6] = '{12,5,9,5,20,9};
int res[$];
int vals_copy[6];
initial begin
//1. All elements > 8
res = vals.find(x) with (x > 8);
$display("Elements > 8: %p",res);
//2. Sort a copy of the array in descending order
vals_copy = vals;
vals_copy.rsort();
$display("The elements in descending order: %p",vals);
//3. Sum of all the elements in the array
$display("Sum of all the elements: %0d",vals.sum());

end



endmodule
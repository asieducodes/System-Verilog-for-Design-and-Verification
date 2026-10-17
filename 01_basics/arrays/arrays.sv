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

//Unpacked Array
module unpacked_arr;
byte stack[4]; // declare 4 unpacked array
byte stack1 [2][4]; 		// 2 rows, 4 cols
bit[3:0][7:0] stack2[2][4];
initial begin
    foreach(stack[i]) begin
        stack[i]=$random();
        $display("The value is: %d at index %d",stack[i], i);
    end
    $display("The stack is: %p", stack);
		// Assign random values to each slot of the stack
    foreach (stack1[i]) begin
        foreach (stack1[i][j]) begin
        stack1[i][j] = $random;
        $display ("stack[%0d][%0d] = 0x%0h", i, j, stack1[i][j]);
        end
    end

    // Print contents of the stack
    $display ("stack = %p", stack1);
    // Iterating the packed + unpacked array
    foreach(stack2[i])
    foreach(stack2[i][j]) begin 
        stack2[i][j] = $random;
        $display("The value is: %0d, index: [%0d][%0d]",stack2[i][j],i,j);
    end
	end
endmodule


module exercise_1;

bit[1:0][7:0] regfile[4]; // 4 entry with 16bit wide
initial begin
$display("Exericese");

foreach(regfile[i]) begin
    regfile[i]= $random;
    $display("Value: %0p",regfile[i]);
end
$display("The array is: %p",regfile);
$display("The first byte of regfile[2] is: %b",regfile[2][1]);
end
endmodule

// Notes on Queues
// Queues: Follows the FIFO operation
// using classes for queues
class MyFruit;
    string name;
function new(string name="Unknown");
    this.name = name;
    endfunction
    endclass
typedef string str_data[];
module queue_tb;
/*
string       name_list [$];        // A queue of string elements
bit [3:0]    data [$];             // A queue of 4-bit elements

logic [7:0]  elements [$:127];     // A bounded queue of 8-bits with maximum size of 128 slots

int  q1 [$] =  '{ 1, 2, 3, 4, 5 }; // Integer queue, initialize elements
int  q2 [$];                       // Integer queue, empty
int  tmp;                          // Temporary variable to store values

tmp = q1 [0];                      // Get first item of q1 (index 0) and store in tmp
tmp = q1 [$];                      // Get last item of q1 (index 4) and store in tmp
q2  = q1;                          // Copy all elements in q1 into q2
q1  = {};                          // Empty the queue (delete all items)

q2[2] = 15;                        // Replace element at index 2 with 15
q2.insert (2, 15);                 // Inserts value 15 to index# 2
q2 = { q2, 22 };                   // Append 22 to q2
q2 = { 99, q2 };                   // Put 99 as the first element of q2
q2 = q2 [1:$];                     // Delete first item
q2 = q2 [0:$-1];                   // Delete last item
q2 = q2 [1:$-1];                   // Delete first and last item
*/
// Create a queue that can store "string" values
string fruits[$]='{"orange","apple","kiwi"};
MyFruit myfruit[$]; // queue for this instance
string order[4] = '{"pawpaw","mangoes","strawberry","banana"};
// A queue of type string data str_data
str_data list[$];
initial begin 
//     foreach(fruits[i]) begin 
//         $display("Fruits[%0d]: %s",i,fruits[i]);
//     end
//     $display("Elements in the fruits queue: %p",fruits);
//     //fruits = {};
//    // $display("Elements in the fruits queue after deleting: %p",fruits);
//     $display("The current size: %0d", fruits.size());
//     // Queue slicing:
//     $display("First two elements: %p", fruits[0:$-1]);
//     fruits[$+1] = "pineapple";
//     $display("Elements in fruits: %p", fruits);
//     //Queue methods
//     fruits.insert(0,"avocado"); // inserting a value at index 0
//     $display("Current elements: %p", fruits);
//     fruits.push_back("guava"); // adding element at the back
//     $display("Current elements: %p", fruits);
//     fruits.push_front("watermelon"); // adding element in front
//     $display("Current elements: %p", fruits);
//     fruits.delete(4);
//     $display("Current elements: %p", fruits);
   // Create instances of the dynamic array with names
    str_data marvel = '{"Spiderman", "Hulk", "Captain American"};
    str_data dcWorld = '{"Superman", "Batman"};
    // Pushing these names onto the queue created for the dynamic array
    list.push_back(marvel);
    list.push_back(dcWorld);
    foreach(list[i]) begin 
        foreach(list[i][j]) begin
            $display("List[%0d][%0d]: %s", i,j,list[i][j]);
        end 
        end
end
endmodule

// creating queue of dynamic arrays

// unbounded queue of int 
int expected_q[$];
int my_values[];
module queue_ex;
// Exercise on Queues
initial begin 
    expected_q.push_back(10);
    expected_q.push_back(20);
    expected_q.push_back(30);
    while (expected_q.size() != 0) begin
        $display("Popped Value: %0d",expected_q.pop_front());
    end 
end
endmodule


// Associative Array: data type sits in the square brackets
// module ass_arr;
// int arr1[int]; // an int arr with int index
// int arr2[string]; // an int arr with string index
// string arr3[string]; // str arr with str index
// int aa_array[int];
// int fruits_lo[string];
// int fruits[string];
// initial begin
//     int idx;
//     arr1 = '{1:22};
//     arr2 = '{"Rose":100,"Joey":200,"John":400};
//     arr3 = '{"Student":"Seth","Teacher":"Prof. Kommey","Friend":"Theodora"};
//     // Associative Arrays 
    
//      // Initialized indices in a mixed order, not 1,2,5,8
//     aa_array[5] = 20;
//     aa_array[8] = 10;
//     aa_array[1] = 50;
//     aa_array[2] = 100;
  
//     // find the next index whose value is > 0
//     aa_array.next(idx); 
//     $display("aa_array[%0d] = %0d",idx,aa_array[idx]);
//     aa_array.next(idx);
//     $display("aa_array[%0d] = %0d",idx, aa_array[idx]);
//     fruits_lo='{"mangoes":20,"apples":40,"bananas":100,"guava":200};
//     if(fruits_lo.exists("mangoes")) 
//     $display("Mangoes are available to be purchased from");
//     $display("Number of fruits: %0d",fruits_lo.num());
//     begin 
//         string f;
//         if(fruits_lo.first(f))
//         $display("fruits_lo[%s]: %0d",f,fruits_lo[f]);
//     end
//     // last() : Get the last element in the array
//     begin
//     string f;
//     if (fruits_l0.last (f))
//         $display ("fruits_l0.last [%s] = %0d", f, fruits_l0[f]);
//     end

//     // prev() : Get the previous element in the array
//     begin
//     string f = "orange";
//     if (fruits_l0.prev (f))
//         $display ("fruits_l0.prev [%s] = %0d", f, fruits_l0[f]);
//     end

//     // next() : Get the next item in the array
//     begin
//     string f = "orange";
//     if (fruits_l0.next (f))
//         $display ("fruits_l0.next [%s] = %0d", f, fruits_l0[f]);
//     end
//       // Create a dynamic array with size 2
//     fruits = new [2];

//     // Initialize the associative array inside each dynamic array index
//     fruits [0] = '{ "apple" : 1, "grape" : 2 };
//     fruits [1] = '{ "melon" : 3, "cherry" : 4 };

//     // Iterate through each index of dynamic array
//     foreach (fruits[i])
//       // Iterate through each key of the current index in dynamic array
//       foreach (fruits[i][fruit])
//         $display ("fruits[%0d][%s] = %0d", i, fruit, fruits[i][fruit]);

// end


// endmodule

// module exercise
module exercise_2;
int reg_arr[string];

initial begin
    // initialize the array
    reg_arr = '{"CTRL":'h10,"STATUS":'h14,"DATA":'h18};
    if(reg_arr.exists("CTRL"))
    $display("CTRL found at position: %0h",reg_arr["CTRL"]);
    begin
        string name;
        if(reg_arr.first(name))
        $display("The first value is: %0h",reg_arr[name]);
        while(reg_arr.next(name))
        $display("The first value is: %0h",reg_arr[name]);
    end
end
endmodule
 // processes must be running concurrently in the background
 //1. fork...join()

 module fork_join;
  
    initial begin 
        $display("[%0t] Main Thread: Fork Joing Going", $time);
        fork
        // Thread 1
        #30 $display("[%0t] Thread1 Finished", $time);
        // Thread 2
        #5 $display("[%0t] Thread2 ......", $time);
        #10 $display("[%0t] Thread2 Finished", $time);
        //Thread 3
        #20 $display("[%0t] Thread3 Finished", $time);
        join
        $display("[%0t] Main Thread Finshed",$time);

        
    end

 endmodule

 module fork_join_any;
    initial begin 
        $display("[%0t] Main Thread Started", $time);
        fork
        
            #10 $display("[%0t] Thread1 started.....", $time);
            #20 $display("[%0t] Thread1 Finished",$time);
          
             begin 
                 #15 $display("[%0t] Thread2 started.....", $time);
            #20 $display("[%0t] Thread2 Finished",$time);
            end
        join_any $display("[%0t] Main Finished without waiting for all", $time);

    end




 endmodule


 // Nested
 module tb1;
 initial begin 
    print(10,"Thread 1");
    fork
        fork
            print(5, "Sub Thread 1");
            print(6, "Sub Thread 2");
        join print(8,"Finished Nested Fork");

    join print(12,"Last Thread");
 end
 task automatic print(int _time, string _name);
    #(_time) $display("[%0t] %s", _time, _name);
 endtask
 endmodule

 module tb2;
    initial begin
        $display("Main Thread: Fork join going to start"); 
        fork
           #5 $display("[%0t] Thread2", $time);
           fork
                //#50 $display("[%0t] Thread0")
                #10 $display("[%0t] Thread1_2", $time);
                #50 $display("[%0t] Thread1_0...", $time);
                #70 $display("[%0t] Thread1_1...", $time);
                #110 $display("[%0t] Thread1_2 finished",$time);
                begin
                #10 $display("[%0t] Thread1_2", $time);
                #15 $display("[%0t] Thread2 finished", $time);
                end
           join
            #20 $display("[%0t] Thread3 finished",$time);

            
        join
     $display("[%0t] Main Thread: Fork join completed", $time);

    end

 endmodule
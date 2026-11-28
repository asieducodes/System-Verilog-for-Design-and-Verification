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

 //2. fork join_any()
 module fj_any;
    initial begin 
        $display("------------------------------\nStarting Fork Join Any\n------------------------------");
        fork
            print(10, "Thread1");
            print(20,"Thread2");
        join_any $display("[%0t] Main Thread Finshed", $time);
    end
    task automatic print(int _time, string _name);
        #_time $display("[%0t] %s has finished", $time, _name);
    endtask:print
 endmodule
 //  Nested fork join
 module nested_fj_any;
    initial begin 
        $display("[%0t] Main Thread: Fork join going to start",$time);
        fork
            fork
               print(20, "Thread1_0");
               print(30, "Thread1_1"); 
            join_any
                print(8, "Thread2");
        join_any $display("[%0t] Main Thread: Fork join has ended", $time);
        //$finsish;
    end

task automatic print(int _time, string _name);
        #_time $display("[%0t] %s has finished", $time, _name);
    endtask:print
 endmodule

 // Timeout Pattern
 module tb3;
    bit done;
    initial begin 
        #50 done <= 1;
        fork
            begin:Thread_1 
                wait(done);
                $display("[%0t] Event Occurred", $time);
            end
            begin:thread_2
            #100 $display("[%0t] Timed Out",$time);
            end
        join_any 
       
    end
 endmodule

 // Fork..join_none
module tb3;
	initial begin
      $display ("[%0t] Main Thread: Fork join going to start", $time);
		fork
          print (20, "Thread1_0");
          print (30, "Thread1_1");
          print (10, "Thread2");
		join_none
      $display ("[%0t] Main Thread: Fork join has finished", $time);
	end

  // Note that we need automatic task
  task automatic print (int _time, string t_name);
    #(_time) $display ("[%0t] %s", $time, t_name);
  endtask
endmodule

//forking inside a loop
module tb4;
initial begin
    for(int i=0; i<6; i++)begin 
        //fixing this with the automatic keyword
        automatic int j = i;
        fork
        #10 $display("[%0t] j=%0d",$time,j);
        join_none
    end
    #20 $finish;
end

endmodule
// Disabling Fork
module tb5;
initial begin
   #10 $display("[%0t] Starting the Fork Join Processes",$time);
   fork
    begin 
        #15 $display("[%0t] Thread1 finished", $time);
    end
    begin 
        #25 $display("[%0t] Thread2 finished", $time);
    end
   join_any 
    $display("[%0t] Main Thread is done", $time);
    disable fork;

end

endmodule

// wait fork: allows to wait for all unfinished threads to complete before the ending of the main of the main threads in the processes
module tb_top;

	initial begin
		// Fork off 3 sub-threads in parallel and the currently executing main thread
		// will finish when any of the 3 sub-threads have finished.
		fork

			// Thread1 : Will finish first at time 40ns
			#40 $display ("[%0t ns] Show #40 $display statement", $time);

			// Thread2 : Will finish at time 70ns
			begin
				#20 $display ("[%0t ns] Show #20 $display statement", $time);

				#50 $display ("[%0t ns] Show #50 $display statement", $time);
			end

			// Thread3 : Will finish at time 60ns
			#60 $display ("[%0t ns] TIMEOUT", $time);
		join_any

      	// Display as soon as the fork is done
      	$display ("[%0t ns] Fork join is done, wait fork to end", $time);

      	// Fork two more processes
      	fork
          #10 $display ("[%0t ns] Wait for 10", $time);
          #20 $display ("[%0t ns] Wait for 20", $time);
        join_any

      	// Wait until ALL forked processes are over
      	wait fork;
        $display ("[%0t ns] Fork join is over", $time);
   end
endmodule

// Process States
/*
class process;
  typedef enum { FINISHED, RUNNING, WAITING, SUSPENDED, KILLED } state;

  static function process self();      // handle to the calling process
  function state status();             // current state of this process
  function void suspend();             // pause this process
  function void resume();              // resume a suspended process
  function void kill();                // terminate this process and its descendants
  task await();                        // wait for this process to finish
  function void srandom (int seed);            // reseed this process's own random generator
  function string get_randstate();             // save this process's random state
  function void set_randstate (string state);  // restore a previously saved random state
endclass
*/
// module tb6;
//     process bg_proc;
//     task background_task();
//         bg_proc = process::self();
//         forever begin 
//             #10 $display("Background task running ", $time);
//         end
//     endtask
//     initial begin
//         fork
//             background_task();
//         join_none
//         #25 $display("[%0t] Status before killed %s",$time,bg_proc.status().name() );
//         // killing the process
//         bg_proc.kill();
//         $display("[%0t] Background process being killed", $time);
//         #20 $finish;
//     end
// endmodule
module tb6;
    //1. process instance
    process bg_proc;
    task background_proc();
        bg_proc = process::self(); // makes a copy for it 
        forever begin 
            #10 $display("[%0t] Background Process Running", $time);
        end
    endtask
   initial begin 
     fork
        background_proc();
    join_none
    #25 $display("[%0t] Status of BG Process before being suspended", $time);
        bg_proc.suspend();
        $display("[%0t] Current State of bg_proc %s", $time, bg_proc.status().name());
        #25 $display("[%0t] Status of BG Process after being suspended", $time);
        bg_proc.resume();
        $display("[%0t] Current State of bg_proc %s", $time, bg_proc.status().name());
     #25 $display("[%0t] Status of BG Process before being killed", $time);
        bg_proc.kill();
        $display("[%0t] Current State of bg_proc %s", $time, bg_proc.status().name());
    $display("Finished"); $finish;
   end

endmodule

module exe1;
process bg_proc1, bg_proc2;

task bg_process1();
    bg_proc1 = process::self();
     forever begin 
        #5 $display("[%0t] bg_proc 1 is running...",$time);
    end
endtask
task bg_process2();
    bg_proc2 = process::self();
    forever begin 
        #5 $display("[%0t] bg_proc 2 is running...",$time);
    end
endtask
    initial begin 
        fork 
            bg_process1();
            bg_process2();
        join_none
        #22 $display("[%0t]State of Process 1 before killing %s", $time, bg_proc1.status().name());
        bg_proc1.kill();
    
     #20 $display("[%0t] Terminating the process",$time); $finish;

    end
   
endmodule

module tb7;
  initial begin
    fork
      begin : timeout_blk
        #100 $display ("[%0t] Timeout reached", $time);
      end

      begin : monitor_blk
        forever #10 $display ("[%0t] Monitoring...", $time);
      end

      begin
        #30 $display ("[%0t] Event occurred", $time);
        disable timeout_blk;   // cancel only the timeout, leave monitor_blk running
      end
    join_none

    #60 $finish;
  end
endmodule
//disable on a task which is different from disable fork

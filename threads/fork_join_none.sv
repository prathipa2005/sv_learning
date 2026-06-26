//******************************************************************
// File :  Fork_join_none.sv
// Description : Demonstration of the Fork_join_none and nested fork_join
//******************************************************************


module tb;

  initial begin
    $display("Start");

    fork
      begin
        $display("[%0t] Thread 1", $time);

        fork
          #10 $display("[%0t] Thread 2", $time);

          begin
            #10 $display("[%0t] Thread 3", $time);
            #5  $display("[%0t] Thread 2_1", $time);
          end

        join_any

        $display("[%0t] Nested fork is finished", $time);
      end
    join_none

   #2 $display("[%0t] Fork ended", $time);

  end

endmodule
//******************************************************************
// File :  wait_fork.sv
// Description : Demonstration of the wait_fork for outer and inner block
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
        join_none

        wait fork;

        #2 $display("[%0t] Nested fork is finished", $time);
      end

      #5 $display("[%0t] This is another outer thread", $time);

    join_any

    $display("[%0t] Fork ended", $time);

    wait fork;

    $display("[%0t] All forked processes completed", $time);

  end

endmodule
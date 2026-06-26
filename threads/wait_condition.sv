//******************************************************************
// File :  wait(condition).sv
// Description : Demonstration of the wait(condition) 
//******************************************************************

module tb;

  bit data_ready = 0;
  bit ack = 0;

  initial begin
    $display("[%0t] Simulation Started", $time);

    fork

      // Producer Thread
      begin
        #10;
        data_ready = 1;
        $display("[%0t] Producer : Data is Ready", $time);

        #5;
        ack = 1;
        $display("[%0t] Producer : Acknowledgement Sent", $time);
      end

      // Consumer Thread
      begin
        $display("[%0t] Consumer : Waiting for Data...", $time);

        wait(data_ready);

        $display("[%0t] Consumer : Data Received", $time);

        $display("[%0t] Consumer : Waiting for ACK...", $time);

        wait(ack);

        $display("[%0t] Consumer : ACK Received", $time);
      end

    join

    $display("[%0t] Simulation Completed", $time);

  end

endmodule
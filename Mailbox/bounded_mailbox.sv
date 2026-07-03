//*********************************************************************************
// File        : Mailbox_bounded.sv
// Description : Demonstrates blocking put() operation in a bounded mailbox.
//*********************************************************************************

module tb;

  mailbox #(int) mbx = new(2);

  initial begin
    fork
      producer();
      consumer();
    join
  end

  task producer();
    for(int i=1; i<=3; i++) begin
      $display("[%0t] Producer trying to put %0d", $time, i);
      mbx.put(i);
      $display("[%0t] Producer put %0d", $time, i);
    end
  endtask

  task consumer();
    int data;

    #10;

    repeat(3) begin
      mbx.get(data);
      $display("[%0t] Consumer got %0d", $time, data);
      #10;
    end
  endtask

endmodule
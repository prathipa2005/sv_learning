//*********************************************************************************
// File        : Mailbox_try_put_try_get.sv
// Description : Demonstrates non-blocking mailbox methods try_put() and try_get().
//*********************************************************************************

module tb;

  mailbox #(int) mbx = new(2);

  int data;

  initial begin

    if(mbx.try_get(data))
      $display("Received %0d", data);
    else
      $display("Mailbox Empty");

    mbx.try_put(10);
    mbx.try_put(20);

    if(mbx.try_put(30))
      $display("30 inserted");
    else
      $display("Mailbox Full");

    repeat(3) begin

      if(mbx.try_get(data))
        $display("Received %0d", data);
      else
        $display("Mailbox Empty");

    end

  end

endmodule
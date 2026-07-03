//*********************************************************************************
// File        : Mailbox_peek.sv
// Description : Demonstrates mailbox peek() operation.
//*********************************************************************************

module tb;

  mailbox #(int) mbx = new();

  int data;

  initial begin

    mbx.put(10);
    mbx.put(20);

    mbx.peek(data);

    $display("Peek = %0d", data);

    $display("Items in mailbox = %0d", mbx.num());

    mbx.get(data);

    $display("Get = %0d", data);

    $display("Items in mailbox = %0d", mbx.num());

  end

endmodule
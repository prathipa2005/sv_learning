//*********************************************************************************
// File        : Mailbox_handle_experiment.sv
// Description : Experimental verification showing that mailboxes transfer object
//               handles, not copies.
//*********************************************************************************

class trans;

  int data;

endclass


module tb;

  mailbox #(trans) mbx = new();

  trans tr;
  trans tr_d;

  initial begin

    tr = new();

    tr.data = 5;

    $display("[%0t] Original Data = %0d", $time, tr.data);

    mbx.put(tr);

    // Modify after putting into mailbox
    tr.data = 10;

    mbx.get(tr_d);

    $display("[%0t] Driver Received = %0d", $time, tr_d.data);

  end

endmodule
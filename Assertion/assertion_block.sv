//******************************************************************
// File :  Assertion block.sv
// Description : Demonstration of the assertion 
                 with sequence and property 
//******************************************************************


module tb;

  bit clk = 0;
  bit req, grant, ack;

  always #5 clk = ~clk;

  sequence transfer_seq;
    req ##1 grant ##1 ack;
  endsequence

  property transfer_p;
    @(posedge clk)
    transfer_seq;
  endproperty

  assert property(transfer_p);

  initial begin

    req = 0;
    grant = 0;
    ack = 0;

    @(posedge clk);
    req = 1;

    @(posedge clk);
    grant = 1;

    @(posedge clk);
    ack = 1;

    @(posedge clk);

    $finish;
  end

endmodulemodule tb;

  bit clk = 0;
  bit req, grant, ack;

  always #5 clk = ~clk;

  sequence transfer_seq;
    req ##1 grant ##1 ack;
  endsequence

  property transfer_p;
    @(posedge clk)
    transfer_seq;
  endproperty

  assert property(transfer_p);

  initial begin

    req = 0;
    grant = 0;
    ack = 0;

    @(posedge clk);
    req = 1;

    @(posedge clk);
    grant = 1;

    @(posedge clk);
    ack = 1;

    @(posedge clk);

    $finish;
  end

endmodule
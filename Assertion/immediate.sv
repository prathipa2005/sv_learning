//******************************************************************
// File :  Immediate Assertion.sv
// Description : Demonstration of the Immediate assertion example
//******************************************************************


module tb;

  int a = 10;
  int b = 10;

  initial begin

    assert(a == b)
      $display("PASS");
    else
      $display("FAIL");

  end

endmodule
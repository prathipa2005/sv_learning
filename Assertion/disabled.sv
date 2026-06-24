
//******************************************************************
// File :  Disabled iff in Assertion.sv
// Description : Demonstration of the Disabled iff function example
//******************************************************************


module tb;
    bit req,grant,reset;
    bit clk = 0;

    always #5 clk = ~clk;
    
    initial begin
        req = 0;
        grant = 0;
      	reset = 1;

        @(posedge clk)
        req = 1;
      	reset = 0;

        @(posedge clk)
        grant = 1;
		reset = 1;
      
        @(posedge clk)
        @(posedge clk)
        $finish;

    end
  always @(posedge clk)
  $display("time=%0t req=%0b grant=%0b reset=%0b",
           $time,req,grant,reset);

    property transfer;
        @(posedge clk)
      disable iff(reset)
        $rose(req) |=> grant;  //$rose check the rising edge of the req 
        //that is the transition from 0 to 1
    endproperty

    assert property(transfer)
      $display("Pass at %0t",$time);
    else
      $display("Fail at %0t",$time);

endmodule
//******************************************************************
// File :  $fell in Assertion.sv
// Description : Demonstration of the $fell function example
//******************************************************************


module tb;
    bit req,grant;
    bit clk = 0;

    always #5 clk = ~clk;
    
    initial begin
        req = 1;
        grant = 0;

        @(posedge clk);
        req = 0;

        @(posedge clk);
        grant = 0;      //assertion fail

        @(posedge clk);
        @(posedge clk);
        $finish;

    end

    property transfer;
        @(posedge clk)
        $fell(req) |=> grant;  //$fell check the falling edge of the req 
        //that is the transition from 1 to 0
    endproperty

    assert property(transfer)
        $display("Pass at %0t",$time);
    else
      $display("Fail at %0t",$time);

endmodule

//******************************************************************
// File :  $past in Assertion.sv
// Description : Demonstration of the $past function example
//******************************************************************


module tb;
    bit start,data;
    bit clk = 0;

    always #5 clk = ~clk;
    
    initial begin
        start = 0;
        data = 0;

        @(posedge clk)
        start = 1;
        data = 1;

        @(posedge clk)
        @(posedge clk)
      
        @(posedge clk)
        $finish;

    end

    property transfer;
        @(posedge clk)
        start |-> $past(data);  
    endproperty

    assert property(transfer)
        $display("Pass at %0t",$time);
    else
      $display("Fail at %0t",$time);

endmodule
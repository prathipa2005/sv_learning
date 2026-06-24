//******************************************************************
// File :  $stable in Assertion.sv
// Description : Demonstration of the $stable function example
//******************************************************************


module tb;
    bit valid,data;
    bit clk = 0;

    always #5 clk = ~clk;
    
    initial begin
        valid = 0;
        data = 0;

        @(posedge clk)
        valid = 1;
        data = 1;

        @(posedge clk)

        @(posedge clk)
        $finish;

    end

    property transfer;
        @(posedge clk)
        valid |-> $stable(data);  //$rose check the rising edge of the req 
        //that is the transition from 0 to 1
    endproperty

    assert property(transfer)
        $display("Pass at %0t",$time);
    else
      $display("Fail at %0t",$time);

endmodule
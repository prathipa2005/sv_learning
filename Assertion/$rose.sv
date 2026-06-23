//******************************************************************
// File :  $rose in Assertion.sv
// Description : Demonstration of the $rose function example
//******************************************************************


module tb;
    bit req,grant;
    bit clk = 0;

    always #5 clk = ~clk;
    
    initial begin
        req = 0;
        grant = 0;

        @(posedge clk)
        req = 1;

        @(posedge clk)
        grant = 1;

        @(posedge clk)
        $finish;

    end

    property transfer;
        @(posedge clk)
        $rose(req) |=> grant;  //$rose check the rising edge of the req 
        //that is the transition from 0 to 1
    endproperty

    assert property(transfer);

endmodule
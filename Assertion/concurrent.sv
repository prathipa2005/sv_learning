//******************************************************************
// File :  Concurrent Assertion.sv
// Description : Demonstration of the Concurrent Assertion example
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
        req |=> grant;
    endproperty

    assert property(transfer);

endmodule
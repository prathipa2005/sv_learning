//******************************************************
// File : Virtual_interface.sv
// Description : Demonstration of the virtual interface 
//***********************************************************************

interface bus(input logic clk);

    logic req;
    logic gnt;

endinterface


module dut(bus inf);

    always @(posedge inf.clk)
        inf.gnt <= inf.req;

endmodule


class driver;

    // Virtual Interface Handle
    virtual bus vif;

    task run();

        vif.req <= 0;
        @(posedge vif.clk);

        vif.req <= 1;
        @(posedge vif.clk);

        vif.req <= 0;

    endtask

endclass


module tb;

    logic clk = 0;

    always #10 clk = ~clk;

    bus inf(clk);

    dut d1(inf);

    driver drv;

    initial begin

        drv = new();

        // Pass the interface handle
        drv.vif = inf;

        // Run driver
        drv.run();

    end

    initial begin

        $monitor("[%0t] req=%0b gnt=%0b",
                  $time, inf.req, inf.gnt);

        #80 $finish;

    end

endmodule
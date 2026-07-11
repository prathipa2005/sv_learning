/*****************************************************************************************
File Name    : program_block_race_condition.sv

Description  :
This example demonstrates the purpose of the SystemVerilog Program Block. It
shows how a program block executes in the Reactive scheduling region, allowing
the Design Under Test (DUT) to complete its execution before the testbench
drives new stimulus. This eliminates race conditions between the DUT and the
testbench that can occur when both execute in the Active region.
*****************************************************************************************/


module dut(
    input logic clk,
    input logic d,
    output logic q
);

always @(posedge clk) begin
    q <= d;
    $display("[%0t] DUT sampled d = %0d", $time, d);
end

endmodule


program test(
    output logic d,
    input logic clk
);

initial begin

    d = 0;
    
    $display("[%0t] Program initial d = %0d", $time, d);

    @(posedge clk);

    d = 1;

    $display("[%0t] Program changed d = %0d", $time, d);

end

endprogram


module tb;

logic clk = 0;
logic d;
logic q;

dut DUT(clk,d,q);
test TEST(d,clk);

always #5 clk = ~clk;

initial
    #20 $finish;

endmodule

Observation:
1. A Program Block is a special SystemVerilog design unit intended only for verification code and testbench stimulus.
2. Unlike modules, program blocks execute in the Reactive scheduling region, after all Active and NBA region activities are completed.
3. Program blocks eliminate race conditions between the DUT and the testbench by ensuring that the DUT completes its execution before new stimulus is driven.
4. The event control (@posedge clk) only suspends the process until the specified event occurs. It does not determine the scheduling region; the scheduling region is determined by the design unit (module or program) in which the process resides.
5. A common misconception is that an always block containing a non-blocking assignment executes in the NBA region. In reality, the process executes in the Active region, while only the update of the non-blocking assignment is deferred to the NBA region.
6. Program blocks prevent races between modules and programs but do not eliminate race conditions between multiple program blocks executing in the same Reactive region.
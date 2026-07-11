/*****************************************************************************************
File Name    : final_block_simulation_summary.sv

Description  :
This example demonstrates the purpose of the SystemVerilog Final Block. It shows
how a final block is guaranteed to execute exactly once before the simulator
terminates, regardless of which component invokes $finish. This mechanism is
commonly used to generate simulation summaries, print verification statistics,
and perform cleanup operations.
*****************************************************************************************/


module generator;

initial begin
    $display("[%0t] Generator Started", $time);

    #20;

    $display("[%0t] Generator Finished", $time);

    $finish;
end

endmodule


module scoreboard;

int pass = 20;
int fail = 1;

final begin

    $display("\n==============================");
    $display("Simulation Summary");
    $display("==============================");
    $display("PASS Transactions : %0d", pass);
    $display("FAIL Transactions : %0d", fail);
    $display("==============================");

end

endmodule


module tb;

generator g();
scoreboard s();

endmodule

Observation:
1. A Final Block executes exactly once after the simulator receives a simulation termination request (such as $finish) and before the simulation completely exits.
2. The purpose of a Final Block is not simply to print messages after $finish, but to guarantee cleanup and reporting regardless of which component ends the simulation.
3. In a verification environment, components such as generators, scoreboards, monitors, and coverage collectors perform independent tasks. A Final Block allows each component to report its own statistics without depending on another component to invoke its reporting function.
4. Without a Final Block, every possible location that calls $finish would also need to invoke report-generation and cleanup functions, leading to duplicated code and poor modular design.
5. Final Blocks are commonly used to print simulation summaries, verification statistics, coverage reports, assertion summaries, close opened files, and release simulation resources.
6. A Final Block cannot contain delays, event controls, or forked processes because simulation time has already ended.
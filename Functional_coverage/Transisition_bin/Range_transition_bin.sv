/*****************************************************************************************
File Name    : range_transition_bin.sv

Description  :
This example demonstrates range-based transition bins.
A transition is considered valid when any value from the specified range
transitions to the target value.
*****************************************************************************************/



module tb;
  bit [3:0]a;
	bit clk = 0;

	covergroup cp @(posedge clk);
		coverpoint a {
          bins repetitive = ([1:3]=> [0:2]);
			}
		endgroup

	always  #5 clk= ~clk;

	cp cp_inst;

	initial begin
      
      cp_inst = new();
		a = 0;

		@(negedge clk);
		a = 0;

		@(negedge clk);
		a = 3;

		@(negedge clk);
		a = 1;

		@(negedge clk);
		a = 0;

		@(negedge clk);
		a = 2;

		@(negedge clk);
		a = 2;

		@(negedge clk);
		a = 1;

		@(negedge clk);
		a = 15;

		@(negedge clk);
		a = 14;

		@(negedge clk);
		a =11;

		@(negedge clk);
		a = 13;

		@(negedge clk);
		a = 2;
$finish;
	end

	always@(posedge clk)
		#0 $display("[%0t] Coverage  = %0.2f%%",$time,cp_inst.get_coverage());
	always@(negedge clk)
		#0 $display("[%0t] a = %0d",$time,a);
	endmodule

Observation:
1. A range transition automatically expands into multiple valid transition combinations.
2. Any value within the specified source range can transition to the destination value.
3. This avoids writing multiple individual transition bins manually.
4. Range transitions improve code readability and simplify functional coverage models.
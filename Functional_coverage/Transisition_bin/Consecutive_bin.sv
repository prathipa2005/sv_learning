/*****************************************************************************************
File Name    : consecutive_repetition_transition_bin.sv

Description  :
This example demonstrates the use of a consecutive repetition transition bin.
The transition bin is covered only when the specified value appears consecutively
for the required number of occurrences.

*****************************************************************************************/



module tb;
  bit [3:0]a;
	bit clk = 0;

	covergroup cp @(posedge clk);
		coverpoint a {
          bins repetitive = (0[*3]);
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
		a = 0;

		@(negedge clk);
		a = 0;

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
1. The transition bin is covered only when three consecutive occurrences of value '0' are sampled.
2. Any interruption in the sequence resets the matching process.
3. Once the transition bin is covered, the coverage percentage remains 100%, even if the same sequence occurs multiple times later.
4. Additional valid occurrences may increase the internal hit count (tool dependent), but they do not increase the coverage percentage beyond 100%.
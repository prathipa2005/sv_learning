/*****************************************************************************************
File Name    : non_consecutive_repetition_transition_bin.sv

Description  :
This example demonstrates the use of a non-consecutive repetition transition bin.
The specified value must occur the required number of times, but consecutive
occurrences are not mandatory.
*****************************************************************************************/



module tb;
  bit [3:0]a;
	bit clk = 0;

	covergroup cp @(posedge clk);
		coverpoint a {
          bins repetitive = (0[=3] => 1);
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
1. The specified value does not need to occur consecutively.
2. Intermediate values are allowed between repeated occurrences.
3. The transition bin is covered once the required number of occurrences is observed.
4. Unlike [*], interruptions between occurrences do not invalidate the sequence.
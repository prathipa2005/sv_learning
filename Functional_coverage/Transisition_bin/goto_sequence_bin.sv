/*****************************************************************************************
File Name    : goto_repetition_transition_bin.sv

Description  :
This example demonstrates the use of a goto repetition transition bin.
The required value must occur the specified number of times before continuing
to the next transition in the sequence.
*****************************************************************************************/

module tb;
  bit [3:0]a;
	bit clk = 0;

	covergroup cp @(posedge clk);
		coverpoint a {
          bins repetitive = (0[->3] => 1);
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
		a = 1;

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
1. When used as a standalone repetition operator, [->] behaves similarly to [=].
2. The actual difference between [->] and [=] becomes visible only when another transition follows the repetition.
3. Goto repetition is mainly intended for complex transition sequences rather than standalone repetition.
4. For simple repetition examples, both operators produce similar coverage behavior.
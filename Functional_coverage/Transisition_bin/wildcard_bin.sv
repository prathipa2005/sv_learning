/*****************************************************************************************
File Name    : wildcard_bins.sv

Description  :
This example demonstrates wildcard bins in functional coverage.
Wildcard bins use '?' as a don't-care bit, allowing multiple values
to be grouped into a single coverage bin.

*****************************************************************************************/



module tb;
  bit [3:0]a;
	bit clk = 0;

	covergroup cp @(posedge clk);
		coverpoint a {
          wildcard bins repetitive = {4'b10??};
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
		a = 8;

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
1. The '?' symbol represents a don't-care bit.
2. A single wildcard bin can cover multiple binary values that match the specified pattern.
3. Wildcard bins reduce the number of manually defined bins for similar value patterns.
4. They are commonly used for opcode, address, control field, and protocol verification.
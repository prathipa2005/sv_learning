//*********************************************************************************
// File        : Covergroup_Bin_Arrays.sv
// Description : Demonstration of automatic bin array creation, fixed-size bin
//               arrays, open-ended ranges, and default bins in a covergroup.
//*********************************************************************************

module  tb;
	bit [3:0]val;
	bit clk = 0;

  covergroup cp @(posedge clk);
		coverpoint val{

			bins range[] = {[0:4]};
			bins range_a[3] = {[5:8],10,11,12};
			bins range_b[] = {[13:$]};
			bins other = default;
			}
		endgroup

		always #5 clk = ~clk;

		cp cp_val;

		initial begin
			cp_val = new();
          
			val = 0;
			@(negedge clk)
			val = 1;

			@(negedge clk)
			val = 9;


			@(negedge clk)
			val = 6;

			@(negedge clk)
			val = 7;

			@(negedge clk)
			val = 12;

			@(negedge clk)
			val = 15;

			@(negedge clk)
			val = 14;

			@(negedge clk)
			val = 9;
			
			#10 $finish;
		end

		always@(posedge clk)
		begin
          #0 $display("[%0t] The coverage percent is %0.2f%",$time,cp_val.get_inst_coverage);
		end

		always@(negedge clk)
		begin
			#0 $display("[%0t] The values is %0d",$time,val);
		end

		endmodule

//*********************************************************************************
// Experimental Observations
// -------------------------
// 1. bins range[] automatically creates one bin for every value in the specified
//    range (0 to 4).
//
// 2. bins range_a[3] automatically distributes the specified values into three
//    bins instead of creating one bin per value.
//
// 3. bins range_b[] creates one bin for every value from 13 up to the maximum
//    possible value of the coverpoint.
//
// 4. The default bin collects values that are not covered by any explicit bin.
//
// 5. Coverage increases only when a previously uncovered bin is hit. Sampling
//    the same value multiple times does not increase the coverage.
//*********************************************************************************************************************************************************************************

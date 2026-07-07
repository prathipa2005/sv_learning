//*********************************************************************************
// File        : Basic_Cross_Coverage.sv
// Description : Demonstration of automatic cross coverage generation between two
//               coverpoints and the calculation of cross coverage.
//*********************************************************************************

module  tb;
	bit [1:0]master;
	bit [1:0]slave;
	bit clk = 0;

covergroup cp @(posedge clk);
	master_cp:	coverpoint master {
			bins master0 = {0};
			bins master1 = {1};
			bins master2 = {2};
			bins master3 = {3};
			}

	slave_cp:	coverpoint slave {
			bins slave0 = {0};
			bins slave1 = {1};
			bins slave2 = {2};
			bins slave3 = {3};
			}
  cross_cp:	cross master_cp,slave_cp;
  
endgroup

	always #5 clk = ~clk;

	cp cp_inst;

	initial  begin
		cp_inst = new();
		master = 0;
		slave = 1;

		@(negedge clk);
		master = 0;
		slave = 0;

		@(negedge clk);
		master = 0;
		slave = 1;
      
		@(negedge clk);
      
      for(int i = 1; i<4; i++)
		begin
			
			master = i;
          for(int j = 0; j<4; j++)
              begin
              
				slave = j;
                @(negedge clk);
              end
			
		end
	 $finish;
	end

	always@(posedge clk)
	begin
      #0 $display("[%0t] Cross Coverage = %0.2f%%",$time,cp_inst.cross_cp.get_coverage());
      $display("[%0t] Master Coverage = %0.2f%%",$time,cp_inst.master_cp.get_coverage());
      $display("[%0t] Slave Coverage = %0.2f%%",$time,cp_inst.slave_cp.get_coverage());
      $display("[%0t] Total Coverage = %0.2f%%",$time,cp_inst.get_coverage());

	end

	always@(negedge clk)
      #0 $display("[%0t] Master = %0d , Slave = %0d",$time,master,slave);
	endmodule

//*********************************************************************************
// File        : Basic_Cross_Coverage.sv
// Description : Demonstration of automatic cross coverage generation between two
//               coverpoints and the calculation of cross coverage.
//*********************************************************************************

//*********************************************************************************
// Experimental Observations
// -------------------------
// 1. Cross coverage automatically creates bins for every possible combination
//    of the participating coverpoint bins.
//
// 2. Total automatic cross bins are calculated as:
//          (Number of Master bins) × (Number of Slave bins)
//
// 3. In this example:
//          Master bins = 4
//          Slave bins  = 4
//          Total Cross Bins = 16
//
// 4. Cross coverage verifies combinations of values rather than individual
//    coverpoint values.
//
// 5. Even if both coverpoints achieve 100% coverage individually, the cross
//    coverage can still be less than 100% if some combinations never occur.
//
// 6. get_coverage() of the covergroup returns the overall covergroup coverage,
//    whereas the cross coverage is calculated independently based on the cross
//    bins.
//*********************************************************************************
//*********************************************************************************
// File        : User_Defined_Cross_Bins.sv
// Description : Demonstration of user-defined cross bins using binsof() and
//               understanding how custom cross bins affect coverage calculation.
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
  cross_cp:	cross master_cp,slave_cp
  
  {bins first = binsof(master_cp.master1)&&binsof(slave_cp);}
  
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
// Experimental Observations
// -------------------------
// 1. User-defined cross bins group multiple automatic cross combinations into a
//    single custom coverage bin.
//
// 2. A custom cross bin replaces the automatic bins that belong to the same
//    combinations instead of creating additional bins.
//
// 3. In this example:
//
//          Automatic Cross Bins = 16
//
//          Custom Bin 'first'
//          = (master == 1) && (slave == 0,1,2,3)
//
//          Four automatic bins are grouped into one custom bin.
//
//          Final Cross Bins
//          = 16 - 4 + 1
//          = 13 bins
//
// 4. Once any combination inside the custom bin is sampled, the entire custom
//    bin is considered covered.
//
// 5. Sampling the remaining combinations belonging to the same custom bin does
//    not increase the coverage percentage.
//
// 6. Cross coverage percentage is always calculated using the final number of
//    cross bins after user-defined bins replace automatic combinations.
//*********************************************************************************
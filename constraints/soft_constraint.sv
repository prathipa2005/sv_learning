//***********************************************************************
// File : Soft and hard constraint.sv
// Description : Demonstration of the Constraint with Soft and also 
                 call constraint_mode as task and function                    
//***********************************************************************

class memory;
	rand int addr;

  constraint addr_c { soft addr >= 32'hfffffff0;}
endclass

module tb;
	memory mem;

	initial begin
		mem = new;

		if(mem.addr_c.constraint_mode())
		begin

			$display("Constraint is enabled");
          $display("The value  of addr before randomization  is %0h", mem.addr);
          mem.randomize() with { addr == 32'hffffff00;};
          $display("The value  of addr is %0h", mem.addr);
		end

		else
			$display("Constraint is disabled");

		mem.addr_c.constraint_mode(0);
		

		if(mem.addr_c.constraint_mode())
		begin
			
			$display("Constraint is enabled");
			
		end

		else
			$display("Constraint is disabled");
      mem.randomize();
      $display("The value  of addr after disabled the constraint is %0h", mem.addr);
	end
	endmodule

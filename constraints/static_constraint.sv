//***********************************************************************
// File : Constraint with Static constraint.sv
// Description : Demonstration of the Static Constraint 
//***********************************************************************


class vegetable;
	
  rand bit [3:0] count;

	constraint count_c { count >= 5;}
  static constraint count_c1 { count < 9;}

endclass

module tb;
	vegetable veg1,veg2;

	initial begin
		veg1 = new;
		veg2 = new;

		veg1.count_c.constraint_mode(0);

		for(int i=0; i<5; i++)
		begin
			veg1.randomize();
			veg2.randomize();

			$display("The count of veg1 and veg2 is %0d, %0d", veg1.count,veg2.count);


		end

		veg1.count_c1.constraint_mode(0);

		for(int i=0; i<5; i++)
		begin
			veg1.randomize();
			veg2.randomize();

			$display("The count of veg1 and veg2 is %0d, %0d", veg1.count,veg2.count);
		end

		 
	end
	endmodule


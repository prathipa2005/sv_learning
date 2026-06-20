//******************************************************************
// File : External Constraint.sv
// Description : Demonstration of the Explicit external constraint
//******************************************************************

class generator;
	rand logic [3:0] addr;
	randc logic [2:0] data;

	constraint addr_c;
	extern constraint data_c;
endclass

constraint generator::data_c { data > 3'b100;}

module tb;
	generator gen;

	initial begin
		gen = new;

		for (int i=0; i<10; i++)

		begin
			gen.randomize();
			$display("The addr and data is %0d, %0d",gen.addr, gen.data);
		end
	end
	endmodule

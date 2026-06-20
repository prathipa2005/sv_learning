//***********************************************************************
// File : Constraint with inside and Inline constraint.sv
// Description : Demonstration of the Constraint with inline and inside
//***********************************************************************


class generator;
	rand  logic [3:0] addr;
	randc logic [2:0] data;
endclass


module tb;
	generator gen;

	initial begin
		gen = new;

		for (int i=0; i<10; i++)

		begin
          gen.randomize() with {data > 3'b100; addr > 4'b1000;};
			$display("The addr and data is %0d, %0d",gen.addr, gen.data);
		end
	end
	endmodule


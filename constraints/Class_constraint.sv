//*************************************************************
// File : Class constraint.sv
// Description : Demonstration of the class Constraint
//*************************************************************


class generator;
	rand logic [3:0]  addr;
	randc logic [2:0] data;

	constraint addr_c { addr>= 4'b1000 ;}
	constraint data_c { data>= 3'b100;}
endclass

module tb;
	generator gen;

	initial begin
		gen = new;

		for (int i=0; i<10; i++)
		begin
			gen.randomize();
			$display("the addr and the data is %0d, %0d",gen.addr, gen.data);
		end
	end
	endmodule

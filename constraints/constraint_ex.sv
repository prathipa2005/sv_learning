//******************************************************************
// File :  Constraint.sv
// Description : Demonstration of the different constraint example
//******************************************************************



class example;
	rand bit a;
	rand bit [1:0] b;
	rand bit [2:0]c;
	int count[8];
	rand bit [2:0] darray[];
	rand bit [2:0] queue[$];

	constraint ab_c {a-> b == 3'h3;
			solve a before b;}
	constraint c_c {c dist {1:=30 , [2:4] :=30 , [5:7] :/30};}

	constraint array { foreach(darray[i])
				darray[i] == i;
			   foreach(queue[i])
				   queue[i] == i; }

	function string display();
		return $sformatf ("a = %0d, b = %0d, c=%0d",a, b, c);
	endfunction

	function new();
		darray = new[5];

		repeat(5)
			queue.push_back(0);
	endfunction
endclass

module tb;

	example ex;

	initial begin
		ex = new;

      for (int i=0; i< 200; i++)
		begin
			ex.randomize();
			ex.count[ex.c]++;
			$display("The value of %s",ex.display());
		end

		$display("The array = %p and The queue = %p",ex.darray,ex.queue);

		for(int i=1; i<8; i++)
			$display("Count %0d] = %0d",i,  ex.count[i]);

	end
	endmodule


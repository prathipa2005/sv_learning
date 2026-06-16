//*************************************************************
// File : Inheritance.sv
// Description : Demonstration of the class Inheritance
//*************************************************************


class baseclass;
	bit [15:0] data;

	function new(bit[15:0] data);
		this.data = data;
	endfunction

	function void display();
		$display("The data is %0h",data);
	endfunction
endclass

class subclass extends baseclass;
	bit[15:0]addr;

	function new(bit[15:0] data,bit [15:0] addr);
		super.new(data);

		this.addr=addr;
	endfunction

	function void display();
		$display("The data is %0h and the addr is %0h",data,addr);
	endfunction

endclass

module tb;

baseclass bc;
subclass sc;

initial begin
	bc=new(16'hface);
	bc.display();

	sc=new(16'hfafa,16'haaaa);
	sc.display();
end
endmodule

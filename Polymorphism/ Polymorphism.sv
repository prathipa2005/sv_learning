//**********************************************************************
// File : Polymorphism.sv
// Description : Demonstration of the Polymorphism amd virtual methods
//*********************************************************************


class baseclass;
	bit [15:0] data;

	function new(bit[15:0] data);
		this.data = data;
	endfunction

	virtual function void display();
      $display("(Base class)The data is %0h",data);
	endfunction
endclass

class subclass extends baseclass;
	bit[15:0]addr;

	function new(bit[15:0] data,bit [15:0] addr);
		super.new(data);

		this.addr=addr;
	endfunction

	function void display();
      $display("(Sub class)The data is %0h and the addr is %0h",data,addr);
	endfunction

endclass

module tb;

baseclass bc;
subclass sc;

initial begin
	sc=new(16'hface,16'haaaa);
	bc=sc; //assign the subclass handle to the base class handle

	bc.display(); // Dynamic Binding : child class display function is executed using the base class handle becz the method in baseclass is virtual
	//$display("sub class  member accessed by parent class  handle, addr=%0d",bc.addr) // Even though a parent class handle can point to a child class object,
	the child class data members cannot be accessed directly through the parent class handle.
end
endmodule


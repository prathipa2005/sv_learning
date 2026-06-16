//*****************************************************************************
// File : Abstract class.sv
// Description : Demonstration of the abstract class and pure  virtual methods
//*****************************************************************************


virtual class packets;
	int data;

	function new(int data);
		this.data=data;
	endfunction
		
	pure virtual function void display();
	
endclass

class ethernet extends packets;
	int id;
	function new(int data, int id);
		super.new(data);
		this.id = id;
	endfunction

	function void display();
		$display("This is ethernet packets with data %0d and id %0d", data , id);
	endfunction
endclass

module tb;

	ethernet ep;
	initial begin
		ep = new (21,2);
		ep.display();

	end
	endmodule

	



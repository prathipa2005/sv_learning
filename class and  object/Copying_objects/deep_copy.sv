//****************************************************
// File : Deep copy.sv
// Description : Demonstration of the Deep copy
//****************************************************


class subheader;
	int priority_level;

	function new (int priority_level);
		this.priority_level = priority_level;
	endfunction

endclass

class header;
	int id;
	subheader sb;

	function new (int id, int priority_level);
		sb = new(priority_level);
		this.id = id;
	endfunction

endclass

class packets;
	int data;
	int addr;
	header hdr;

	function new (int data, int  addr, int id, int priority_level);
		
		hdr = new(id,priority_level);
		this.addr = addr;
		this.data = data;
	endfunction


	function void copy(packets p);
		this.data = p.data;
		this.addr = p.addr;
		this.hdr.id = p.hdr.id;
		this.hdr.sb.priority_level = p.hdr.sb.priority_level;

	endfunction

	function void display(string p);
      $display("[%s] the data is %0d , addr is %0d , id is %0d , priority is %0d",p,data,addr,hdr.id,hdr.sb.priority_level);
	endfunction
endclass

module tb;
	packets p1,p2;

	initial begin

		p1 = new (1,2,3,4);

		p1.display("p1");

		p2 = new (3,4,5,6);

		p2.copy(p1);

		p2.display("p2");

		p2.hdr.id = 51;

		p2.hdr.sb.priority_level = 31;

      p1.display("p1");
      p2.display("p2");
	end
	endmodule

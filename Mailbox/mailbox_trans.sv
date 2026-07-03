//*********************************************************************************
// File        : Mailbox.sv
// Description : Demonstrates mailbox transaction operation.
//*********************************************************************************

class trans;
	rand bit [2:0]data;

	function void display();
		$display(" data = %0d",data);
	endfunction

endclass

class generator;
	mailbox gen_mb;

  	function new (mailbox mbx);
		gen_mb = mbx;
	endfunction

	task send();
		trans tr = new;
      	tr.randomize;
		gen_mb.put(tr);
      	$display("The data is put into mailbox");
      	tr.display();
	endtask

endclass

class driver;
	mailbox dri_mb;

	function new (mailbox mbx);
		dri_mb = mbx;
	endfunction

	task receive();
		trans tr_d = new();
		dri_mb.get(tr_d);
      	$display("the data is get from mailbox");
		tr_d.display();
	endtask

endclass

module tb;
	mailbox mbx= new();
	generator gen = new(mbx);
	driver dri = new(mbx);

	initial begin
      fork
		gen.send();
		dri.receive();
      join
	end
endmodule


	

	

//*********************************************************************************
// File        : Mailbox_typed.sv
// Description : Demonstrates mailbox parameter operation.
//*********************************************************************************

typedef mailbox #(string) mb;

class comp1;

	mb names;

	task send;
		string s;
		for(int i =0; i<5; i++)
		begin
			s = $sformatf("%0d",i);
			 #1 names.put(s);
			$display("[%0t] The names is put into mailbox %s",$time,s);
		end

	endtask

endclass

class comp2;
	mb list;

	task receive;
		
		forever
		begin
          string s;
			list.get(s);
          $display("[%0t] The received data is %s",$time,s);
		end
	endtask
endclass


module tb;

	mb mbx = new();
	comp1 c1 = new();
	comp2 c2 = new();
initial  begin
	c1.names = mbx;
	c2.list = mbx;

	fork
		c1.send();
		c2.receive();
    join
	end

endmodule

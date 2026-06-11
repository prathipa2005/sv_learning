//*********************************************************************
// File : Explicitly called constructor.sv
// Description : Demonstration of the calling constructor Explicitly
//*********************************************************************


class Packet;
	bit [15:0]id;

	function new ();
		id=16'hface;
	endfunction
endclass

module tb;
	
	initial begin
		Packet pkt;
		pkt=new;
		$display("id  is %0h",pkt.id);
	end
endmodule

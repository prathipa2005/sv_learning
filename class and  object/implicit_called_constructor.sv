//*********************************************************************
// File : Implicitly called constructor.sv
// Description : Demonstration of the calling constructor implicitly
//*********************************************************************

class Packet;
	bit [15:0]id;

endclass

module tb;

	Packet pkt;

	initial begin
		pkt=new();
		$display("the id is implictly initialized as %0h", pkt.id);
	end
	endmodule


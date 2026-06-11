//*************************************************************
// File : Handle_copy.sv
// Description : Demonstration of the class handle copy
//************************************************************


class mypkt;
	int count;
endclass

module tb();
	mypkt pkt,pkt1;

	initial begin
	
		if(pkt==null)
			$display("No object is created");

		pkt=new();

		if(pkt==null)
        
			$display("Still obbject is not created");
		else
			$display("Object is created and pointing the property in the  class");

		pkt.count=1;

		$display("The value  of count is %0d",pkt.count);
		pkt1=pkt;

		$display("The value  of count is %0d",pkt.count);

		$display("The value  of count is %0d",pkt1.count);

		pkt.count=0;
		
		$display("The value  of count is %0d",pkt.count);
		$display("The value  of count is %0d",pkt1.count);
		pkt1.count=1;
		$display("The value  of count is %0d",pkt.count);
		$display("The value  of count is %0d",pkt1.count);
	end
	endmodule


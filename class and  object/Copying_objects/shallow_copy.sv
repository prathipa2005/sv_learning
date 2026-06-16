//***********************************************************************************************
// File : Shallow copy.sv
// Description : Demonstration of the Shallow copy
//***********************************************************************************************


class header;
	int id;
	function new(int id);

		this.id = id;
	endfunction
endclass

class packet;
  int data;
  header hdr;
  
  function new (int id , int data);
    hdr = new(id);
    this.data = data;
  endfunction
endclass
  
module tb;
	packet p1,p2;

	initial begin

      p1 = new (1 , 2);
      $display("The value of id (p1) is %0d ,data is %0d",p1.hdr.id,p1.data);
		
		p2 = new p1;
      $display("The value of id (p2) is %0d and data is %0d",p2.hdr.id,p2.data);

		p2.hdr.id = 3;
      
      	p2.data = 4;
      $display("The value of the id (p2) is %0d and data (p2) is  %0d",p2.hdr.id,p2.data);

      $display("The value of the id (p1) is %0d and data (p1) is  %0d",p1.hdr.id,p1.data);

	end		

	endmodule

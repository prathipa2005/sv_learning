//**************************************************************************************
// File : Randomization.sv
// Description : Demonstration of the pre_random(), post_random(), rand_mode() functions
//**************************************************************************************


class packet;
	rand int addr;
  	rand  int data;
  
  bit first_time=1;

	function void pre_randomize();
      if(first_time)
        data.rand_mode(0);
      
      addr = 40;
      $display("Before Randomization the addr is %0d",this.addr);
		$display("Randmization Starts");
      first_time = 0;
	endfunction

	function void post_randomize();
      $display("The data in post function is %0d",this.data);
      
      data.rand_mode(1);
      
      $display("After Enable the randomization the data is %0d",this.data);
      
		$display("After Randomization the addr is %0d",this.addr);
		addr = 35;
		
	endfunction
endclass

module tb;

	packet p;

	initial begin 
		p = new;

		p.randomize();
      
      $display("the addr and data assigned on 1st function call is %0d,  %0d ",p.addr,p.data);
      
      p.randomize();
      
      $display("the addr and data assigned on 2nd function call is %0d,  %0d ",p.addr,p.data);
      
      
	end

	endmodule

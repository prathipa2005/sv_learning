//**********************************************************************
// File :Typedef class example.sv
// Description : Demonstration of the Typedef class concept
//*********************************************************************



typedef class driver;

class generator;
	driver dri_h;
	function void send();
		dri_h.driving();
	endfunction
	
  function void printing();
    $display("Generator class");
  endfunction

endclass

class driver;
	generator  gen_h;
 
	function void driving();
		$display("Driving the data");
      	 gen_h.printing();
	endfunction
endclass

module tb;

	generator gen;
	driver dri;

	initial begin
		gen = new();
		dri = new();

		gen.dri_h = dri;
      	dri.gen_h = gen;

		gen.send();
	end

	endmodule



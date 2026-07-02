//******************************************************************
// File :  Static_Method.sv
// Description : Demonstration of the Static method
//******************************************************************

class example;
	static int cnt;
	
	function new();
		cnt++;
	endfunction

	static function increment();
		$display("The value of the Cnt is  %0d",cnt);
	endfunction
endclass

module tb;
	example ex_h[5];
	initial begin
		for (int i = 0; i<5; i++)
			ex_h[i] = new();
		example::increment;
      ex_h[3].increment;
	end
	endmodule

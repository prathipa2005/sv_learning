//******************************************************************
// File :  Static_variable.sv
// Description : Demonstration of the Static variable
//******************************************************************

class example;
	static int cnt_s;
	int cnt;

	function new ();
		cnt++;
		cnt_s++;

		$display("the cnt and static cnt is %0d,%0d",cnt,cnt_s);
		
		
	endfunction	
endclass

module tb;
  example ex_h[5];
	initial begin
		for(int i=0; i<5 ; i++)
			ex_h[i] = new();
	end
endmodule

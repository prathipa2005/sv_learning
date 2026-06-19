//**********************************************************************
// File : Randcase.sv
// Description : Demonstration of the Randcase concept
//*********************************************************************


class ahb;
  int read_cnt,write_cnt,burst_cnt;
	
	function void read();
      read_cnt ++;
		$display("Read Operation");
	endfunction

	function void  write();
      write_cnt ++;
		$display("Write Operation");
	endfunction

	function void burst();
      burst_cnt ++;
		$display("Burst Operation");
	endfunction

	function void gen();

		randcase 
			1: read();
			4: write();
			5: burst();
		endcase
	endfunction

endclass

module tb;
	ahb a_h;

	initial begin
		a_h = new();

		repeat(15)
			a_h.gen();
      
      $display("the read function is called by %0d times",a_h.read_cnt);
      $display("the write function is called by %0d times",a_h.write_cnt);
      $display("the burst function is called by %0d times",a_h.burst_cnt);
			
	end
	endmodule

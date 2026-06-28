//***********************************************************************
// File : Interface.sv
// Description : Demonstration of the interface with parameter example 
//***********************************************************************


interface inf #(parameter int width = 4) (input bit clk,input bit rst);
  bit [width-1:0] load;
	bit load_en;
	bit down;
  bit [width-1:0] count;
endinterface

module counter #(parameter int width =4)(inf inf0);

	always@(posedge inf0.clk or posedge inf0.rst)
	begin
		if(inf0.rst)
			inf0.count<=0;
		else
		begin
			if(inf0.load_en)
				inf0.count<=inf0.load;
			else if(inf0.down)
				inf0.count<=inf0.count - 1;
			else
				inf0.count<=inf0.count + 1;

		end
	end

	endmodule

module tb;

	reg clk;
	reg rst;
  bit [3:0] load;
  bit load_en;
  bit down;

	always #10 clk = ~clk;

	inf inf1(clk,rst);
	counter c0 (inf1);

  inf #(8) inf2  (clk,rst);
  


	initial begin
      clk = 0;
      rst = 1;

		$monitor("[%0t] down=%0b load_en=%0b load=0x%0h count=0x%0h",
    	$time, inf1.down, inf1.load_en, inf1.load, inf1.count);

      $display("width of inf1 is %0h",$bits(inf1.load));
      $display ("width of inf2 is %0h",$bits(inf2.load));

		#10; rst = 0;

		for(int i=0; i<5; i++)
		begin
			int delay = $urandom_range(5,10);

          #(delay);

          assert(std::randomize(load,load_en,down));

			inf1.load = load;
			inf1.load_en = load_en;
			inf1.down = down;
		end
	repeat(5) @(posedge clk);
	$finish;

end

endmodule




	
	

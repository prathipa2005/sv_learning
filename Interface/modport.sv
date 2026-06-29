//***********************************************************************
// File : modports.sv
// Description : Demonstration of the interface with modports example 
//***********************************************************************


interface bus (input  logic  clk);
	logic req;
	logic gnt;

	clocking cb @(posedge clk);
		default input #1ns;
		default output #2ns;
      	input gnt;
      	output req;
	endclocking
  
  modport dut ( input clk, req,
                output gnt);
  modport tb (clocking cb);
                
endinterface

module des(bus.dut inf);
  always@(posedge inf.clk)
	begin
		inf.gnt<=inf.req;
	end
endmodule

module tb;

	reg clk =  0;

	always #10 clk = ~clk;

	bus inf(clk);
	des d1(inf);

	initial begin
      $monitor("[%0t] req = %0d, gnt = %0d",$time,inf.req,inf.cb.gnt);
		inf.cb.req <= 0;
      @(inf.cb);
      
		@(inf.cb);
		inf.cb.req <= 1;

		@(inf.cb);
		inf.cb.req <= 0;
      @(inf.cb);
		#20 $finish;
	end
	endmodule



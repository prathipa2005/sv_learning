//*********************************************************************************
// File        : Functional_Coverage_User_Defined_Bins.sv
// Description : Demonstrates user-defined bins in a coverpoint.
//               Shows how multiple values can be grouped into a single bin and
//               explains how coverage is calculated based on covered bins rather
//               than individual values.
//*********************************************************************************

module tb;
  bit [2:0]a;
  bit clk;
  
  covergroup cover_a @(posedge clk);
    coverpoint a {
      bins low = {[0:3]};
      bins mid = {4,5};
      bins high = {6,7};
    }
  endgroup
cover_a cp;
  always #5 clk = ~clk;
  
  initial begin
    cp = new();	
    clk = 0;
    
    
    a = 0;
    $display("a = %0d at [%0t]",a,$time);
    
    @(negedge clk)
    a = 7;
    $display("a = %0d at [%0t]",a,$time);
    
    @(negedge clk)
    a = 5;
    $display("a = %0d at [%0t]",a,$time);
    
    #50 $finish;
  end
  
  always@(posedge clk)
    begin
      #0 $display ("Coverage  = %0.2f %% [%0t]", cp.get_inst_coverage(),$time);
     
    end
 
    
endmodule

// Observation:
// Functional coverage is calculated based on the number of covered bins,
// not on the number of individual values sampled. A single sampled value is
// sufficient to cover its corresponding user-defined bin.
//*********************************************************************************
// File        : Functional_Coverage_Automatic_Sampling.sv
// Description : Demonstrates automatic sampling using a sampling event
//               (@posedge clk). Shows that only the value present at the
//               sampling event is recorded for coverage.
//*********************************************************************************

module tb;
  bit [1:0]a;
  bit clk;
  
  covergroup cover_a @(posedge clk);
    coverpoint a;
  endgroup
cover_a cp;
  always #5 clk = ~clk;
  
  initial begin
    cp = new();	
    clk = 0;
    
    a = 0;
    $display("a = %0d at [%0t]",a,$time);
    
    
    #4;
    a = 1;
    $display("a = %0d at [%0t]",a,$time);
       
    #6;
    a = 2;
    $display("a = %0d at [%0t]",a,$time);
     
    #2;
    a = 1;
    $display("a = %0d at [%0t]",a,$time);
    
    #10;
    a = 3;
    $display("a = %0d at [%0t]",a,$time);
     #70 $finish;
     
  end
  
  always@(posedge clk)
    begin
      #0 $display ("Coverage  = %0.2f %% [%0t]", cp.get_inst_coverage(),$time);
     
    end
 
    
endmodule
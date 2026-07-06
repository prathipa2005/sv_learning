//*********************************************************************************
// File        : Functional_Coverage_Manual_Sampling.sv
// Description : Demonstrates manual sampling using sample() in functional coverage.
//               Shows that each value must be explicitly sampled to record coverage.
//*********************************************************************************

module tb;
  bit [1:0]a;
  
  covergroup cover_a;
    coverpoint a;
  endgroup
  
  initial begin
   cover_a cp = new();	
    a = 0;
     $display("a = %0d at [%0t]",a,$time);
    cp.sample();
     a = 1;
     $display("a = %0d at [%0t]",a,$time);
       cp.sample();
    a = 1;
     $display("a = %0d at [%0t]",a,$time);
      cp.sample();
    a = 2;
    $display("a = %0d at [%0t]",a,$time);
    cp.sample();
      $display ("Coverage  = %0.2f %% [%0t]", cp.get_inst_coverage(),$time);
  end
    
endmodule

// Observation:
// In manual sampling, sample() must be called whenever a value needs to be
// recorded. Changing the signal without calling sample() does not contribute
// to functional coverage.
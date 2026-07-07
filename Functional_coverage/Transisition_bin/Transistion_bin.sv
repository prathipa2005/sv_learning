//*********************************************************************************
// File        : Basic_Transition_Bins.sv
// Description : Demonstration of transition bins and sequence-based functional
//               coverage using transition and normal value bins.
//*********************************************************************************


module  tb;
  bit [1:0]state;
  bit  clk = 0;
  
  covergroup cp @(posedge clk);
    coverpoint state{
      bins trans = (0 => 3 => 1);
      bins transi = (1 => 3);
      bins normal = {2};
      
    }
  endgroup
  
  always #5 clk = ~clk;
  cp cp_inst;
  
  initial begin
    cp_inst = new();
    state = 1;
    
     @(negedge clk);
    state = 3;
    
    @(negedge clk);
    state = 0;
    
    @(negedge clk);
    state = 3;
    
    @(negedge clk);
    state = 2;
    
    @(negedge clk);
    state = 1;
    
    @(negedge clk);
    state = 0;
    
    @(negedge clk);
    state = 3;
    
    @(negedge clk);
    state = 1;
    
    #10 $finish;
  
  end
  
  always@(posedge clk)
    #0 $display("[%0t] Coverage = %0.2f%%",$time,cp_inst.get_coverage());
  
  always@(negedge clk)
    #0 $display("[%0t] State = %0d",$time,state);
  
endmodule

//*********************************************************************************
// Experimental Observations
// -------------------------
// 1. Transition bins verify the order in which sampled values occur instead of
//    checking individual values.
//
// 2. A transition bin is covered only when the complete transition sequence is
//    observed consecutively during sampling.
//
// 3. If an unexpected value appears between the required transition values, the
//    current sequence is discarded and the simulator searches for a new valid
//    starting point.
//
// 4. The simulator continuously looks for possible starting values and can begin
//    matching again whenever a new valid starting point is encountered.
//
// 5. Once a transition bin is covered, additional occurrences of the same
//    transition do not increase the coverage percentage. They only increase the
//    hit count.
//
// 6. A coverpoint can contain both normal value bins and transition bins.
//    Normal bins are covered when their value is sampled, whereas transition
//    bins are covered only after the complete transition sequence is matched.
//*********************************************************************************
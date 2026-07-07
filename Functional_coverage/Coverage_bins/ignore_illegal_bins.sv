//*********************************************************************************
// File        : Covergroup_Conditional_Bins.sv
// Description : Demonstration of conditional coverage using iff(), ignore_bins,
//               and illegal_bins.
//*********************************************************************************

module tb;
  bit [3:0]val;
  bit clk = 0;
  bit enable;
  
  covergroup cp @(posedge clk);
    coverpoint val iff (enable) {
      bins value = {[0:5]};
      bins value_a = {[5:13]};
      ignore_bins val = {14};
      illegal_bins valu = {15};
    }
  endgroup
  
  always #5 clk = ~clk;
  cp cp_val;
  
  initial begin
    cp_val  = new();
    
    val = 2;
    enable = 0;
    
    #27 enable = 1;
    @(negedge clk)
    val = 6;
    
    @(negedge clk);
    val = 14;
    
    @(negedge clk)
    val = 15;
    
    @(negedge clk)
    val = 2;
    
    #10 $finish;
  end
  
  always@(posedge clk)
    begin
     #0 $display("[%0t] Coverage = %0.2f%",$time,cp_val.get_coverage);
    end
  always@(negedge clk)
    begin
      #0 $display("[%0t] val = %0d",$time,val);
    end
endmodule

//*********************************************************************************
// Experimental Observations
// -------------------------
// 1. The coverpoint samples data only when the iff(enable) condition evaluates
//    to true.
//
// 2. Values sampled while enable is low are completely ignored and do not
//    contribute to coverage.
//
// 3. ignore_bins excludes specified values from coverage calculation.
//
// 4. illegal_bins reports an error whenever an illegal value is sampled.
//
// 5. ignore_bins cannot be conditionally enabled using iff(). The conditional
//    behavior must be applied to the coverpoint itself using iff().
//*********************************************************************************
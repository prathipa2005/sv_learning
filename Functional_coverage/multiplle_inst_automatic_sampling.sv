//*********************************************************************************
// File        : Covergroup_Per_Instance_Automatic_Sampling.sv
// Description : Demonstration of multiple parameterized covergroup instances
//               using event-based automatic sampling.
//*********************************************************************************

module tb;
  bit [1:0] port_a ,port_b,port_c;
  bit clk = 0;
  
  covergroup cp(ref bit [1:0] data)@(posedge clk);
    option.per_instance =1;
    coverpoint data;
  endgroup
  
  always #5 clk = ~clk;
  cp cp1;
  cp cp2;
  cp cp3;
  
  initial begin
    cp1 = new(port_a);
    cp2 = new(port_b);
    cp3 = new(port_c);
    
    @(negedge clk);
    port_a = 1;
    
    @(negedge clk);
    port_b = 1;
    @(negedge clk);
    
    port_b = 2;
    @(negedge clk);
    
    
    port_c = 1;
   #10 $finish;
  end
  
  always@(posedge clk)
    begin
    #0
      $display("coverage port_a = %0.2f%%",cp1.get_inst_coverage());
      $display("coverage port_b= %0.2f%%",cp2.get_inst_coverage());
      $display("coverage port_c = %0.2f%%",cp3.get_inst_coverage());
    $display("coverage = %0.2f%%",cp1.get_coverage());
    
  end
endmodule


//*********************************************************************************
// Experimental Observations
// -------------------------
// 1. All covergroup instances sample simultaneously on every positive edge of
//    the clock.
//
// 2. Since port_a, port_b and port_c are declared as 'bit', their default value
//    is 0 before any explicit assignment.
//
// 3. Therefore, the very first sampling event covers the value 0 for every
//    covergroup instance, resulting in an initial coverage of 25%.
//
// 4. Although port_b is never explicitly assigned the value 0, it still reaches
//    100% coverage because the initial automatic sampling already covered the
//    default value 0.
//
// 5. If the monitored variables are declared as 'logic' instead of 'bit', the
//    initial sampled value becomes X, resulting in different coverage behavior.
//
// 6. Automatic sampling depends entirely on the sampling event, not on the
//    position of assignment statements in the source code.
//*********************************************************************************

//*********************************************************************************
// Key Learning
// ------------
// Coverage is determined by the value present at the sampling instant.
// It does not depend on when the assignment statement appears in the code.
//
// In this experiment, the first automatic sampling occurred before any explicit
// assignments. Since the monitored variables were declared as 'bit', they were
// initialized to 0 by default. As a result, the 0 bin was covered even though
// it was never explicitly assigned later in the testbench.
//*********************************************************************************
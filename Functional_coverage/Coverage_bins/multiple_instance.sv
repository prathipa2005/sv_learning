//*********************************************************************************
// File        : Covergroup_Per_Instance_Manual_Sampling.sv
// Description : Demonstration of multiple parameterized covergroup instances
//               using ref arguments, option.per_instance, and manual sampling.
//*********************************************************************************

module tb;
  bit [1:0] port_a ,port_b,port_c;
  
  covergroup cp(ref bit [1:0] data);
    option.per_instance =1;
    coverpoint data;
  endgroup
  
  cp cp1;
  cp cp2;
  cp cp3;
  
  initial begin
    cp1 = new(port_a);
    cp2 = new(port_b);
    cp3 = new(port_c);
    
    port_a = 1;
    cp1.sample();
    cp3.sample();
    
    port_b = 1;
    cp2.sample();
    cp1.sample();
    cp3.sample();
    
    port_b = 2;
    cp2.sample();
    cp1.sample();
    
    cp3.sample();
    port_c = 1;
    cp3.sample();
    
    $display("coverage = %0.2f%%",cp1.get_inst_coverage());
    $display("coverage = %0.2f%%",cp2.get_inst_coverage());
    $display("coverage = %0.2f%%",cp3.get_inst_coverage());
    $display("coverage = %0.2f%%",cp1.get_coverage());
    $display("coverage = %0.2f%%",cp2.get_coverage());
    $display("coverage = %0.2f%%",cp2.get_coverage());
  end
endmodule

//*********************************************************************************
// Experimental Observations
// -------------------------
// 1. A single covergroup definition can be instantiated multiple times to
//    monitor different variables.
//
// 2. option.per_instance = 1 enables separate coverage collection for each
//    covergroup instance.
//
// 3. sample() provides explicit control over when coverage is collected.
//
// 4. get_inst_coverage() reports coverage of an individual covergroup instance.
//
// 5. get_coverage() reports the overall coverage accumulated across all
//    instances of the same covergroup type.
//*********************************************************************************
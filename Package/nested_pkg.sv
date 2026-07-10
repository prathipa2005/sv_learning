/*****************************************************************************************
File Name    : nested_packages.sv

Description  :
This example demonstrates nested package usage in SystemVerilog, where one
package imports another package to reuse its declarations. It illustrates
package hierarchy, scope resolution, local declaration precedence, and package
reuse across multiple package levels.
*****************************************************************************************/


package x;
    bit [1:0] data = 2;
    int val = 10;
    string name = "x";

    function void display();
        $display("data = %0d, val = %0d, name = %s",data,val,name);
    endfunction

endpackage

package y;
	import x::*;
    
    int val = 10 + x::val;
    string name = "Y";

    function void display();
        $display("data = %0d, val = %0d, name = %s",data,val,name);
    endfunction

endpackage

package z;
    import y::*;
	int val = 10+ y::val;
    string name = "z";

    function void display();
        $display("val = %0d, name = %s",val,name);
    endfunction

endpackage

module rb;
  import z::*;
  initial begin
    x::display();
    y::display();
    display();
  end
endmodule

Observation:
1. A package can import another package, allowing reusable declarations to be organized hierarchically.
2. Nested packages improve modularity by separating common declarations into multiple reusable packages.
3. Scope resolution (::) provides direct access to members of a specific package, eliminating ambiguity between packages.
4. When a package defines a local declaration with the same identifier as an imported package member, the local declaration takes precedence.
5. Direct package references (package_name::member) can be used even without importing that package into the current scope.
/*****************************************************************************************
File Name    : package_import_and_scope_resolution.sv

Description  :
This example demonstrates the basic usage of SystemVerilog packages by creating
reusable package members such as variables, typedefs, enums, structs, and
functions. It also illustrates wildcard import, specific import, scope
resolution, and the compiler's search order during identifier resolution.
*****************************************************************************************/


package pkg;

	bit [1:0] data;

	typedef enum bit[1:0]{red, blue, green, yellow}color_t;

	typedef struct{
		bit [1:0] a;
		bit b;
		string c;
		}value_t;

	function void display();
		$display("Package Display");
	endfunction

endpackage

import pkg::value_t;
import pkg::color_t;
import pkg::display;
import pkg::blue;
module tb;
	bit [1:0] data;
	color_t color;
	value_t set;
	initial begin
		display();

      color = blue;
      $display("color = %d",color);
      $display("color = %s",color.name());
		
		color = pkg::green;
      $display("color = %d",color);
      $display("color = %s",color.name());
		
		set.b = 1;
		$display("b = %0d",set.b);

		set.c = "Hello";
		$display("c = %s",set.c);

		data = 2;

		pkg::data = 3;

		$display("Local data = %0d",data);
		$display("Package data = %0d",pkg::data);
	end

	endmodule


Observation:
1. A package acts as a separate namespace that stores reusable declarations such as variables, typedefs, enums, structs, functions, tasks, classes, and parameters.
2. Wildcard import makes package members available in the current scope, whereas specific import exposes only the explicitly imported members.
3. Package members can also be accessed directly using the scope resolution operator (::) without importing the package.
4. Local declarations have higher priority than imported package members during identifier resolution. To explicitly access a package member with the same name, the scope resolution operator (::) must be used.
5. Enum labels are treated as individual identifiers. When using specific import, each required enum label must either be imported separately or accessed using the package scope.
/*****************************************************************************************
File Name    : local_vs_protected_access_modifiers.sv

Description  :
This example demonstrates the visibility of public, local, and protected class
members in SystemVerilog using inheritance.
*****************************************************************************************/

class baseclass;
	bit a = 10;
	local bit local_a = 20;
	protected bit prot_a = 30;

endclass

class  subclass  extends baseclass;
	function void display();
      $display(" public member: a = %0d",a);
      $display("The protected value of a is  accessed by inherited  class %0d",prot_a);
     // $display("The local value of a is  accessed by inherited  class %0d",local_a);
	endfunction
endclass

module tb;
	baseclass bc;
	subclass sc;

	initial begin
		bc = new();
		sc = new();
		sc.display();
      $display("public member: a = %0d",bc.a);
      //$display("The protected value of a is  accessed by outside  class %0d",bc.prot_a);
      //$display("The local value of a is  accessed by outside class %0d",bc.local_a);
end
endmodule

Observation:
1. Public members can be accessed from the same class, derived classes, and outside the class through an object handle.
2. Protected members can be accessed within the same class and by derived classes, but cannot be accessed directly using an object handle.
3. Local members are accessible only within the class in which they are declared and are hidden from both derived classes and outside objects.
4. Access modifiers provide encapsulation by controlling the visibility of class members based on the required level of access.



/*****************************************************************************************
File Name    : extern_keyword_function.sv

Description  :
This example demonstrates the use of the 'extern' keyword in SystemVerilog classes.
The function is declared inside the class using the extern keyword and defined
outside the class using the scope resolution operator (::)
*****************************************************************************************/
// Code your design here
class food;
	extern function void display();
    extern task print();
endclass

    function void food::display();
	    $display("Biriyani");
    endfunction
      
    task food::print();
        $display("eat biriyani");
    endtask

module tb;
	food f_h;
	

	initial begin
      	f_h = new();
		f_h.display();
        f_h.print();
	end
	endmodule


Observation:
1. The extern keyword declares only the function prototype inside the class.
2. The actual implementation is written outside the class using the scope resolution operator (::).
3. Extern improves code readability by separating the class declaration from the method implementation.
4. The behavior of an extern function is identical to a function defined inside the class; only the location of the implementation changes.
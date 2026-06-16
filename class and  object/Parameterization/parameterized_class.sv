//***********************************************************************************************
// File : Parameterized class .sv
// Description : Demonstration of the Parameterized class by passing value  and passing datatype
//***********************************************************************************************


class counter #(parameter int size=4);
	logic [size-1:0]out;
endclass

module tb;
	counter #(5) count_5h;
	counter #(3)count_3h;
  	counter count_h;

	initial begin
	

      $display("No.of bits in out for the count_3h object is %0d",$bits(count_3h.out));
      $display("No.of bits in out for the count_5h object is %0d",$bits(count_5h.out));
      $display("No.of bits in out for the count_h object is %0d",$bits(count_h.out));

	end
	endmodule

//Pass datatype as parameter


class myclass #(type T = int);
	T value;

	function T addition (T a);
		 addition= value + a;
	endfunction

endclass

module tb;

  myclass handle_1 =new();
  myclass #(real)handle_2=new();
  myclass #(bit[2:0]) handle_3=new;

	initial begin
      
      
		handle_1.value = 45;
		handle_2.value = 4.23;
		handle_3.value = 4'b1010;

		$display("The value for handle_1 as int is %0d",handle_1.addition(21));
      $display("The value for handle_2 as real is %0.2f",handle_2.addition(13));
      $display("The value for handle_3 as 3 bit vector is %0d",handle_3.addition(8));

	end
	endmodule


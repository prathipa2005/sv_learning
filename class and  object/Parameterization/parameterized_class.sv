//***********************************************************************************************
// File : Parameterized class .sv
// Description : Demonstration of the Parameterized class by passing value 
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





//**********************************************************************
// File : Casting.sv
// Description : Demonstration of the Dynamic casting and static casting
//*********************************************************************

//Dynamic Casting

class transaction;
	int id;
endclass

class upi extends transaction;
	int upi_amt;
endclass

class money extends transaction;
	int inhand_amt;
endclass

module tb;


transaction tr;

initial begin
	upi upi_h = new;
    upi upi_h1;
	money money_h;
	tr = upi_h;
	upi_h.upi_amt = 20;

    if($cast(upi_h1,tr)) 
	    begin
		    $display("casting success");
		    $display("the upi amt is %0d",upi_h1.upi_amt);
	    end
	else
		$display("casting failed");

	if($cast(money_h,tr))
		$display("casting success");
	else
		$display("casting failed");

end
endmodule


//Static casting

module static_cast;

   int value = 10;
   bit [2:0] data;

   initial begin

      data = bit[2:0]'(value);

      $display("value = %0d", value);
      $display("data  = %0d", data);

   end

endmodule
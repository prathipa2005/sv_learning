//**********************************************************************
// File : Dynamic Casting.sv
// Description : Demonstration of the Dynamic casting
//*********************************************************************


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



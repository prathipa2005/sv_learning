//**********************************************************************
// File : Static Casting.sv
// Description : Demonstration of the static casting
//*********************************************************************


module static_cast;

   int value = 10;
   bit [2:0] data;

   initial begin

      data = bit[2:0]'(value);

      $display("value = %0d", value);
      $display("data  = %0d", data);

   end

endmodule
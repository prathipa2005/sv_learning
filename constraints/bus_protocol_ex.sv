//***************************************************************************
// File : Bus protocol constraint.sv
// Description : Demonstration of the Constraint in the bus protocol example
//***************************************************************************



class bus;
    rand bit[31:0]addr;
    rand bit[31:0]data;

    rand bit[1:0] burst_len;
    rand bit[3:0] length;

    constraint addr_c {addr%4 == 0;}

  function void display(int id = 0);
        $display("Transaction id = %0d", id);
        $display("addr = %0h", addr);
        $display("data = %0h", data);
        $display("burst = %0d", burst_len + 1);
        $display("Transaction count = %0d", length + 1);
    endfunction
        
endclass


module tb;
    int slave_start_addr;
    int slave_end_addr;

    bus b;
    initial begin
        b = new;
      	slave_start_addr = 32'h200;
        slave_end_addr = 32'h10000000;

        for(int i=0; i<3; i++)
        begin
            b.randomize() with {addr >= slave_start_addr;
                                addr < slave_end_addr;
                                (burst_len + 1) * (length + 1) + addr < slave_end_addr;};
        
            b.display(i);

        end


    end 

endmodule

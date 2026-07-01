//******************************************************************
// File :  Event with order.sv
// Description : Demonstration of the the event by checking its order
                 of execution
//******************************************************************


module tb;

    event e1, e2, e3;

    initial begin
        fork

            begin
                #10 -> e1;
                $display("[%0t] e1 Triggered", $time);

                #10 -> e2;
                $display("[%0t] e2 Triggered", $time);

                #10 -> e3;
                $display("[%0t] e3 Triggered", $time);
            end

            begin
                wait_order(e1, e2, e3)
                    $display("[%0t] Events occurred in correct order", $time);
                else
                    $display("[%0t] Events occurred in wrong order", $time);
            end

        join
    end

endmodule
//******************************************************************
// File :  Event merging.sv
// Description : Demonstration of the Merging event...but this is done
                 only using @(event_name) method..but it show different
                 output when use of wait(event_name.triggered)
//******************************************************************


module tb;

    event event_a, event_b;

    initial begin

        fork

            // Thread 1
            begin
                $display("[%0t] Thread 1 : Waiting for event_a", $time);

                @(event_a);

                $display("[%0t] Thread 1 : event_a Triggered", $time);
            end

            // Thread 2
            begin
                $display("[%0t] Thread 2 : Waiting for event_b", $time);

                @(event_b);

                $display("[%0t] Thread 2 : event_b Triggered", $time);
            end

            // Assign handles
            begin
                #10;
                event_a = event_b;

                $display("[%0t] event_a now points to event_b", $time);
            end

            // Trigger event_a
            begin
                #20;
                ->event_a;

                $display("[%0t] Trigger event_a", $time);
            end

            // Trigger event_b
            begin
                #30;
                ->event_b;

                $display("[%0t] Trigger event_b", $time);
            end

        join

    end

endmodule
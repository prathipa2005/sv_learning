//*********************************************************************************
// File        : Semaphore_ownership_experiment.sv
// Description : Experimental verification to observe semaphore ownership behavior.
//               Demonstrates that SystemVerilog semaphores maintain only the key
//               count and do not track which process owns the acquired keys.
//*********************************************************************************

/*Experimental Observation

Observation:

This experiment intentionally performs an incorrect semaphore
 operation by calling put(2) from a process that never acquired  keys.

Despite this, the semaphore accepts the returned keys without 
generating an error. As a result, the total number of available 
keys increases beyond the original count, allowing a subsequent 
get(4) operation to succeed.

Conclusion:

This demonstrates that a SystemVerilog semaphore does not track key 
ownership. It only maintains the current number of available keys.
 It is therefore the programmer's responsibility to ensure that 
 every successful get() or try_get() is paired with a corresponding 
 put() of the same number of keys.*/

module tb;

    semaphore key;

    initial begin

        // Create semaphore with 2 keys
        key = new(2);

        // Person 1 acquires both keys
        $display("[%0t] Person 1 requests 2 keys", $time);
        key.get(2);
        $display("[%0t] Person 1 acquired 2 keys", $time);

        // Person 2 tries to acquire 2 keys
        #5;
        $display("[%0t] Person 2 requests 2 keys", $time);

        if (key.try_get(2))
            $display("[%0t] Person 2 acquired 2 keys", $time);
        else begin

            $display("[%0t] Person 2 could not acquire the keys", $time);

            // Simulate Person 1 returning the keys
            #10;
            key.put(2);
            $display("[%0t] Person 1 returned 2 keys", $time);

            // Intentional incorrect operation
            // Person 2 returns keys even though it never acquired them
            #5;
            key.put(2);
            $display("[%0t] Person 2 incorrectly returned 2 keys", $time);

            // Semaphore now believes it has 4 keys
            #10;
            key.get(4);
            $display("[%0t] Successfully acquired 4 keys", $time);

        end

    end

endmodule



//*********************************************************************************
// File        : Semaphore_try_get.sv
// Description : Demonstrates non-blocking semaphore access using try_get()
//*********************************************************************************

module tb;
	semaphore key;

	initial begin
      key = new(2);
		fork
          person(1,20);
          person(2,10);
          #5 person(3,15);
		join_none
		#100 $finish;
	end

  task automatic person(int id,int time_u);
    bit success;
    getroom(id,success);
    if(success)
      begin
    #time_u putroom(id);
      end
	endtask

	

  task automatic getroom(int person,output bit success);
		$display("%0t The key is requested is by  person %0d",$time,person);
    success =  key.try_get();
    if(success)
          begin
        $display("[%0t] Person %0d acquired the key",$time,person);
         
          end
    else
      begin
        $display("[%0t] Person %0d could not acquire the key",$time,person);
      
      end
    endtask

  task putroom(int person);
      $display("[%0t] The room is leaving by  person %0d",$time,person);
		key.put(1);
      $display("%0t The key is put back by person %0d",$time,person);
	endtask

	endmodule


//************************************************************************
// File :  Semaphore.sv
// Description : Demonstrates counting semaphore using get() and put()
//************************************************************************


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
   
    getroom(id);
   
  
    #time_u putroom(id);
     
	endtask

	

  task automatic getroom(int person);
		$display("%0t The key is requested is by  person %0d",$time,person);
    key.get(1);
         
        $display("[%0t] Person %0d acquired the key",$time,person);
         
    endtask

  task putroom(int person);
      $display("[%0t] The room is leaving by  person %0d",$time,person);
		key.put(1);
      $display("%0t The key is put back by person %0d",$time,person);
	endtask

	endmodule


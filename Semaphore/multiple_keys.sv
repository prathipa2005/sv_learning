//*********************************************************************************
// File        : Semaphore_multiple_keys.sv
// Description : Demonstrates requesting and returning multiple semaphore keys
//*********************************************************************************

module tb;
	semaphore key;

	initial begin
      key = new(3);
		fork
          person(1,20,2);
          person(2,10,2);
          #5 person(3,20,1);
		join_none
		#100 $finish;
	end

  task automatic person(int id,int time_u,int key_cnt);
   
    getroom(id,key_cnt);
   
  
    #time_u putroom(id,key_cnt);
     
	endtask

	

  task automatic getroom(int person , int key_cnt);
    $display("%0t The %0d key is requested by  person %0d",$time,key_cnt,person);
    key.get(key_cnt);
         
    $display("[%0t] The %0d keys is acquired by the person %0d",$time,key_cnt,person);
         
    endtask

  task putroom(int person,int key_cnt);
    $display("[%0t] The %0d room is leaving by  person %0d",$time,key_cnt,person);
    key.put(key_cnt);
    $display("%0t The %0d key is put back by person %0d",$time,key_cnt,person);
	endtask

	endmodule


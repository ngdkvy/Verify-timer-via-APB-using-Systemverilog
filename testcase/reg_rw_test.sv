class reg_rw_test extends base_test;
    
     function new();
          super.new();
     endfunction

     virtual task run_scenario();
          bit [7:0] rdata;
          bit [7:0] addr = 8'h00;
          bit [7:0] compare;
          wait (dut_vif.presetn == 1); 
          @(posedge dut_vif.pclk);
          for (int i = 0; i < 4; i = i + 1)
          begin
               compare = $random;
               write(addr, compare);
               if (addr == 8'h00)
                    compare = compare & 8'h0F;
               else if (addr == 8'h03)
                    compare = compare & 8'h03;
               else if (addr == 8'h01)
                    compare = 0;
               else if (addr == 8'h02)
                    compare = compare & 8'hFF;
               read(addr, rdata);
               if (rdata == compare)
                    $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, addr, rdata);
               else begin
                    $display("%0t: [base_test] TEST FAILED. Read: addr = %h, exp = %h, act = %h", $time, addr, compare, rdata);
                    error_cnt = error_cnt + 1;
               end 
               addr = addr + 1;
         end 
     endtask
endclass


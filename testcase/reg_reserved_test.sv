class reg_reserved_test extends base_test;
        
     function new();
          super.new();
     endfunction

     virtual task run_scenario();
          bit [7:0] rdata;
          bit [7:0] addr;
          wait (dut_vif.presetn == 1); 
          @(posedge dut_vif.pclk);
          for (int i = 0; i < 10; i = i + 1)
          begin
               addr = $urandom_range(8'h4, 8'hff);
               write(addr, 8'hFF);
               read(addr, rdata);
               if (rdata == 8'h00)
                    $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, addr, rdata);
               else begin
                    $display("%0t: [base_test] TEST FAILED. Read: addr = %h, data = %h", $time, addr, rdata);
                    error_cnt = error_cnt + 1;
               end
          end 
     endtask
endclass


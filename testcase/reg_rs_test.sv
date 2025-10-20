class reg_rs_test extends base_test;
        
     function new();
          super.new();
     endfunction

     virtual task run_scenario();
          bit [7:0] rdata;
          bit [7:0] addr = 8'h00;
          wait (dut_vif.presetn == 1); 
          @(posedge dut_vif.pclk);
          for (int i = 0; i < 4; i = i + 1)
          begin
               write(addr, $random);
               addr = addr + 1;
          end
          @(posedge dut_vif.pclk);
          #1ns;dut_vif.presetn = 0;
          @(posedge dut_vif.pclk);
          #1ns;dut_vif.presetn = 1;
          for (int i = 0; i < 4; i = i + 1)
          begin
               read(addr, rdata);
               if (rdata == 8'h00)
                    $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, addr, rdata);
               else begin
                    $display("%0t: [base_test] TEST FAILED. Read: addr = %h, data = %h", $time, addr, rdata);
                    error_cnt = error_cnt + 1;
               end 
               addr = addr + 1;
         end 
     endtask
endclass


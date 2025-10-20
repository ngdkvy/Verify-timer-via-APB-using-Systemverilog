class underflow_dis_test extends base_test;
        
     function new();
          super.new();
     endfunction

     virtual task run_scenario();
          bit [7:0] rdata;
          wait (dut_vif.presetn); 
          @(posedge dut_vif.pclk);
          #1;
          write(8'h00, 8'b11);
          repeat (255) @(posedge dut_vif.pclk);
          if (!dut_vif.interrupt)
               $display("%0t: [base_test] TEST PASSED. Interrupt is asserted", $time);
          else begin
               $display("%0t: [base_test] TEST FAILED. Interrupt is not asserted", $time);
               error_cnt = error_cnt + 1;
          end
     endtask
endclass


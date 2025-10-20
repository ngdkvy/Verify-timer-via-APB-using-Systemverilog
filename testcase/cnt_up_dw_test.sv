class cnt_up_dw_test extends base_test;
    
     function new();
          super.new();
     endfunction

     virtual task run_scenario();
          bit [7:0] rdata;
          wait (dut_vif.presetn == 1); 
          @(posedge dut_vif.pclk);
          #1;
          write(8'h03, 8'b11);
          write(8'h00, 8'b01);
          repeat (130) @(posedge dut_vif.ker_clk);
          write(8'h00, 8'b11);
          repeat (300) @(posedge dut_vif.ker_clk);
          read(8'h01, rdata);
          if ((dut_vif.interrupt) && (rdata == 8'b10))
               $display("%0t: [base_test] TEST PASSED", $time);
          else begin
               $display("%0t: [base_test] TEST FAILED. Count value is not matching", $time);
               error_cnt = error_cnt + 1;
          end
     endtask
endclass


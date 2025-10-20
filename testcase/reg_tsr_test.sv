class reg_tsr_test extends base_test;
    
     function new();
          super.new();
     endfunction

     virtual task run_scenario();
          bit [7:0] rdata;
          wait (dut_vif.presetn); 
          @(posedge dut_vif.pclk);
          #1;
          write(8'h03, 8'b11);
          write(8'h00, 8'b01);
          wait (dut_vif.interrupt);
          write(8'h01, 8'b00);
          read(8'h01, rdata);
          if (rdata == 8'b01)
               $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
          else begin
               $display("%0t: [base_test] TEST FAILED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
               error_cnt = error_cnt + 1;
          end
          write(8'h01, 8'b01);
          read(8'h01, rdata);
          if (rdata == 8'b0)
               $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
          else begin
               $display("%0t: [base_test] TEST FAILED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
               error_cnt = error_cnt + 1;
          end
          write(8'h00, 8'b11);
          wait (dut_vif.interrupt);
          write(8'h01, 8'b00);
          read(8'h01, rdata);
          if (rdata == 8'b10)
               $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
          else begin
               $display("%0t: [base_test] TEST FAILED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
               error_cnt = error_cnt + 1;
          end
          write(8'h01, 8'b10);
          read(8'h01, rdata);
          if (rdata == 8'b0)
               $display("%0t: [base_test] TEST PASSED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
          else begin
               $display("%0t: [base_test] TEST FAILED. Read: addr = %h, data = %h", $time, 8'h01, rdata);
               error_cnt = error_cnt + 1;
          end
     endtask
endclass


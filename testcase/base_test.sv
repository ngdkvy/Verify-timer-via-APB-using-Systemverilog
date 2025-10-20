class base_test;
     environment env;
     virtual dut_if dut_vif;
     int error_cnt;

     function new();
          error_cnt = 0; 
     endfunction

     function void build();
          env = new (dut_vif);
          env.build();
     endfunction

     task write (bit [7:0] addr, bit [7:0] data);
          packet pkt   = new() ;
          pkt.addr     = addr  ;
          pkt.data     = data  ;
          pkt.transfer = packet::WRITE;
          env.stim.send_pkt(pkt);
          @(env.drv.xfer_done);
          $display("%0t: [base_test] Write: addr = %h, data = %h", $time, pkt.addr, pkt.data);
     endtask

     task read (bit [7:0] addr, ref bit [7:0] data);
          packet pkt   = new() ;
          pkt.addr     = addr  ;
          pkt.transfer = packet::READ;
          env.stim.send_pkt(pkt);
          @(env.drv.xfer_done);
          data = pkt.data;
          $display("%0t: [base_test] Read: addr = %h, data = %h", $time, pkt.addr, pkt.data);
     endtask

     virtual task run_scenario();
     endtask

     task run_test();
          build();
          fork
               env.run();
               run_scenario();
          join_any
          env.sb.report(error_cnt);
          #1us;
          $display("%0t: [base_test] End simulation", $time);
          $finish;
     endtask
endclass

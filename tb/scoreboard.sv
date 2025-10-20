class scoreboard;
     mailbox #(packet) m2s_mb;

     int err_cnt = 0;
     function  new(mailbox #(packet) m2s_mb);
          this.m2s_mb = m2s_mb;
     endfunction

     task run();
          packet pkt;
          while (1) begin
               m2s_mb.get(pkt);
               $display("%0t: [scoreboard] Get packet from monitor: %s: addr = %b, data = %h", $time, pkt.transfer.name(), pkt.addr, pkt.data);
          end
     endtask
     function void report(int error_cnt);
          int total_error = this.err_cnt + error_cnt;
               if (total_error == 0)
                    $display("%0t: [scoreboard] TEST PASSED", $time);
               else
                    $display("%0t: [scoreboard] TEST FAILED, number of error = %0d", $time, total_error);

     endfunction
endclass

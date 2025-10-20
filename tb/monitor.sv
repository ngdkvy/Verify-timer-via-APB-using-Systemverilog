class monitor;
     mailbox #(packet) m2s_mb;
     virtual dut_if dut_vif;

     function new(virtual dut_if dut_vif, mailbox #(packet) m2s_mb);
          this.dut_vif = dut_vif;
          this.m2s_mb  = m2s_mb;
     endfunction

     task run();
          packet pkt;
          while (1) begin
               @(posedge dut_vif.psel);
               #1;
               pkt = new();
               pkt.addr     = dut_vif.paddr;
               if (dut_vif.pwrite == 1) begin
                    pkt.transfer = packet::WRITE  ;
                    pkt.data     = dut_vif.pwdata ;
               end
               else begin
                    pkt.transfer = packet::READ   ;
                    pkt.data     = dut_vif.prdata ;
               end
               $display("%0t [monitor] Captured APB transaction", $time);
               m2s_mb.put(pkt);
          end
     endtask
endclass

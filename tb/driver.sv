class driver;
     mailbox #(packet) s2d_mb;
     virtual dut_if dut_vif;
     event xfer_done;

     function new(virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
          this.dut_vif = dut_vif;
          this.s2d_mb  = s2d_mb;
     endfunction

     task run();
          packet pkt;
          while (1) begin
               s2d_mb.get(pkt);
               $display("%0t: [driver] Get packet from stimulus", $time);
               wait (dut_vif.presetn == 1);
               @(posedge dut_vif.pclk);
               #1ns;
               dut_vif.pwrite = pkt.transfer;
               dut_vif.psel   = 1;
               dut_vif.pwdata = pkt.data;
               dut_vif.paddr  = pkt.addr;
               @(posedge dut_vif.pclk);
               #1; dut_vif.penable = 1;
               if (pkt.transfer == packet::READ)
                  pkt.data = dut_vif.prdata;
               -> xfer_done;
               @(posedge dut_vif.pclk);
               #1;
               dut_vif.pwrite  = 0;
               dut_vif.psel    = 0;
               dut_vif.pwdata  = 0;
               dut_vif.paddr   = 0;
               dut_vif.penable = 0;
          end
     endtask
endclass

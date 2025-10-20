packet cnt_pkt;
covergroup APB_GROUP;
     apb_transfer: coverpoint cnt_pkt.transfer {
          bins apb_read  = {packet::READ};
          bins apb_write = {packet::WRITE};
     }
     apb_address: coverpoint cnt_pkt.addr {
          bins TCR_addr = {8'h00};
          bins TSR_addr = {8'h01};
          bins TDR_addr = {8'h02};
          bins TIE_addr = {8'h03};
     }
     apb_data: coverpoint cnt_pkt.data {
          bins TSR_data = {[0:3]};
          bins TCR_data = {[0:31]};
     }
     count_feature: cross apb_transfer, apb_address, apb_data
     {
          bins trans_1 = binsof(apb_transfer.apb_write) && binsof(apb_address.TCR_addr);
          bins trans_2 = binsof(apb_transfer.apb_write) && binsof(apb_address.TSR_addr);
          bins trans_3 = binsof(apb_transfer.apb_write) && binsof(apb_address.TDR_addr);
          bins trans_4 = binsof(apb_transfer.apb_write) && binsof(apb_address.TIE_addr);
          bins trans_5 = binsof(apb_transfer.apb_write) && binsof(apb_address.TCR_addr) && binsof(apb_data.TCR_data);
          bins trans_6 = binsof(apb_transfer.apb_read)  && binsof(apb_address.TSR_addr) && binsof(apb_data.TSR_data);
     }
endgroup

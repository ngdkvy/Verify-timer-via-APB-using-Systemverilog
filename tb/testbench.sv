`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt));

  initial begin
    d_if.presetn = 0;
    d_if.paddr   = 8'h00;
    d_if.pwdata  = 8'h00;
    d_if.psel    = 0;
    d_if.penable = 0;
    d_if.pwrite  = 0;
    #100ns d_if.presetn = 1;
  end

  // 50 MHz
  initial begin
    d_if.pclk = 0;
    forever begin 
      #10ns;
      d_if.pclk = ~d_if.pclk;
    end
  end
 
  // 200 MHz
  initial begin
    d_if.ker_clk = 1;
    forever begin 
      #2.5ns;
      d_if.ker_clk = ~d_if.ker_clk;
    end
  end

  initial begin
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

  base_test              base           = new();
  reg_def_test           reg_def        = new();
  reg_rw_test            reg_rw         = new();
  reg_rs_test            reg_rs         = new();
  reg_reserved_test      reg_rv         = new();
  reg_tsr_test           reg_tsr        = new();
  
  cnt_up_div1_test       cnt_up_1       = new();
  cnt_up_div2_test       cnt_up_2       = new();
  cnt_up_div4_test       cnt_up_4       = new();
  cnt_up_div8_test       cnt_up_8       = new();
  cnt_up_rd_div1_test    cnt_up_rd_1    = new();
  cnt_up_rd_div2_test    cnt_up_rd_2    = new();
  cnt_up_rd_div4_test    cnt_up_rd_4    = new();
  cnt_up_rd_div8_test    cnt_up_rd_8    = new();
  cnt_up_change_test     cnt_up_change  = new();
  
  cnt_dw_div1_test       cnt_dw_1       = new();
  cnt_dw_div2_test       cnt_dw_2       = new();
  cnt_dw_div4_test       cnt_dw_4       = new();
  cnt_dw_div8_test       cnt_dw_8       = new();
  cnt_dw_rd_div1_test    cnt_dw_rd_1    = new();
  cnt_dw_rd_div2_test    cnt_dw_rd_2    = new();
  cnt_dw_rd_div4_test    cnt_dw_rd_4    = new();
  cnt_dw_rd_div8_test    cnt_dw_rd_8    = new();
  cnt_dw_change_test     cnt_dw_change  = new();
  
  cnt_up_dw_test         cnt_up_dw      = new();
  cnt_up_dw_rd_test      cnt_up_dw_rd   = new();
  cnt_dw_up_test         cnt_dw_up      = new();
  cnt_dw_up_rd_test      cnt_dw_up_rd   = new();

  cnt_up_div_1_8_test    cnt_up_div_1_8 = new();
  cnt_up_div_2_8_test    cnt_up_div_2_8 = new();
  cnt_up_div_4_8_test    cnt_up_div_4_8 = new();
  cnt_dw_div_1_8_test    cnt_dw_div_1_8 = new();
  cnt_dw_div_2_8_test    cnt_dw_div_2_8 = new();
  cnt_dw_div_4_8_test    cnt_dw_div_4_8 = new();

  underflow_en_test      under_en       = new();
  underflow_dis_test     under_dis      = new();
  overflow_en_test       over_en        = new();
  overflow_dis_test      over_dis       = new();
  ud_over_en_test        ud_over_en     = new();
  ud_over_dis_test       ud_over_dis    = new();
  initial begin
     if ($test$plusargs("reg_def_test"))
     begin
          base = reg_def;
          $display("%0t: [testbench] Run reg_def_test", $time);
     end
     else if ($test$plusargs("reg_rw_test"))
     begin
          base = reg_rw;
          $display("%0t: [testbench] Run reg_rw_test", $time);
     end
     else if ($test$plusargs("reg_rs_test"))
     begin
          base = reg_rs;
          $display("%0t: [testbench] Run reg_rs_test", $time);
     end
     else if ($test$plusargs("reg_reserved_test"))
     begin
          base = reg_rv;
          $display("%0t: [testbench] Run reg_reserved_test", $time);
     end
     else if ($test$plusargs("reg_tsr_test"))
     begin
          base = reg_tsr;
          $display("%0t: [testbench] Run reg_tsr_test", $time);
     end
     else if ($test$plusargs("cnt_up_div1_test"))
     begin
          base = cnt_up_1;
          $display("%0t: [testbench] Run cnt_up_div1_test", $time);
     end 
     else if ($test$plusargs("cnt_up_div2_test"))
     begin
          base = cnt_up_2;
          $display("%0t: [testbench] Run cnt_up_div2_test", $time);
     end 
     else if ($test$plusargs("cnt_up_div4_test"))
     begin
          base = cnt_up_4;
          $display("%0t: [testbench] Run cnt_up_div4_test", $time);
     end
     else if ($test$plusargs("cnt_up_div8_test"))
     begin
          base = cnt_up_8;
          $display("%0t: [testbench] Run cnt_up_div8_test", $time);
     end
     else if ($test$plusargs("cnt_up_rd_div1_test"))
     begin
          base = cnt_up_rd_1;
          $display("%0t: [testbench] Run cnt_up_rd_div1_test", $time);
     end
     else if ($test$plusargs("cnt_up_rd_div2_test"))
     begin
          base = cnt_up_rd_2;
          $display("%0t: [testbench] Run cnt_up_rd_div2_test", $time);
     end
     else if ($test$plusargs("cnt_up_rd_div4_test"))
     begin
          base = cnt_up_rd_4;
          $display("%0t: [testbench] Run cnt_up_rd_div4_test", $time);
     end
     else if ($test$plusargs("cnt_up_rd_div8_test"))
     begin
          base = cnt_up_rd_8;
          $display("%0t: [testbench] Run cnt_up_rd_div8_test", $time);
     end
     else if ($test$plusargs("cnt_up_change_test"))
     begin
          base = cnt_up_change;
          $display("%0t: [testbench] Run cnt_up_change_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div1_test"))
     begin
          base = cnt_dw_1;
          $display("%0t: [testbench] Run cnt_dw_div1_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div2_test"))
     begin
          base = cnt_dw_2;
          $display("%0t: [testbench] Run cnt_dw_div2_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div4_test"))
     begin
          base = cnt_dw_4;
          $display("%0t: [testbench] Run cnt_dw_div4_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div8_test"))
     begin
          base = cnt_dw_8;
          $display("%0t: [testbench] Run cnt_dw_div8_test", $time);
     end
     else if ($test$plusargs("cnt_dw_rd_div1_test"))
     begin
          base = cnt_dw_rd_1;
          $display("%0t: [testbench] Run cnt_dw_rd_div1_test", $time);
     end
     else if ($test$plusargs("cnt_dw_rd_div2_test"))
     begin
          base = cnt_dw_rd_2;
          $display("%0t: [testbench] Run cnt_dw_rd_div2_test", $time);
     end
     else if ($test$plusargs("cnt_dw_rd_div4_test"))
     begin
          base = cnt_dw_rd_4;
          $display("%0t: [testbench] Run cnt_dw_rd_div4_test", $time);
     end
     else if ($test$plusargs("cnt_dw_rd_div8_test"))
     begin
          base = cnt_dw_rd_8;
          $display("%0t: [testbench] Run cnt_dw_rd_div8_test", $time);
     end
     else if ($test$plusargs("cnt_dw_change_test"))
     begin
          base = cnt_dw_change;
          $display("%0t: [testbench] Run cnt_dw_change_test", $time);
     end
     else if ($test$plusargs("cnt_up_dw_test"))
     begin
          base = cnt_up_dw;
          $display("%0t: [testbench] Run cnt_up_dw_test", $time);
     end
     else if ($test$plusargs("cnt_up_dw_rd_test"))
     begin
          base = cnt_up_dw_rd;
          $display("%0t: [testbench] Run cnt_up_dw_rd_test", $time);
     end
     else if ($test$plusargs("cnt_dw_up_test"))
     begin
          base = cnt_dw_up;
          $display("%0t: [testbench] Run cnt_dw_up_test", $time);
     end
     else if ($test$plusargs("cnt_dw_up_rd_test"))
     begin
          base = cnt_dw_up_rd;
          $display("%0t: [testbench] Run cnt_dw_up_rd_test", $time);
     end
     else if ($test$plusargs("cnt_up_div_1_8_test"))
     begin
          base = cnt_up_div_1_8;
          $display("%0t: [testbench] Run cnt_up_div_1_8_test", $time);
     end
     else if ($test$plusargs("cnt_up_div_2_8_test"))
     begin
          base = cnt_up_div_2_8;
          $display("%0t: [testbench] Run cnt_up_div_2_8_test", $time);
     end
     else if ($test$plusargs("cnt_up_div_4_8_test"))
     begin
          base = cnt_up_div_4_8;
          $display("%0t: [testbench] Run cnt_up_div_4_8_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div_1_8_test"))
     begin
          base = cnt_dw_div_1_8;
          $display("%0t: [testbench] Run cnt_dw_div_1_8_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div_2_8_test"))
     begin
          base = cnt_dw_div_2_8;
          $display("%0t: [testbench] Run cnt_dw_div_2_8_test", $time);
     end
     else if ($test$plusargs("cnt_dw_div_4_8_test"))
     begin
          base = cnt_dw_div_4_8;
          $display("%0t: [testbench] Run cnt_dw_div_4_8_test", $time);
     end
     else if ($test$plusargs("underflow_en_test"))
     begin
          base = under_en;
          $display("%0t: [testbench] Run underflow_en_test", $time);
     end
     else if ($test$plusargs("underflow_dis_test"))
     begin
          base = under_dis;
          $display("%0t: [testbench] Run underflow_dis_test", $time);
     end
     else if ($test$plusargs("overflow_en_test"))
     begin
          base = over_en;
          $display("%0t: [testbench] Run overflow_en_test", $time);
     end
     else if ($test$plusargs("overflow_dis_test"))
     begin
          base = over_dis;
          $display("%0t: [testbench] Run overflow_dis_test", $time);
     end
     else if ($test$plusargs("ud_over_en_test"))
     begin
          base = ud_over_en;
          $display("%0t: [testbench] Run ud_over_en_test", $time);
     end
     else if ($test$plusargs("ud_over_dis_test"))
     begin
          base = ud_over_dis;
          $display("%0t: [testbench] Run ud_over_dis_test", $time);
     end
     base.dut_vif = d_if;
     base.run_test();
  end
  sequence apb_write_sequence;
     d_if.penable##1
     !d_if.psel && !d_if.penable;
  endsequence

  property apb_write_check;
     @(posedge d_if.pclk) d_if.psel && !d_if.penable && d_if.pwrite |=> apb_write_sequence;
  endproperty

  assert property(apb_write_check)
     $display("%0t: [Checker] apb_write_check Passed assertion", $time);
  else
     $display("%0t: [Checker] Failure APB protocol", $time);

  property stable_paddr_pwdata_check;
     @(posedge d_if.pclk) d_if.psel && d_if.penable |-> $stable(d_if.paddr) && $stable(d_if.pwdata);
  endproperty

  assert property(stable_paddr_pwdata_check)
     $display("%0t: [Checker] stable_paddr_pwdata_check Passed assertion", $time);
  else
     $display("%0t: [Checker] Failure stable_paddr_pwdata_check", $time);
endmodule

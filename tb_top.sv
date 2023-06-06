`ifndef TOP
`define TOP

`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;
    

    bit clk, rst = 1;
    always #10 clk = ~clk;

    dut_if dutIf(clk, rst);
    
    Lab1 dut(
        .A(dutIf.A),
        .B(dutIf.B),
        .C(dutIf.C),
        .D(dutIf.D),
        .I(dutIf.if_output));
        
    initial begin
        clk <= 0;
        #50 rst <= 0;
        uvm_config_db#(virtual dut_if)::set(uvm_root::get(),"*","vif",dutIf);
        run_test();
    end

endmodule

`endif 
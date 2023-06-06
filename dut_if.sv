`ifndef DUT_IF
`define DUT_IF

`include "uvm_macros.svh"
import uvm_pkg::*;

interface dut_if(input logic clk,reset);
  
    /*----------------------------------------------------------------------------*/
    // Declaration of Signals
    /*----------------------------------------------------------------------------*/
    logic A,B,C,D;
    logic [2:0] if_output;
    
    /*----------------------------------------------------------------------------*/
    // clocking block and modport declaration for driver 
    /*----------------------------------------------------------------------------*/
    clocking cb_drv @(posedge clk);
        input   A,B,C,D;
        output  if_output;
    endclocking

    modport DRV (clocking cb_drv, input clk, reset);
    /*----------------------------------------------------------------------------*/
    // clocking block and modport declaration for monitor 
    /*----------------------------------------------------------------------------*/
    clocking cb_mnt @(negedge clk);
        input A,B,C,D;
        input if_output;
    endclocking

    modport MNT (clocking cb_mnt, input clk, reset);

endinterface

`endif

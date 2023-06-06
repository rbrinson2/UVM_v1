`ifndef MONITOR 
`define MONITOR

`include "uvm_macros.svh"
import uvm_pkg::*;

class master_monitor extends uvm_monitor;
    /*----------------------------------------------------------------------------*/
    // Declaration of Virtual interface
    /*----------------------------------------------------------------------------*/
    virtual dut_if vif;

    /*----------------------------------------------------------------------------*/
    // Declaration of Analysis ports and exports 
    /*----------------------------------------------------------------------------*/
    uvm_analysis_port #(simple_item) mon2sb_port;

    /*----------------------------------------------------------------------------*/
    // Declaration of transaction item 
    /*----------------------------------------------------------------------------*/
    simple_item act_trans;

    /*----------------------------------------------------------------------------*/
    // Declaration of component  utils 
    /*----------------------------------------------------------------------------*/
    `uvm_component_utils(master_monitor)

    /*----------------------------------------------------------------------------*/
    // Method name : new 
    // Description : constructor
    /*----------------------------------------------------------------------------*/
    function new (string name = "master_monitor", uvm_component parent);
        super.new(name, parent);
        act_trans = new();
        mon2sb_port = new("mon2sb_port", this);
    endfunction : new

    /*----------------------------------------------------------------------------*/
    // Method name : build_phase 
    // Description : construct the components
    /*----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction: build_phase

    /*----------------------------------------------------------------------------*/
    // Method name : run_phase 
    // Description : Extract the info from DUT via interface 
    /*----------------------------------------------------------------------------*/
    virtual task run_phase(uvm_phase phase);
        forever begin
            collect_trans();
            mon2sb_port.write(act_trans);
        end
    endtask : run_phase

    /*----------------------------------------------------------------------------*/
    // Method name : collect_actual_trans 
    // Description : run task for collecting transactions
    /*----------------------------------------------------------------------------*/
    task collect_trans();
        @(cb_mnt);
            act_trans.A <= vif.cb_mnt.A;
            act_trans.B <= vif.cb_mnt.B;
            act_trans.C <= vif.cb_mnt.C;
            act_trans.D <= vif.cb_mnt..D;
            act_trans.si_output <= vif.cb_mnt.if_output;
        `uvm_info(get_full_name(),$sformatf("TRANSACTION FROM MONITOR"),UVM_LOW);
        act_trans.print();
    endtask
     
endclass: master_monitor

`endif 
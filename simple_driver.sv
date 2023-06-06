`ifndef DRIVER
`define DRIVER

`include "uvm_macros.svh"
import uvm_pkg::*;

class simple_driver extends uvm_driver #(simple_item);
    simple_item     s_item;
    virtual dut_if  vif;
    
    // UVM automation macros for general components
    `uvm_component_utils(simple_driver)

    /*----------------------------------------------------------------------------*/
    /*  Constructor                                                               
    /*----------------------------------------------------------------------------*/ 
    function new(string name = "simple_driver", uvm_component parent);
        super.new(name, parent);
    endfunction 


    /*----------------------------------------------------------------------------*/
    /*  Build Phase                                                               
    /*----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        
        string inst_name;

        //Get the resource that defines the virtual interface
        super.build_phase(phase);
            if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface must be set for", get_full_name(), ".vif");
    
    endfunction: build_phase


    /*----------------------------------------------------------------------------*/
    /*  Run Phase                                                                 
    /*----------------------------------------------------------------------------*/
    task run_phase(uvm_phase phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req); //Get the next item from sequencer
            drive_item(); //Execute the item
            `uvm_info(get_full_name(),$sformatf("TRANSACTION FROM DRIVER"),UVM_LOW);
            req.print();
            @(vif.cb_drv);
            $cast(rsp,req.clone());
            rsp.set_id_info(req);
            seq_item_port.item_done(); //Consume the request
            seq_item_port.put(rsp);
        end
    endtask: run_phase
    

    task  drive_item ();
        wait(!vif.rst);
        @(vif.cb_drv)
        vif.cb_drv.A <= s_item.A;
        vif.cb_drv.B <= s_item.B;
        vif.cb_drv.C <= s_item.C;
        vif.cb_drv.D <= s_item.D;
    endtask: drive_item
    
    task reset();
        vif.cb_drv.A <= 0;
        vif.cb_drv.B <= 0;
        vif.cb_drv.C <= 0;
        vif.cb_drv.D <= 0;
    endtask 
endclass: simple_driver

`endif


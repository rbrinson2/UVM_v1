`ifndef AGENT
`define AGENT

`include "uvm_macros.svh"
import uvm_pkg::*;

class simple_agent extends uvm_agent;
  /*----------------------------------------------------------------------------*/
  // Declaration of UVC components such as.. driver,monitor,sequencer..etc
  /*----------------------------------------------------------------------------*/
  simple_driver    driver;
  master_monitor   monitor;

  /*----------------------------------------------------------------------------*/
  // Declaration of component utils 
  /*----------------------------------------------------------------------------*/
  `uvm_component_utils(simple_agent)

  /*----------------------------------------------------------------------------*/
  // Method name : new 
  // Description : constructor
  /*----------------------------------------------------------------------------*/
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  /*----------------------------------------------------------------------------*/
  // Method name : build-phase 
  // Description : construct the components such as.. driver,monitor,sequencer..etc
  /*----------------------------------------------------------------------------*/
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = simple_driver::type_id::create("driver", this);
    sequencer = uvm_sequencer #(simple_item)::type_id::create("sequencer", this);
    monitor = master_monitor::type_id::create("monitor", this);
  endfunction : build_phase

  /*----------------------------------------------------------------------------*/
  // Method name : connect_phase 
  // Description : connect tlm ports ande exports (ex: analysis port/exports) 
  /*----------------------------------------------------------------------------*/
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction : connect_phase
 
endclass : simple_agent

`endif

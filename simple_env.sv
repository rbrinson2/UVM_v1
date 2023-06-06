`ifndef ENV
`define ENV

`include "uvm_macros.svh"
import uvm_pkg::*;
//  Class: simple_env
//
class simple_env extends uvm_env;
    `uvm_component_utils(simple_env)

    simple_agent my_agent;
    simple_scoreboard my_scoreboard;

    
    function new(string name = "simple_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_agent = simple_agent::type_id::create("my_agent", this);
        my_scoreboard = simple_scoreboard::type_id::create("my_scoreboard", this);
                
    endfunction: build_phase
    

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        my_agent.master_monitor.mon2sb_port(my_scoreboard.ap_imp);
        
    endfunction: connect_phase
    
endclass: simple_env

`endif 
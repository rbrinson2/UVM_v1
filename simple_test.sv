`ifndef TEST
`define TEST

`include "uvm_macros.svh"
import uvm_pkg::*;

class simple_test extends uvm_test;
    `uvm_component_utils(simple_test);

    function new(string name = "simple_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    simple_env env;
    virtual dut_if vif;
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        env = simple_env::type_id::create("env", this);
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", vif))
            `uvm_fatal("TEST", "Did not get vif")
            
        uvm_config_db#(virtual dut_if)::set(this, "env.my_agent.*", "dut_if", vif);
        
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        
        simple_item si = simple_item::type_id::create("si");

        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        
        si.start(env.my_agent.sequencer);
    
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: run_phase
    
    
    

    
endclass: simple_test

`endif 
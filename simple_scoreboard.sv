`ifndef SCORE
`define SCORE

`include "uvm_macros.svh"
import uvm_pkg::*;

//  Class: simple_scoreboard
//
class simple_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(simple_scoreboard)

    /*----------------------------------------------------------------------------*/
    //  Constructor: new
    /*----------------------------------------------------------------------------*/
    function new(string name = "simple_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    /*----------------------------------------------------------------------------*/
    // TLM analysis port imp
    /*----------------------------------------------------------------------------*/
    uvm_analysis_port_imp #(simple_item, simple_scoreboard) ap_imp;
    
    /*----------------------------------------------------------------------------*/
    // Method name : build_phase 
    // Description : construct the components
    /*----------------------------------------------------------------------------*/
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp = new("ap_imp", this);       
    endfunction: build_phase

    virtual function void write(simple_item si);
        logic [3:0] temp = {si.A, si.B, si.C, si,D};
        integer count = $countones(temp);
        logic [2:0] expt_out;

        if (count == 0) expt_out = 3'd4;
        else if (count == 1) expt_out = 3'd3;
        else if (count == 2) expt_out = 3'd2;
        else if (count == 3) expt_out = 3'd1;
        else if (count == 4) expt_out = 3'd0;

        if (expt_out != si.si_output) 
            `uvm_error(get_full_name(), "FAIL, the expected output does not match the actual output");
        else if (expt_out == si.si_output)
            `uvm_info(get_full_name(), "PASS, the expected and actual values match", UVM_NONE);
            
    endfunction : write
    
endclass: simple_scoreboard

`endif 
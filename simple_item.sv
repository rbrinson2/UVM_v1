`ifndef ITEM
`define ITEM

`include "uvm_macros.svh"
import uvm_pkg::*;

class simple_item extends uvm_sequence_item;
    `uvm_object_utils(simple_item);
    /*----------------------------------------------------------------------------*/
    /*  Constructor                                                               
    /*----------------------------------------------------------------------------*/
    function new(string name = "simple_item");
        super.new(name);
    endfunction: new

    /*----------------------------------------------------------------------------*/
    /*  Variables                                                                 
    /*----------------------------------------------------------------------------*/
    rand bit A,B,C,D;
    bit [2:0] si_output;

    /*----------------------------------------------------------------------------*/
    /*  Constraints                                                               
    /*----------------------------------------------------------------------------*/
    constraint c1 {{A,B,C,D} inside {[4'h0:4'hF]}};

    /*----------------------------------------------------------------------------*/
    /*  Functions                                                                 
    /*----------------------------------------------------------------------------*/
    function void post_randomize();
    endfunction  

endclass: simple_item

`endif
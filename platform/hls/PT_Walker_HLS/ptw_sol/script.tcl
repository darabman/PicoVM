############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 2013 Xilinx Inc. All rights reserved.
############################################################
open_project PT_Walker_HLS
set_top pt_walker
add_files pt_walker.cpp
add_files pt_walker.h
add_files -tb pt_walker_tb.cpp
open_solution "ptw_sol"
set_part {xc3s500evq100-5}
create_clock -period 20 -name default
source "./PT_Walker_HLS/ptw_sol/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level none
export_design -format ip_catalog -description "An IP generated by Vivado HLS" -vendor "xilinx.com" -library "hls" -version "1.0"

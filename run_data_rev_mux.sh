#!/usr/bin/env bash

# do 'chmod +x latch_sim.sh' on this script to execute it :)

# in case there are already old files: delete them to avoid confusion!
rm out/data_rev_mux
rm out/data_rev_mux.vcd

SRC_LOG="../../clb_components"

iverilog -o out/data_rev_mux data_rev_mux_tb.v data_rev_mux.v
vvp out/data_rev_mux
gtkwave out/data_rev_mux.vcd &

#!/usr/bin/env bash

# do 'chmod +x latch_sim.sh' on this script to execute it :)

# in case there are already old files: delete them to avoid confusion!
rm out/barrel_shifter
rm out/barrel_shifter.vcd

SRC_LOG="../../clb_components"

iverilog -o out/barrel_shifter barrel_shifter_tb.v barrel_shifter.v fmsk.v data_rev_mux.v right_rotator.v
vvp out/barrel_shifter
gtkwave out/barrel_shifter.vcd &

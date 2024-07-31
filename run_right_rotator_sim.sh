#!/usr/bin/env bash

# do 'chmod +x latch_sim.sh' on this script to execute it :)

# in case there are already old files: delete them to avoid confusion!
rm out/right_rotator
rm out/right_rotator.vcd

SRC_LOG="../../clb_components"

iverilog -o out/right_rotator right_rotator_tb.v right_rotator.v
vvp out/right_rotator
gtkwave out/right_rotator.vcd &

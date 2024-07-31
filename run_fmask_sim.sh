#!/usr/bin/env bash

# do 'chmod +x latch_sim.sh' on this script to execute it :)

# in case there are already old files: delete them to avoid confusion!
rm out/fmsk
rm out/fmsk.vcd

SRC_LOG="../../clb_components"

iverilog -o out/fmsk fmsk_tb.v fmsk.v
vvp out/fmsk
gtkwave out/fmsk.vcd &

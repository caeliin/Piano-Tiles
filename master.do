# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in Lab2Part2.v to working dir
# could also have multiple verilog files
vlog Master_Control.v

#load simulation using Lab2Part2 as the top level simulation module
vsim master_control

#log all signals and add some signals to waveform window
log {/*}

# add wave {/*} would add all items in top level simulation module
add wave {/*}

#clock repetition
force {clock} 0 0ns, 1 {1ns} -r 2ns

#base values
force {resetn} 1
force {reset_screen_done} 0
force {draw_done} 0
force {wait_done} 0
force {offset} 100111 

run 5ns

force {resetn} 0

run 5ns 

force {resetn} 1

run 5ns

force {reset_screen_done} 1

run 4ns

force {reset_screen_done} 0

run 5ns

force {draw_done} 1

run 4ns

force {draw_done} 0

run 10ns

force {wait_done} 1

run 4ns

force {wait_done} 0

run 10ns
# =====================================================================
# Hybrid SDC for user_project_wrapper with PicoRV32
# =====================================================================
# Combines:
#   - Base constraints from base_user_proj_example.sdc
#   - PicoRV32-specific clock/reset constraints
#   - Optional Wishbone + Logic Analyzer constraints
# =====================================================================

# ------------------------------
# Clock Definition
# ------------------------------
# Uses Caravel wb_clk_i as the main clock into PicoRV32
create_clock -name clk -period $::env(CLOCK_PERIOD) [get_ports wb_clk_i]
set_propagated_clock [all_clocks]

# Clock uncertainty and transition
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINTY) [get_clocks {clk}]
set_clock_transition  $::env(SYNTH_CLOCK_TRANSITION)  [get_clocks {clk}]

# Optional: Clock latency (can adjust if CTS adds big skew)
#set_clock_latency -source -min 0.2 [get_clocks clk]
#set_clock_latency -source -max 0.5 [get_clocks clk]

# ------------------------------
# Reset Constraints
# ------------------------------
# Hold reset for at least half a cycle relative to clk
set_input_delay [expr $::env(CLOCK_PERIOD) * 0.5] -clock [get_clocks clk] [get_ports wb_rst_i]

# ------------------------------
# PicoRV32-Specific Paths
# ------------------------------
# Example: you can loosen constraints on PicoRV32's instruction/data memory
# paths if connected to LA or stubs.
# (If left unused, just tie them to dummy wires in Verilog.)
# Uncomment/add exceptions if synthesis reports false paths.
#
# set_false_path -through [get_ports {mem_rdata[*]}]
# set_false_path -through [get_ports {mem_addr[*]}]

# ------------------------------
# Wishbone Bus (Optional)
# ------------------------------
# These constraints are from base_user_proj_example.
# Keep them if you want to preserve Wishbone connectivity.
# Comment out if you remove WBS ports from user_project_wrapper.

# Multicycle paths
set_multicycle_path -setup 2 -through [get_ports {wbs_ack_o}]
set_multicycle_path -hold  1 -through [get_ports {wbs_ack_o}]
set_multicycle_path -setup 2 -through [get_ports {wbs_cyc_i}]
set_multicycle_path -hold  1 -through [get_ports {wbs_cyc_i}]
set_multicycle_path -setup 2 -through [get_ports {wbs_stb_i}]
set_multicycle_path -hold  1 -through [get_ports {wbs_stb_i}]

# Input delays (example numbers from base SDC)
set_input_delay -max 3.17 -clock [get_clocks clk] [get_ports {wbs_sel_i[*]}]
set_input_delay -min 1.19 -clock [get_clocks clk] [get_ports {wbs_sel_i[*]}]

# Output delays
set_output_delay -max 3.62 -clock [get_clocks clk] [get_ports {wbs_dat_o[*]}]
set_output_delay -min 1.13 -clock [get_clocks clk] [get_ports {wbs_dat_o[*]}]

# ------------------------------
# Logic Analyzer (Optional)
# ------------------------------
# These help timing analysis if you route PicoRV32 debug signals to LA.
# If unused, you can still keep them — they won’t hurt.

set_input_delay -max 1.87 -clock [get_clocks clk] [get_ports {la_data_in[*]}]
set_input_delay -min 0.18 -clock [get_clocks clk] [get_ports {la_data_in[*]}]

set_output_delay -max 1.0 -clock [get_clocks clk] [get_ports {la_data_out[*]}]
set_output_delay -min 0   -clock [get_clocks clk] [get_ports {la_data_out[*]}]

# ------------------------------
# Miscellaneous Global Constraints
# ------------------------------
set_max_transition $::env(MAX_TRANSITION_CONSTRAINT) [current_design]
set_max_fanout     $::env(MAX_FANOUT_CONSTRAINT) [current_design]

set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late  [expr {1+$::env(SYNTH_TIMING_DERATE)}]

# Apply generic output load assumption
set_load 0.19 [all_outputs]

# =====================================================================
# End of file
# =====================================================================


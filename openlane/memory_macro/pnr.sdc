# ===========================================================================
# Memory Macro SDC with DFFRAM Timing Constraints
# ===========================================================================
# This SDC file includes timing constraints for the memory_macro module
# considering the DFFRAM512x32 timing characteristics.
#
# Design Architecture:
#   memory_macro (this module) --> DFFRAM512x32 (external hard macro)
#   - memory_macro provides arbitration logic between CPU and Wishbone
#   - DFFRAM512x32 is the actual memory storage instantiated at top level
#   - Both operate on the same clock domain
#
# Date: 2024/12/19
# ===========================================================================

#------------------------------------------#
# Clock and Basic Constraints
#------------------------------------------#

set ::env(IO_SYNC) 1

# Clock network
if {[info exists ::env(CLOCK_PORT)] && $::env(CLOCK_PORT) != ""} {
	set clk_input $::env(CLOCK_PORT)
	create_clock [get_ports $clk_input] -name clk -period $::env(CLOCK_PERIOD)
	puts "\[INFO\]: Creating clock {clk} for port $clk_input with period: $::env(CLOCK_PERIOD)"
} else {
	set clk_input __VIRTUAL_CLK__
	create_clock -name clk -period $::env(CLOCK_PERIOD)
	puts "\[INFO\]: Creating virtual clock with period: $::env(CLOCK_PERIOD)"
}

if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL)] } {
	set ::env(SYNTH_CLK_DRIVING_CELL) $::env(SYNTH_DRIVING_CELL)
}
if { ![info exists ::env(SYNTH_CLK_DRIVING_CELL_PIN)] } {
	set ::env(SYNTH_CLK_DRIVING_CELL_PIN) $::env(SYNTH_DRIVING_CELL_PIN)
}

# Clock non-idealities
set_propagated_clock [all_clocks]
set_clock_uncertainty $::env(SYNTH_CLOCK_UNCERTAINTY) [get_clocks {clk}]
puts "\[INFO\]: Setting clock uncertainity to: $::env(SYNTH_CLOCK_UNCERTAINTY)"
set_clock_transition $::env(SYNTH_CLOCK_TRANSITION) [get_clocks {clk}]
puts "\[INFO\]: Setting clock transition to: $::env(SYNTH_CLOCK_TRANSITION)"

# Maximum transition time for the design nets
set_max_transition $::env(MAX_TRANSITION_CONSTRAINT) [current_design]
puts "\[INFO\]: Setting maximum transition to: $::env(MAX_TRANSITION_CONSTRAINT)"

# Maximum fanout
set_max_fanout $::env(MAX_FANOUT_CONSTRAINT) [current_design]
puts "\[INFO\]: Setting maximum fanout to: $::env(MAX_FANOUT_CONSTRAINT)"

# Timing paths delays derate
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"

# Clock source latency
set clk_max_latency 5.57
set clk_min_latency 4.65
set_clock_latency -source -max $clk_max_latency [get_clocks {clk}]
set_clock_latency -source -min $clk_min_latency [get_clocks {clk}]
puts "\[INFO\]: Setting clock latency range: $clk_min_latency : $clk_max_latency"

# Clock input Transition
set clk_tran 0.61
set_input_transition $clk_tran [get_ports $clk_input]
puts "\[INFO\]: Setting clock transition: $clk_tran"

#------------------------------------------#
# Reset Constraints
#------------------------------------------#
set_input_delay [expr $::env(CLOCK_PERIOD) * 0.5] -clock [get_clocks {clk}] [get_ports {rst_n}]

#------------------------------------------#
# CPU Memory Interface Input Constraints
#------------------------------------------#
# Inputs from PicoRV32 SoC to memory_macro
set_input_delay -max 2.0 -clock [get_clocks {clk}] [get_ports {cpu_mem_en}]
set_input_delay -max 2.0 -clock [get_clocks {clk}] [get_ports {cpu_mem_we[*]}]
set_input_delay -max 2.0 -clock [get_clocks {clk}] [get_ports {cpu_mem_addr[*]}]
set_input_delay -max 2.0 -clock [get_clocks {clk}] [get_ports {cpu_mem_wdata[*]}]
set_input_delay -min 0.5 -clock [get_clocks {clk}] [get_ports {cpu_mem_en}]
set_input_delay -min 0.5 -clock [get_clocks {clk}] [get_ports {cpu_mem_we[*]}]
set_input_delay -min 0.5 -clock [get_clocks {clk}] [get_ports {cpu_mem_addr[*]}]
set_input_delay -min 0.5 -clock [get_clocks {clk}] [get_ports {cpu_mem_wdata[*]}]

# Input Transition - CPU Memory Interface
set_input_transition -max 0.5  [get_ports {cpu_mem_en}]
set_input_transition -max 0.5  [get_ports {cpu_mem_we[*]}]
set_input_transition -max 0.5  [get_ports {cpu_mem_addr[*]}]
set_input_transition -max 0.5  [get_ports {cpu_mem_wdata[*]}]
set_input_transition -min 0.1  [get_ports {cpu_mem_en}]
set_input_transition -min 0.1  [get_ports {cpu_mem_we[*]}]
set_input_transition -min 0.1  [get_ports {cpu_mem_addr[*]}]
set_input_transition -min 0.1  [get_ports {cpu_mem_wdata[*]}]

#------------------------------------------#
# Wishbone Slave Interface Constraints
#------------------------------------------#
# Multicycle paths for Wishbone interface (allows 2 cycles for handshake)
set_multicycle_path -setup 2 -through [get_ports {wbs_ack_o}]
set_multicycle_path -hold 1  -through [get_ports {wbs_ack_o}]
set_multicycle_path -setup 2 -through [get_ports {wbs_cyc_i}]
set_multicycle_path -hold 1  -through [get_ports {wbs_cyc_i}]
set_multicycle_path -setup 2 -through [get_ports {wbs_stb_i}]
set_multicycle_path -hold 1  -through [get_ports {wbs_stb_i}]

# Input delays - Wishbone Slave Interface
set_input_delay -max 3.17 -clock [get_clocks {clk}] [get_ports {wbs_sel_i[*]}]
set_input_delay -max 3.74 -clock [get_clocks {clk}] [get_ports {wbs_we_i}]
set_input_delay -max 3.89 -clock [get_clocks {clk}] [get_ports {wbs_adr_i[*]}]
set_input_delay -max 4.13 -clock [get_clocks {clk}] [get_ports {wbs_stb_i}]
set_input_delay -max 4.61 -clock [get_clocks {clk}] [get_ports {wbs_dat_i[*]}]
set_input_delay -max 4.74 -clock [get_clocks {clk}] [get_ports {wbs_cyc_i}]
set_input_delay -min 0.79 -clock [get_clocks {clk}] [get_ports {wbs_adr_i[*]}]
set_input_delay -min 1.04 -clock [get_clocks {clk}] [get_ports {wbs_dat_i[*]}]
set_input_delay -min 1.19 -clock [get_clocks {clk}] [get_ports {wbs_sel_i[*]}]
set_input_delay -min 1.65 -clock [get_clocks {clk}] [get_ports {wbs_we_i}]
set_input_delay -min 1.69 -clock [get_clocks {clk}] [get_ports {wbs_cyc_i}]
set_input_delay -min 1.86 -clock [get_clocks {clk}] [get_ports {wbs_stb_i}]

# Input Transition - Wishbone Slave Interface
set_input_transition -max 0.14  [get_ports {wbs_we_i}]
set_input_transition -max 0.15  [get_ports {wbs_stb_i}]
set_input_transition -max 0.17  [get_ports {wbs_cyc_i}]
set_input_transition -max 0.18  [get_ports {wbs_sel_i[*]}]
set_input_transition -max 0.84  [get_ports {wbs_dat_i[*]}]
set_input_transition -max 0.92  [get_ports {wbs_adr_i[*]}]
set_input_transition -min 0.07  [get_ports {wbs_adr_i[*]}]
set_input_transition -min 0.07  [get_ports {wbs_dat_i[*]}]
set_input_transition -min 0.09  [get_ports {wbs_cyc_i}]
set_input_transition -min 0.09  [get_ports {wbs_sel_i[*]}]
set_input_transition -min 0.09  [get_ports {wbs_we_i}]
set_input_transition -min 0.15  [get_ports {wbs_stb_i}]

# Output delays - Wishbone Slave Interface
set_output_delay -max 3.62 -clock [get_clocks {clk}] [get_ports {wbs_dat_o[*]}]
set_output_delay -max 8.41 -clock [get_clocks {clk}] [get_ports {wbs_ack_o}]
set_output_delay -min 1.13 -clock [get_clocks {clk}] [get_ports {wbs_dat_o[*]}]
set_output_delay -min 1.37 -clock [get_clocks {clk}] [get_ports {wbs_ack_o}]

#===========================================================================
# DFFRAM512x32 INTERFACE TIMING CONSTRAINTS
#===========================================================================
# These constraints are critical for proper timing with the DFFRAM macro.
# They are based on the DFFRAM512x32 characterization data from:
#   ip/DFFRAM512x32/timing/lib/nom/DFFRAM512x32.Typical.lib
#
# DFFRAM512x32 Key Timing Parameters (Typical Corner, 1.6V, 100C):
#   - Setup time (EN0):  3.80ns (rise) / 2.71ns (fall)  
#   - Setup time (A0):   ~3.15-4.21ns (worst case across bits)
#   - Setup time (WE0):  ~3.31-3.80ns
#   - Setup time (Di0):  ~3.31-4.13ns
#   - Hold time (EN0):   -0.12ns (rise) / -0.32ns (fall)
#   - Hold time (A0):    ~-0.09ns to -0.48ns
#   - Hold time (WE0):   ~-0.13ns to -0.38ns  
#   - Hold time (Di0):   ~-0.10ns to -0.33ns
#   - Clock-to-Q (Do0):  ~12.9-13.7ns (typical)
#
# Note: DFFRAM is a synchronous memory operating on the same clock as
# memory_macro, so we use output_delay constraints to model the setup/hold
# requirements at the DFFRAM inputs, and input_delay for the DFFRAM outputs.
#---------------------------------------------------------------------------

puts "\[INFO\]: =============================================="
puts "\[INFO\]: Applying DFFRAM512x32 Timing Constraints"
puts "\[INFO\]: =============================================="

#------------------------------------------#
# Memory Interface OUTPUT Constraints
# (memory_macro outputs → DFFRAM inputs)
#------------------------------------------#

# DFFRAM Enable (EN0) - Controls memory access
# Setup: 3.80ns (rise), 2.71ns (fall) - use worst case 3.80ns
# Hold: -0.32ns (most negative) - this is negative, meaning data can change
# slightly before clock edge
set dffram_en_setup 3.80
set dffram_en_hold  0.32

set_output_delay -max $dffram_en_setup -clock [get_clocks {clk}] [get_ports {mem_en}]
set_output_delay -min [expr -1 * $dffram_en_hold] -clock [get_clocks {clk}] [get_ports {mem_en}]
puts "\[INFO\]: DFFRAM EN0: setup=$dffram_en_setup ns, hold=$dffram_en_hold ns"

# DFFRAM Write Enable (WE0) - Byte-wise write enable
# Setup: worst case ~3.80ns across all WE bits
# Hold: worst case ~0.38ns  
set dffram_we_setup 3.80
set dffram_we_hold  0.38

set_output_delay -max $dffram_we_setup -clock [get_clocks {clk}] [get_ports {mem_we[*]}]
set_output_delay -min [expr -1 * $dffram_we_hold] -clock [get_clocks {clk}] [get_ports {mem_we[*]}]
puts "\[INFO\]: DFFRAM WE0: setup=$dffram_we_setup ns, hold=$dffram_we_hold ns"

# DFFRAM Address (A0) - 9-bit address bus
# Setup: worst case 4.21ns (from A0[6])
# Hold: worst case 0.49ns (from A0[7])
set dffram_addr_setup 4.21
set dffram_addr_hold  0.49

set_output_delay -max $dffram_addr_setup -clock [get_clocks {clk}] [get_ports {mem_addr[*]}]
set_output_delay -min [expr -1 * $dffram_addr_hold] -clock [get_clocks {clk}] [get_ports {mem_addr[*]}]
puts "\[INFO\]: DFFRAM A0: setup=$dffram_addr_setup ns, hold=$dffram_addr_hold ns"

# DFFRAM Write Data (Di0) - 32-bit data input
# Setup: worst case ~4.13ns across all data bits
# Hold: worst case ~0.33ns
set dffram_wdata_setup 4.13
set dffram_wdata_hold  0.33

set_output_delay -max $dffram_wdata_setup -clock [get_clocks {clk}] [get_ports {mem_wdata[*]}]
set_output_delay -min [expr -1 * $dffram_wdata_hold] -clock [get_clocks {clk}] [get_ports {mem_wdata[*]}]
puts "\[INFO\]: DFFRAM Di0: setup=$dffram_wdata_setup ns, hold=$dffram_wdata_hold ns"

#------------------------------------------#
# Memory Interface INPUT Constraints
# (DFFRAM outputs → memory_macro inputs)
#------------------------------------------#

# DFFRAM Read Data (Do0) - 32-bit data output
# Clock-to-Q: worst case ~13.7ns for typical corner
# For pessimistic analysis, add some margin for slower corners
# The input delay models when data arrives relative to the clock edge
set dffram_rdata_clk2q_max 14.0
set dffram_rdata_clk2q_min 12.5

set_input_delay -max $dffram_rdata_clk2q_max -clock [get_clocks {clk}] [get_ports {mem_rdata[*]}]
set_input_delay -min $dffram_rdata_clk2q_min -clock [get_clocks {clk}] [get_ports {mem_rdata[*]}]
puts "\[INFO\]: DFFRAM Do0: clk-to-q max=$dffram_rdata_clk2q_max ns, min=$dffram_rdata_clk2q_min ns"

# DFFRAM output transition times (based on lib file)
# Rise/fall transitions are in the 0.02-0.03ns range typically
set_input_transition -max 0.5 [get_ports {mem_rdata[*]}]
set_input_transition -min 0.1 [get_ports {mem_rdata[*]}]

#------------------------------------------#
# CPU Memory Read Data Output Constraints  
#------------------------------------------#
# This is the path from memory_macro back to the PicoRV32 SoC
# Constrain based on what the CPU expects
set_output_delay -max 2.0 -clock [get_clocks {clk}] [get_ports {cpu_mem_rdata[*]}]
set_output_delay -min 0.5 -clock [get_clocks {clk}] [get_ports {cpu_mem_rdata[*]}]

#------------------------------------------#
# Output Load Assumptions
#------------------------------------------#
# Standard output load for all outputs
set_load 0.19 [all_outputs]

#===========================================================================
# Optional: False Path / Multicycle Analysis
#===========================================================================
# If needed, add false path or multicycle path constraints here.
# For example, if the memory read path needs 2 cycles:
# set_multicycle_path -setup 2 -from [get_ports {mem_rdata[*]}] -to [get_ports {cpu_mem_rdata[*]}]
# set_multicycle_path -hold 1  -from [get_ports {mem_rdata[*]}] -to [get_ports {cpu_mem_rdata[*]}]

puts "\[INFO\]: =============================================="
puts "\[INFO\]: Memory Macro SDC with DFFRAM timing complete"
puts "\[INFO\]: =============================================="

# ===========================================================================
# End of SDC
# ===========================================================================


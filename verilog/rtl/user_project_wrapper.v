// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

    // Memory Interface Signals
    wire mem_en;
    wire [3:0] mem_we;
    wire [8:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [31:0] mem_rdata;
    
    // UART Interface - pass GPIO signals directly to SoC macro
    // SoC macro will handle GPIO connections internally

// Memory Macro with Arbitration (Pre-hardened Macro)
memory_macro u_memory (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),	// User area 1 1.8V power
    .vssd1(vssd1),	// User area 1 digital ground
`endif
    .clk(wb_clk_i),
    .rst_n(wb_rst_i),
    
    // CPU Memory Interface (to PicoRV32 SoC)
    .cpu_mem_en(mem_en),
    .cpu_mem_we(mem_we),
    .cpu_mem_addr(mem_addr),
    .cpu_mem_wdata(mem_wdata),
    .cpu_mem_rdata(mem_rdata),
    
    // External Wishbone Slave Interface (for programming)
    .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_dat_o(wbs_dat_o)
);

// PicoRV32 SoC Wrapper (Pre-hardened Macro)
picorv32_soc u_soc (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),	// User area 1 1.8V power
    .vssd1(vssd1),	// User area 1 digital ground
`endif
    .clk(wb_clk_i),
    .rst_n(wb_rst_i),
    
    // External Wishbone Slave Interface (unused - handled by memory macro)
    .wbs_stb_i(1'b0),
    .wbs_cyc_i(1'b0),
    .wbs_we_i(1'b0),
    .wbs_sel_i(4'h0),
    .wbs_adr_i(32'h0),
    .wbs_dat_i(32'h0),
    .wbs_ack_o(),  // Unused
    .wbs_dat_o(),  // Unused
    
    // Memory Interface (to memory macro)
    .mem_en(mem_en),
    .mem_we(mem_we),
    .mem_addr(mem_addr),
    .mem_wdata(mem_wdata),
    .mem_rdata(mem_rdata),
    
    // GPIO Interface (for UART connection)
    .io_out(io_out),
    .io_in(io_in),
    .io_oeb(io_oeb),
    
    // Interrupts
    .irq_out(user_irq)
);

endmodule

`default_nettype wire

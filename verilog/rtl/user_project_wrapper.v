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

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

    //Intermediate signals
//    wire [31:0] mem_rdata  = la_data_in[31:0];
//    wire [31:0] mem_wdata  = la_data_in[63:32];
//    wire [31:0] mem_addr   = la_data_in[95:64];
//    wire [31:0] pcpi_rs1   = la_data_in[127:96];

// Memory interface
wire [31:0] mem_rdata;    // unused
wire [31:0] mem_wdata;    // unused
wire [31:0] mem_addr;     // unused
wire mem_valid;           // unused
wire mem_ready;           // unused
wire mem_instr;           // unused
wire [31:0] mem_la_addr;  // unused
wire mem_la_read;         // unused
wire [31:0] mem_la_wdata; // unused
wire mem_la_write;        // unused
wire [3:0] mem_la_wstrb;  // unused

// PCPI interface
wire [31:0] pcpi_insn;    // unused
wire [31:0] pcpi_rs1;     // unused
wire [31:0] pcpi_rs2;     // unused
wire [31:0] pcpi_rd;      // unused
wire pcpi_wait;           // unused
wire pcpi_ready;          // unused
wire pcpi_wr;             // unused

// IRQ/Eoi/trace
wire [31:0] eoi;          // unused
wire [31:0] irq;          // unused
wire [35:0] trace_data;   // unused
wire trap;                // unused

picorv32 u_picorv32 (

`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .clk         (wb_clk_i),
    .resetn      (wb_rst_i),
    .trap        (trap),
    .mem_instr   (mem_instr),
    .mem_la_read (mem_la_read),
    .mem_la_write(mem_la_write),
    .mem_ready   (mem_ready),
    .mem_valid   (mem_valid),
    .mem_addr    (mem_addr),
    .mem_wdata   (mem_wdata),
    .mem_wstrb   (mem_wstrb),
    .mem_rdata   (mem_rdata),
    .mem_la_addr (mem_la_addr),
    .mem_la_wdata(mem_la_wdata),
    .mem_la_wstrb(mem_la_wstrb),
    .pcpi_ready  (pcpi_ready),
    .pcpi_valid  (pcpi_valid),
    .pcpi_wait   (pcpi_wait),
    .pcpi_wr     (pcpi_wr),
    .pcpi_insn   (pcpi_insn),
    .pcpi_rd     (pcpi_rd),
    .pcpi_rs1    (pcpi_rs1),
    .pcpi_rs2    (pcpi_rs2),
    .trace_valid (trace_valid),
    .trace_data  (trace_data),
    .eoi         (eoi),
);
endmodule

`default_nettype wire

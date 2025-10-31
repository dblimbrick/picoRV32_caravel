// SPDX-FileCopyrightText: 2024 PicoRV32 Caravel Project
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
 * PicoRV32 System-on-Chip (SoC) Wrapper
 * 
 * This module provides a complete SoC with:
 * - PicoRV32 processor with Wishbone interface
 * - DFFRAM512x32 memory block
 * - Simple UART for communication
 * - Wishbone slave interface for external programming
 * - Memory-mapped I/O peripherals
 */

module picorv32_soc #(
    parameter CLK_FREQ = 40000000,
    parameter UART_BAUD = 115200
) (
`ifdef USE_POWER_PINS
    inout vccd1,        // User area 1 1.8V supply
    inout vssd1,        // User area 1 digital ground
`endif

    // System signals
    input wire clk,
    input wire rst_n,
    
    // Wishbone Slave Interface (for programming)
    input wire wbs_stb_i,
    input wire wbs_cyc_i,
    input wire wbs_we_i,
    input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_adr_i,
    input wire [31:0] wbs_dat_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
    
    // Memory Interface (to external memory macro)
    output wire mem_en,
    output wire [3:0] mem_we,
    output wire [8:0] mem_addr,
    output wire [31:0] mem_wdata,
    input wire [31:0] mem_rdata,
    
    // UART Interface - connected directly to GPIO
    // uart_tx -> io_out[20], uart_rx -> io_in[21]
    
    // GPIO Interface (for UART connection)
    output wire [37:0] io_out,
    input wire [37:0] io_in,
    output wire [37:0] io_oeb,
    
    // Interrupts
    output wire [2:0] irq_out
);

    // Memory and peripheral address mapping (RISC-V standard)
    localparam MEM_BASE = 32'h00000000;  // Standard RISC-V memory base
    localparam MEM_SIZE = 32'h00000800;  // 2KB (512 words × 32 bits)
    localparam UART_BASE = 32'h00002000;
    localparam UART_SIZE = 32'h00001000;  // 4KB
    localparam GPIO_BASE = 32'h00003000;
    localparam GPIO_SIZE = 32'h00001000;  // 4KB
    
    // Internal signals
    wire wbm_stb_o, wbm_cyc_o, wbm_we_o;
    wire [31:0] wbm_adr_o, wbm_dat_o;
    wire [3:0] wbm_sel_o;
    wire wbm_ack_i;
    wire [31:0] wbm_dat_i;
    
    // Interrupt signals
    wire [31:0] cpu_irq;
    
    // PicoRV32 with Wishbone interface
    picorv32_wb u_picorv32 (
        .wb_clk_i(clk),
        .wb_rst_i(~rst_n),
        .trap(),
        
        // Wishbone master interface
        .wbm_adr_o(wbm_adr_o),
        .wbm_dat_o(wbm_dat_o),
        .wbm_dat_i(wbm_dat_i),
        .wbm_we_o(wbm_we_o),
        .wbm_sel_o(wbm_sel_o),
        .wbm_stb_o(wbm_stb_o),
        .wbm_ack_i(wbm_ack_i),
        .wbm_cyc_o(wbm_cyc_o),
        
        // PCPI interface (unused)
        .pcpi_valid(),
        .pcpi_insn(),
        .pcpi_rs1(),
        .pcpi_rs2(),
        .pcpi_wr(1'b0),
        .pcpi_rd(32'h0),
        .pcpi_wait(1'b0),
        .pcpi_ready(1'b0),
        
        // IRQ interface
        .irq(cpu_irq),
        .eoi()
    );
    
    // Wishbone interconnect
    wire mem_access = wbm_stb_o && wbm_cyc_o && 
                     (wbm_adr_o >= MEM_BASE) && 
                     (wbm_adr_o < MEM_BASE + MEM_SIZE);
    
    wire uart_access = wbm_stb_o && wbm_cyc_o && 
                      (wbm_adr_o >= UART_BASE) && 
                      (wbm_adr_o < UART_BASE + UART_SIZE);
    
    wire gpio_access = wbm_stb_o && wbm_cyc_o && 
                      (wbm_adr_o >= GPIO_BASE) && 
                      (wbm_adr_o < GPIO_BASE + GPIO_SIZE);
    
    // Memory interface - direct connection to external memory macro
    assign mem_en = mem_access;
    assign mem_we = wbm_we_o ? wbm_sel_o : 4'h0;
    assign mem_addr = wbm_adr_o[10:2];  // Convert byte address to word address
    assign mem_wdata = wbm_dat_o;
    
    // GPIO connections for UART
    // UART TX is connected directly to io_out[20] via CF_UART
    // UART RX is connected directly to io_in[21] via CF_UART
    assign io_oeb[20] = 1'b0;     // GPIO 20 output enable
    assign io_oeb[21] = 1'b1;     // GPIO 21 input enable
    
    // All other GPIO pins default to input (no output driver)
    assign io_out[37:22] = 38'h0;  // GPIO 22-37 no output
    assign io_out[21] = 1'b0;      // GPIO 21 no output (UART RX input)
    assign io_out[19:0] = 20'h0;   // GPIO 0-19 no output
    assign io_oeb[37:22] = 38'h3FFFFFFF;  // GPIO 22-37 input enable
    assign io_oeb[19:0] = 20'hFFFFF;      // GPIO 0-19 input enable
    
    // UART interface
    wire uart_stb, uart_cyc, uart_we;
    wire [31:0] uart_adr, uart_dat_o, uart_dat_i;
    wire [3:0] uart_sel;
    wire uart_ack;
    wire uart_irq;
    
    // GPIO interface
    wire gpio_stb, gpio_cyc, gpio_we;
    wire [31:0] gpio_adr, gpio_dat_o, gpio_dat_i;
    wire [3:0] gpio_sel;
    wire gpio_ack;
    
    // UART interface
    assign uart_stb = uart_access;
    assign uart_cyc = uart_access;
    assign uart_we = wbm_we_o;
    assign uart_adr = wbm_adr_o;
    assign uart_dat_i = wbm_dat_o;
    assign uart_sel = wbm_sel_o;
    
    // GPIO interface (placeholder)
    assign gpio_stb = gpio_access;
    assign gpio_cyc = gpio_access;
    assign gpio_we = wbm_we_o;
    assign gpio_adr = wbm_adr_o;
    assign gpio_dat_i = wbm_dat_o;
    assign gpio_sel = wbm_sel_o;
    
    // Wishbone response
    assign wbm_dat_i = mem_access ? mem_rdata :
                       uart_access ? uart_dat_o :
                       gpio_access ? gpio_dat_o :
                       32'h0;
    
    assign wbm_ack_i = mem_access || uart_ack || gpio_ack;
    
    // CF_UART Wishbone Interface
    CF_UART_WB u_uart (
        .clk_i(clk),
        .rst_i(~rst_n),
        .adr_i(uart_adr),
        .dat_i(uart_dat_i),
        .dat_o(uart_dat_o),
        .sel_i(uart_sel),
        .cyc_i(uart_cyc),
        .stb_i(uart_stb),
        .ack_o(uart_ack),
        .we_i(uart_we),
        .IRQ(uart_irq),
        .rx(io_in[21]),  // UART RX from GPIO 21
        .tx(io_out[20])  // UART TX to GPIO 20
    );
    
    // Memory is external to SoC wrapper - no internal memory instantiation
    
    // GPIO placeholder (simple register for now)
    reg [31:0] gpio_data;
    assign gpio_dat_o = gpio_data;
    assign gpio_ack = gpio_stb && gpio_cyc;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            gpio_data <= 32'h0;
        end else if (gpio_stb && gpio_cyc && gpio_we) begin
            gpio_data <= gpio_dat_i;
        end
    end
    
    // External Wishbone Slave Interface (for programming memory)
    // This is now handled by the memory macro
    assign wbs_ack_o = 1'b0;  // Not used in SoC anymore
    assign wbs_dat_o = 32'h0; // Not used in SoC anymore
    
    // Interrupt handling
    assign cpu_irq = {30'h0, uart_irq, 1'b0};  // UART IRQ on bit 1
    assign irq_out = {1'b0, uart_irq, 1'b0};

endmodule

`default_nettype wire

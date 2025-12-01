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
 * Memory Arbitration Logic
 * 
 * This module provides memory arbitration between CPU and external Wishbone slave:
 * - Memory arbitration between CPU and external Wishbone slave
 * - CPU has priority access to memory
 * - External Wishbone slave can program memory when CPU is idle
 * 
 * Note: DFFRAM512x32 is instantiated at the top level (user_project_wrapper)
 * to avoid met4 power strap conflicts during hardening.
 */

module memory_macro #(
    parameter MEM_SIZE = 512  // 512 words × 32 bits = 2KB
) (
    // System signals
    input wire clk,
    input wire rst_n,
    
    // CPU Memory Interface (from PicoRV32 SoC)
    input wire cpu_mem_en,
    input wire [3:0] cpu_mem_we,
    input wire [8:0] cpu_mem_addr,
    input wire [31:0] cpu_mem_wdata,
    output wire [31:0] cpu_mem_rdata,
    
    // External Wishbone Slave Interface (for programming)
    input wire wbs_stb_i,
    input wire wbs_cyc_i,
    input wire wbs_we_i,
    input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_adr_i,
    input wire [31:0] wbs_dat_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
    
    // Memory Interface (to external DFFRAM512x32)
    output wire mem_en,
    output wire [3:0] mem_we,
    output wire [8:0] mem_addr,
    output wire [31:0] mem_wdata,
    input wire [31:0] mem_rdata
);

    // Memory address mapping (RISC-V standard)
    localparam MEM_BASE = 32'h00000000;  // Standard RISC-V memory base
    localparam MEM_ADDR_MASK = 32'h000007FF;  // 2KB mask (512 words)
    
    // External Wishbone access detection
    wire ext_mem_access = wbs_stb_i && wbs_cyc_i && 
                         (wbs_adr_i >= MEM_BASE) && 
                         (wbs_adr_i < MEM_BASE + (MEM_SIZE * 4));  // Convert words to bytes
    
    // Memory arbitration between CPU and external Wishbone master
    // CPU has priority access to memory
    wire cpu_access = cpu_mem_en;
    wire ext_access = ext_mem_access && !cpu_access;  // Only when CPU not accessing
    
    // Convert external byte address to word address
    wire [8:0] ext_mem_addr = wbs_adr_i[10:2];  // Convert byte address to word address
    wire [31:0] ext_mem_wdata = wbs_dat_i;
    wire [3:0] ext_mem_we = wbs_we_i ? wbs_sel_i : 4'h0;
    
    // Memory interface signals (to external DFFRAM)
    assign mem_en = cpu_access || ext_access;
    assign mem_we = cpu_access ? cpu_mem_we : ext_mem_we;
    assign mem_addr = cpu_access ? cpu_mem_addr : ext_mem_addr;
    assign mem_wdata = cpu_access ? cpu_mem_wdata : ext_mem_wdata;
    
    // CPU memory read data
    assign cpu_mem_rdata = mem_rdata;
    
    // External Wishbone response
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wbs_ack_o <= 1'b0;
            wbs_dat_o <= 32'h0;
        end else begin
            wbs_ack_o <= wbs_stb_i && wbs_cyc_i;
            if (ext_mem_access) begin
                wbs_dat_o <= mem_rdata;  // Read from memory
            end else begin
                wbs_dat_o <= 32'h0;
            end
        end
    end

endmodule

`default_nettype wire

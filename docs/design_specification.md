# PicoRV32 SoC Caravel User Project Design Specification

## Table of Contents
1. [Design Overview](#design-overview)
2. [System Architecture](#system-architecture)
3. [PicoRV32 SoC Wrapper](#picorv32-soc-wrapper)
4. [PicoRV32 Core Specifications](#picorv32-core-specifications)
5. [DFFRAM512x32 Memory Block](#dffram512x32-memory-block)
6. [CF_UART Communication Interface](#cf_uart-communication-interface)
7. [System Integration](#system-integration)
8. [Physical Design Specifications](#physical-design-specifications)
9. [Timing and Performance](#timing-and-performance)
10. [Pin Configuration](#pin-configuration)
11. [Power Management](#power-management)

## Design Overview

This document specifies the design of a complete System-on-Chip (SoC) implementation using the PicoRV32 core integrated within the Caravel user project wrapper. The design includes a custom DFFRAM512x32 memory block for instruction and data storage, a CF_UART communication interface, and a Wishbone slave interface for external programming, creating a complete microcontroller system suitable for embedded applications.

### Key Features
- **RISC-V RV32I Instruction Set Architecture (ISA)**
- **512-word × 32-bit DFFRAM memory block**
- **CF_UART with FIFO support and interrupt capabilities**
- **Wishbone slave interface for memory programming**
- **Caravel-compatible user project wrapper**
- **GPIO interface for I/O operations**
- **Memory-mapped peripheral access**

## System Architecture

The system consists of a complete SoC integrated within the Caravel user project wrapper:

```
┌─────────────────────────────────────────────────────────────┐
│                    Caravel User Project Wrapper            │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │              PicoRV32 SoC Wrapper                       │ │
│  │  ┌─────────────┐  ┌─────────────────┐                    │ │
│  │  │ PicoRV32    │  │ CF_UART         │                    │ │
│  │  │ Core        │  │ Interface       │                    │ │
│  │  │ (Wishbone)  │  │ (Wishbone)      │                    │ │
│  │  └─────────────┘  └─────────────────┘                    │ │
│  │           │              │                               │ │
│  │           └──────────────┘                               │ │
│  │                          │                               │ │
│  │  ┌───────────────────────▼─────────────────────────────┐ │ │
│  │  │           Internal Wishbone Bus                     │ │ │
│  │  │           (Memory + Peripheral Access)              │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  └─────────────────────────────────────────────────────────┘ │
│           │                    │                    │      │
│           └────────────────────┼────────────────────┘      │
│                                │                           │
│  ┌─────────────────────────────▼─────────────────────────┐  │
│  │              Memory Macro with Arbitration             │  │
│  │  ┌─────────────────┐  ┌─────────────────────────────┐ │  │
│  │  │ DFFRAM512x32    │  │ Memory Arbitration Logic      │ │  │
│  │  │ Memory          │  │ (CPU Priority + External)    │ │  │
│  │  │ (512 words ×    │  │                             │ │  │
│  │  │ 32 bits = 2KB)  │  │                             │ │  │
│  │  └─────────────────┘  └─────────────────────────────┘ │  │
│  └─────────────────────────────────────────────────────┘  │
│                                │                           │
│  ┌─────────────────────────────▼─────────────────────────┐  │
│  │              External Wishbone Slave Interface         │  │
│  │              (for memory programming)                   │  │
│  └─────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Component Relationships
- **PicoRV32 SoC Wrapper**: System integration layer with Wishbone interconnect
- **PicoRV32 Core**: Main processor with Wishbone master interface
- **Memory Macro**: Complete memory subsystem with DFFRAM512x32 and arbitration logic
- **DFFRAM512x32**: Primary memory (512 words × 32 bits = 2KB) within memory macro
- **Memory Arbitration**: Handles CPU priority access and external Wishbone slave access
- **CF_UART**: Full-featured UART with FIFO and interrupt support, connected via Wishbone
- **User Project Wrapper**: Caravel-compatible interface providing:
  - Memory macro with integrated arbitration
  - PicoRV32 SoC wrapper
  - External Wishbone slave interface for memory programming
  - Logic analyzer signals for debugging
  - GPIO pins for I/O operations
  - Power and ground connections

## PicoRV32 SoC Wrapper

The SoC wrapper (`picorv32_soc.v`) provides a system integration layer that includes:

### Memory Map
| Address Range | Peripheral | Description |
|---------------|------------|-------------|
| 0x00000000 - 0x000007FF | DFFRAM512x32 | 2KB instruction/data memory (512 words × 32 bits) |
| 0x00002000 - 0x00002FFF | CF_UART | UART registers and FIFO |
| 0x00003000 - 0x00003FFF | GPIO | General purpose I/O (placeholder) |

### Wishbone Interconnect
- **Internal Wishbone Master**: PicoRV32 core accesses memory and peripherals
- **Memory Interface**: Direct memory access via dedicated signals
- **Peripheral Access**: UART and GPIO accessed via Wishbone bus
- **Address Decoding**: Routes transactions to appropriate peripherals
- **Interrupt Handling**: Manages UART and other peripheral interrupts

### Key Features
- **Standard RISC-V Memory Map**: Memory starts at 0x00000000
- **Direct Memory Access**: CPU accesses memory via dedicated interface
- **Peripheral Integration**: UART, GPIO, and future peripherals via Wishbone
- **Interrupt Management**: Centralized interrupt handling
- **Clock Domain**: Single clock domain operation

## PicoRV32 Core Specifications

### Architecture
- **ISA**: RISC-V RV32I (32-bit integer base instruction set)
- **Data Width**: 32-bit
- **Address Width**: 32-bit
- **Pipeline**: Single-cycle execution
- **Register File**: 32 × 32-bit registers (x0-x31)

### Configuration Parameters
The PicoRV32 core is configured with the following parameters:

| Parameter | Value | Description |
|-----------|-------|-------------|
| ENABLE_COUNTERS | 1 | Enable cycle counter |
| ENABLE_COUNTERS64 | 1 | Enable 64-bit cycle counter |
| ENABLE_REGS_16_31 | 1 | Enable registers x16-x31 |
| ENABLE_REGS_DUALPORT | 1 | Enable dual-port register file |
| ENABLE_IRQ | 0 | Disable interrupt support |
| ENABLE_MUL | 0 | Disable hardware multiplication |
| ENABLE_DIV | 0 | Disable hardware division |
| ENABLE_PCPI | 0 | Disable PCPI interface |
| COMPRESSED_ISA | 0 | Disable compressed instructions |

### Memory Interface
- **Instruction Memory**: Connected to DFFRAM512x32
- **Data Memory**: Shared with instruction memory
- **Memory Width**: 32-bit
- **Address Range**: 0x00000000 - 0x000007FF (2KB, 512 words × 32 bits)

### Control Signals
- **Clock**: `wb_clk_i` (from Wishbone interface)
- **Reset**: `wb_rst_i` (active low)
- **Trap**: Unconnected (for future use)
- **Interrupt**: Connected to logic analyzer signals

## Memory Macro with Arbitration

The memory macro (`memory_macro.v`) provides a complete memory subsystem that includes:

### Architecture
- **DFFRAM512x32 Memory**: 512 words × 32 bits = 2KB of instruction/data memory
- **Memory Arbitration**: Handles access between CPU and external Wishbone slave
- **CPU Priority**: PicoRV32 CPU has priority access to memory
- **External Access**: Caravel management core can program memory when CPU is idle

### Interface Signals
| Signal | Direction | Width | Description |
|--------|-----------|-------|-------------|
| clk | Input | 1 | Clock signal |
| rst_n | Input | 1 | Reset signal (active low) |
| cpu_mem_en | Input | 1 | CPU memory enable |
| cpu_mem_we | Input | 4 | CPU write enable (byte-wise) |
| cpu_mem_addr | Input | 9 | CPU address bus |
| cpu_mem_wdata | Input | 32 | CPU write data |
| cpu_mem_rdata | Output | 32 | CPU read data |
| wbs_stb_i | Input | 1 | Wishbone slave strobe |
| wbs_cyc_i | Input | 1 | Wishbone slave cycle |
| wbs_we_i | Input | 1 | Wishbone slave write enable |
| wbs_sel_i | Input | 4 | Wishbone slave byte select |
| wbs_adr_i | Input | 32 | Wishbone slave address |
| wbs_dat_i | Input | 32 | Wishbone slave write data |
| wbs_ack_o | Output | 1 | Wishbone slave acknowledge |
| wbs_dat_o | Output | 32 | Wishbone slave read data |

### Memory Arbitration Logic
- **CPU Access**: Direct memory interface from PicoRV32 SoC
- **External Access**: Wishbone slave interface for memory programming
- **Priority**: CPU has priority, external access only when CPU is idle
- **Address Mapping**: Standard RISC-V memory map (0x00000000 - 0x000007FF)

## DFFRAM512x32 Memory Block

### Specifications
- **Capacity**: 512 words × 32 bits = 16,384 bits (2KB)
- **Organization**: Single-port synchronous RAM
- **Data Width**: 32 bits
- **Address Width**: 9 bits (512 addresses)
- **Technology**: Custom DFFRAM implementation

### Interface Signals
| Signal | Direction | Width | Description |
|--------|-----------|-------|-------------|
| CLK | Input | 1 | Clock signal |
| EN0 | Input | 1 | Enable signal |
| WE0 | Input | 4 | Write enable (byte-wise) |
| A0 | Input | 9 | Address bus |
| Di0 | Input | 32 | Data input |
| Do0 | Output | 32 | Data output |
| VPWR | Input | 1 | Power supply |
| VGND | Input | 1 | Ground |

### Memory Mapping
- **Address Range**: 0x00000000 - 0x000007FF (512 words)
- **Word Size**: 32 bits
- **Byte Addressing**: Supported via write enable signals
- **Access Type**: Synchronous read/write

## CF_UART Communication Interface

The CF_UART provides a full-featured UART interface with advanced capabilities:

### Specifications
- **Data Format**: Configurable 5-9 data bits
- **Parity**: None, odd, even, or sticky parity
- **Stop Bits**: 1 or 2 stop bits
- **FIFO Depth**: 16-byte TX and RX FIFOs
- **Baud Rate**: Programmable via 16-bit prescaler
- **Interrupts**: 10 interrupt sources

### Key Features
- **FIFO Support**: 16-byte TX/RX FIFOs with programmable thresholds
- **Error Detection**: Framing, parity, overrun, and timeout errors
- **Advanced Features**: Line break detection, data matching, loopback mode
- **Glitch Filter**: Configurable RX glitch filtering
- **Clock Gating**: Power management support

### Register Map
| Offset | Register | Access | Description |
|--------|----------|--------|-------------|
| 0x0000 | RXDATA | R | Receive data register |
| 0x0004 | TXDATA | W | Transmit data register |
| 0x0008 | PR | W | Prescaler register (baud rate) |
| 0x000C | CTRL | W | Control register |
| 0x0010 | CFG | W | Configuration register |
| 0x001C | MATCH | W | Match data register |
| 0xFE00 | RX_FIFO_LEVEL | R | RX FIFO level |
| 0xFE04 | RX_FIFO_THRESHOLD | W | RX FIFO threshold |
| 0xFE08 | RX_FIFO_FLUSH | W | RX FIFO flush |
| 0xFE10 | TX_FIFO_LEVEL | R | TX FIFO level |
| 0xFE14 | TX_FIFO_THRESHOLD | W | TX FIFO threshold |
| 0xFE18 | TX_FIFO_FLUSH | W | TX FIFO flush |
| 0xFF00 | IM | W | Interrupt mask |
| 0xFF04 | MIS | R | Masked interrupt status |
| 0xFF08 | RIS | R | Raw interrupt status |
| 0xFF0C | IC | W | Interrupt clear |

### Interrupt Sources
| Bit | Flag | Description |
|-----|------|-------------|
| 0 | TXE | Transmit FIFO empty |
| 1 | RXF | Receive FIFO full |
| 2 | TXB | Transmit FIFO below threshold |
| 3 | RXA | Receive FIFO above threshold |
| 4 | BRK | Line break detected |
| 5 | MATCH | Data match detected |
| 6 | FE | Framing error |
| 7 | PRE | Parity error |
| 8 | OR | Overrun error |
| 9 | RTO | Receiver timeout |

### UART Configuration
- **Default Baud Rate**: 115200 bps (configurable)
- **Data Format**: 8N1 (8 data bits, no parity, 1 stop bit)
- **FIFO Thresholds**: Configurable for interrupt generation
- **Clock Source**: System clock (40 MHz)

## Memory Controller and Shared Access

The memory controller in the user_project_wrapper manages access to the single DFFRAM512x32 memory instance from both the PicoRV32 CPU and the external Wishbone slave interface.

### Memory Arbitration
- **CPU Priority**: PicoRV32 CPU has priority access to memory
- **Wishbone Slave Access**: Caravel management core can program memory when CPU is not accessing
- **Single Memory Instance**: Both interfaces share the same physical memory
- **Address Range**: 0x00000000 - 0x000007FF (2KB, 512 words × 32 bits)

### Access Control
- **CPU Access**: Direct memory interface signals from SoC wrapper
- **Wishbone Access**: Memory-mapped access via Wishbone slave interface
- **Arbitration Logic**: Simple priority-based arbitration (CPU first)
- **Data Integrity**: Single memory instance ensures data consistency

### Memory Interface Signals
| Signal | Direction | Width | Description |
|--------|-----------|-------|-------------|
| mem_en | CPU → Memory | 1 | Memory enable from CPU |
| mem_we | CPU → Memory | 4 | Write enable from CPU |
| mem_addr | CPU → Memory | 9 | Address from CPU |
| mem_wdata | CPU → Memory | 32 | Write data from CPU |
| mem_rdata | Memory → CPU | 32 | Read data to CPU |
| wbs_* | Wishbone ↔ Memory | Various | Wishbone slave interface |

## System Integration

### Wishbone Bus Interface
The design implements a Wishbone slave interface for memory programming:

#### Wishbone Slave Signals
| Signal | Direction | Width | Description |
|--------|-----------|-------|-------------|
| wb_clk_i | Input | 1 | Wishbone clock |
| wb_rst_i | Input | 1 | Wishbone reset |
| wbs_stb_i | Input | 1 | Strobe signal |
| wbs_cyc_i | Input | 1 | Cycle signal |
| wbs_we_i | Input | 1 | Write enable |
| wbs_sel_i | Input | 4 | Byte select |
| wbs_dat_i | Input | 32 | Data input |
| wbs_adr_i | Input | 32 | Address input |
| wbs_ack_o | Output | 1 | Acknowledge signal |
| wbs_dat_o | Output | 32 | Data output |

#### Memory Programming Interface
- **Address Range**: 0x00000000 - 0x000007FF (2KB memory space)
- **Access Type**: Read/Write with byte-level granularity
- **Arbitration**: CPU has priority, Wishbone access when CPU idle
- **Response**: Single-cycle acknowledge for memory access

### Logic Analyzer Integration
The design provides logic analyzer signals for debugging:

- **la_data_in[127:0]**: Input signals from logic analyzer
- **la_data_out[127:0]**: Output signals to logic analyzer  
- **la_oenb[127:0]**: Output enable signals

#### Logic Analyzer Signal Mapping
- **la_data_in[33]**: PCPI write signal
- **la_data_in[65:34]**: PCPI result data
- **la_data_in[97:66]**: Interrupt signals

### GPIO Interface
The design provides access to Caravel's GPIO pins with UART connectivity:

- **io_in[37:0]**: GPIO input signals
- **io_out[37:0]**: GPIO output signals
- **io_oeb[37:0]**: GPIO output enable signals
- **analog_io[28:0]**: Analog I/O signals

#### UART GPIO Mapping
- **GPIO 0**: UART TX output (io_out[0])
- **GPIO 1**: UART RX input (io_in[1])
- **GPIO 0 Enable**: Output enabled (io_oeb[0] = 0)
- **GPIO 1 Enable**: Input enabled (io_oeb[1] = 1)

## Physical Design Specifications

### Die Area and Layout
- **Die Area**: 2920 × 3520 μm²
- **Core Utilization**: Optimized for macro placement
- **Power Domains**: 
  - vccd1/vssd1: Digital core power
  - vdda1/vssa1: Analog power (if needed)

### Macro Placement
- **PicoRV32 Core**: Located at [300, 100] μm, orientation North
- **DFFRAM512x32**: Located at [1200, 800] μm, orientation North

### Power Distribution Network (PDN)
- **Core Ring**: Enabled with 3.1 μm width
- **Vertical Offset**: 12.45 μm
- **Horizontal Offset**: 12.45 μm
- **Spacing**: 1.7 μm
- **Pitch**: 180 μm

### Design Rules and Constraints
- **Maximum Transition**: 1.5 V/ns
- **Maximum Fanout**: 35
- **Clock Period**: 25 ns (40 MHz)
- **Technology**: Sky130 PDK

## Timing and Performance

### Clock Specifications
- **Primary Clock**: wb_clk_i (Wishbone clock)
- **Clock Period**: 25 ns (40 MHz)
- **Clock Port**: wb_clk_i
- **Reset**: Asynchronous reset with wb_rst_i

### Performance Characteristics
- **Instruction Execution**: Single-cycle for most instructions
- **Memory Access**: Single-cycle synchronous access
- **Pipeline**: Single-stage pipeline
- **Branch Prediction**: None (simple branch handling)

### Timing Constraints
- **Setup Time**: Optimized for 40 MHz operation
- **Hold Time**: Satisfied by design constraints
- **Clock-to-Q**: Single cycle for memory operations

## Pin Configuration

### Pin Assignment Strategy
The pin configuration follows Caravel's standard layout:

- **North Side**: Analog I/O pins (analog_io[8:17])
- **South Side**: Wishbone, Logic Analyzer, Clock, and IRQ signals
- **East Side**: GPIO pins 0-14 with analog I/O
- **West Side**: GPIO pins 15-37 with analog I/O

### Power Pins
- **vccd1/vssd1**: Primary digital power/ground
- **vccd2/vssd2**: Secondary digital power/ground  
- **vdda1/vssa1**: Primary analog power/ground
- **vdda2/vssa2**: Secondary analog power/ground

## Power Management

### Power Domains
- **Core Domain**: PicoRV32 processor (vccd1/vssd1)
- **Memory Domain**: DFFRAM512x32 (VPWR/VGND)
- **I/O Domain**: GPIO and interface logic

### Power Consumption
- **Active Power**: Estimated based on 40 MHz operation
- **Standby Power**: Minimal due to synchronous design
- **I/O Power**: Dependent on GPIO usage

### Power Supply Requirements
- **Digital Core**: 1.8V (vccd1)
- **I/O**: 3.3V (vdda1/vdda2)
- **Memory**: 1.8V (VPWR)

---

## Design Files and Implementation

### Source Files
- **RTL**: `verilog/rtl/user_project_wrapper.v`
- **SoC Wrapper**: `verilog/rtl/picorv32_soc.v`
- **Memory Macro**: `verilog/rtl/memory_macro.v`
- **Core**: `verilog/rtl/picorv32.v`
- **Memory**: `ip/DFFRAM512x32/hdl/gl/DFFRAM512x32.v`
- **UART**: `ip/CF_UART/hdl/rtl/CF_UART.v`
- **UART WB**: `ip/CF_UART/hdl/rtl/bus_wrappers/CF_UART_WB.v`
- **Utilities**: `ip/CF_IP_UTIL/hdl/cf_util_lib.v`
- **Defines**: `verilog/rtl/defines.v`

### Configuration Files
- **OpenLane Config**: `openlane/user_project_wrapper/config.json`
- **Pin Order**: `openlane/user_project_wrapper/pin_order.cfg`
- **Timing**: `sdc/user_project_wrapper.sdc`

### Physical Implementation
- **GDS**: `gds/user_project_wrapper.gds`
- **LEF**: `lef/user_project_wrapper.lef`
- **Library**: `lib/user_project_wrapper.lib`

This specification document provides a comprehensive overview of the PicoRV32 Caravel user project design, including all major components, interfaces, and implementation details.

# PicoRV32 SoC Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Overview

This repository contains a complete System-on-Chip (SoC) implementation using the PicoRV32 RISC-V processor core integrated within the Caravel user project wrapper. The design includes:

- **PicoRV32 Core**: RISC-V RV32I instruction set architecture (ISA) processor
- **Memory Macro**: DFFRAM512x32 (512 words × 32 bits = 2KB) with arbitration logic
- **CF_UART**: Full-featured UART interface with FIFO support and interrupts
- **Wishbone Interconnect**: Standard Wishbone bus for peripheral access
- **GPIO Interface**: UART connected to GPIO pins 20 (TX) and 21 (RX)

## Architecture

The system architecture consists of three main hardened macros integrated in the user project wrapper:

1. **Memory Macro** (`memory_macro`): Contains DFFRAM512x32 memory and memory arbitration logic for CPU and external Wishbone slave access
2. **PicoRV32 SoC** (`picorv32_soc`): Contains PicoRV32 processor core, Wishbone interconnect, and peripheral interfaces (UART, GPIO)
3. **User Project Wrapper**: Integrates both macros and provides Caravel-compatible interface

### Memory Map

- `0x00000000 - 0x000007FF`: DFFRAM512x32 Memory (2KB)
- `0x00002000 - 0x00002FFF`: CF_UART Registers
- `0x00003000 - 0x00003FFF`: GPIO Registers (placeholder)

## Quick Start

### Prerequisites

- Docker: [Install Docker](https://docs.docker.com/get-docker/)
- Python 3.8+ with PIP

### Setup

```bash
# Clone the repository
git clone <repository-url>
cd picoRV32_caravel

# Setup environment
make setup
```

### Hardening the Design

The design uses a macro-first hardening strategy (Option 1):

```bash
# Harden the memory macro (includes DFFRAM512x32)
make memory_macro

# Harden the PicoRV32 SoC
make picorv32_soc

# Harden the user project wrapper (integrates both macros)
make user_project_wrapper
```

### Running Simulations

```bash
# RTL simulation
make cocotb-verify-all-rtl

# Gate-level simulation
make cocotb-verify-all-gl
```

### Running Precheck

```bash
make precheck
make run-precheck
```

## Documentation

For detailed documentation, see:
- [Design Specification](docs/design_specification.md) - Complete design specification
- [Quick Start Guide](docs/source/quickstart.rst) - Detailed setup instructions
- [Project Documentation](docs/source/index.md) - Full project documentation

## Project Structure

```
├── verilog/rtl/          # RTL source files
│   ├── memory_macro.v    # Memory macro with DFFRAM and arbitration
│   ├── picorv32_soc.v    # PicoRV32 SoC wrapper
│   └── user_project_wrapper.v  # Top-level wrapper
├── openlane/             # OpenLane configurations
│   ├── memory_macro/     # Memory macro hardening config
│   ├── picorv32_soc/     # SoC hardening config
│   └── user_project_wrapper/  # Top-level hardening config
├── ip/                   # IP blocks (DFFRAM512x32, CF_UART)
└── docs/                 # Documentation
```

## License

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE) file for details.
# DFFRAM Programming Test Summary

## Overview
This test suite verifies the ability to program the DFFRAM512x32 memory in the user area from the management SOC via the Wishbone slave interface.

## Files Created

### 1. `dffram_programming.py`
**Main cocotb testbench** that performs comprehensive memory programming verification:
- **Phase 1**: Write test patterns to various memory locations
- **Phase 2**: Read back data to verify programming
- **Phase 3**: Test byte-level access within 32-bit words
- **Phase 4**: Test memory boundary conditions
- **Phase 5**: Test memory overwrite functionality
- **Phase 6**: Test sequential memory access patterns

### 2. `dffram_programming.yaml`
**Test configuration file** that defines the test for the cocotb framework.

### 3. `dffram_programming.c`
**Firmware code** that runs on the PicoRV32 CPU to perform memory tests from the CPU side.

### 4. `README.md`
**Documentation** explaining the test purpose, phases, and usage.

## Memory Interface Details

### Wishbone Slave Interface
- **Base Address**: 0x30000000 (external memory access)
- **Size**: 8KB (512 words × 32 bits)
- **Access Type**: Read/Write with byte-level granularity
- **Arbitration**: CPU has priority, Wishbone access when CPU idle

### DFFRAM512x32 Specifications
- **Capacity**: 512 words × 32 bits = 16,384 bits (2KB)
- **Organization**: Single-port synchronous RAM
- **Data Width**: 32 bits
- **Address Width**: 9 bits (512 addresses)
- **Technology**: Custom DFFRAM implementation

## Test Patterns
The test uses various data patterns to ensure comprehensive verification:
- Classic test patterns (0xDEADBEEF, 0x12345678)
- Alternating bit patterns (0xAAAAAAAA, 0x55555555)
- Edge cases (0x00000000, 0xFFFFFFFF)
- Incremental/decremental patterns

## Running the Test

### Individual Test
```bash
caravel_cocotb -t dffram_programming -tag dffram_test
```

### All User Project Tests
```bash
caravel_cocotb -tl user_proj_tests/user_proj_tests.yaml -tag user_proj_tests
```

## Integration
The test has been integrated into the existing cocotb test framework:
- Added to `cocotb_tests.py` imports
- Added to `user_proj_tests.yaml` includes
- Follows existing test structure and conventions

## Expected Results
All test phases should pass, confirming:
- Management SOC can successfully program the DFFRAM
- Data integrity is maintained across all operations
- Memory arbitration works correctly between CPU and Wishbone
- All memory access patterns function as expected
- Byte-level access works correctly
- Boundary conditions are handled properly

## Verification Points
1. **Memory Programming**: Verify mgmt SOC can write to DFFRAM
2. **Data Integrity**: Verify written data can be read back correctly
3. **Access Granularity**: Verify byte-level access works
4. **Memory Arbitration**: Verify CPU and Wishbone access don't conflict
5. **Boundary Conditions**: Verify first/last memory addresses work
6. **Overwrite Capability**: Verify memory can be overwritten
7. **Sequential Access**: Verify multiple consecutive operations work

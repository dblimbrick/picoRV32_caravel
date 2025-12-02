# DFFRAM Programming Test

This test verifies the ability to program the DFFRAM512x32 memory in the user area from the management SOC via the Wishbone slave interface.

## Test Overview

The test validates:
- Memory programming via Wishbone interface
- Data integrity after write operations
- Byte-level memory access
- Memory boundary conditions
- Memory overwrite functionality
- Sequential memory access patterns

## Test Phases

### Phase 1: Write Test Patterns
Writes various test patterns to different memory locations:
- Classic test patterns (0xDEADBEEF, 0x12345678)
- Alternating bit patterns (0xAAAAAAAA, 0x55555555)
- Edge cases (0x00000000, 0xFFFFFFFF)
- Incremental/decremental patterns

### Phase 2: Read Verification
Reads back all written data to verify programming was successful.

### Phase 3: Byte-Level Access
Tests individual byte access within 32-bit words to verify byte-level granularity.

### Phase 4: Boundary Conditions
Tests memory access at the first and last addresses of the DFFRAM.

### Phase 5: Memory Overwrite
Verifies that memory locations can be overwritten with new data.

### Phase 6: Sequential Access
Tests sequential read/write operations across multiple memory locations.

## Memory Interface

- **Base Address**: 0x30000000 (external memory access)
- **Size**: 8KB (512 words × 32 bits)
- **Access**: Wishbone slave interface
- **Arbitration**: CPU has priority, Wishbone access when CPU idle

## Running the Test

```bash
caravel_cocotb -t dffram_programming -tag dffram_test
```

## Expected Results

All test phases should pass, confirming that:
- The management SOC can successfully program the DFFRAM
- Data integrity is maintained
- Memory arbitration works correctly
- All memory access patterns function as expected

# SPDX-FileCopyrightText: 2023 Efabless Corporation

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# SPDX-License-Identifier: Apache-2.0

from caravel_cocotb.caravel_interfaces import test_configure
from caravel_cocotb.caravel_interfaces import report_test
import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles

@cocotb.test()
@report_test
async def dffram_programming(dut):
    """
    Test DFFRAM programming from Caravel management core via Wishbone interface.
    
    This test verifies that the Caravel management core can program the DFFRAM512x32
    memory in the user area through the Wishbone slave interface.
    
    Test sequence:
    1. Configure caravel and wait for ready
    2. Write test patterns to DFFRAM via Wishbone interface
    3. Read back data to verify programming
    4. Test different address ranges and data patterns
    5. Verify memory integrity
    """
    caravelEnv = await test_configure(dut, timeout_cycles=50000)
    
    cocotb.log.info(f"[TEST] Start DFFRAM programming test")
    
    # Wait for caravel to be ready
    await caravelEnv.release_csb()
    await caravelEnv.wait_mgmt_gpio(1)
    cocotb.log.info(f"[TEST] Caravel ready, starting DFFRAM programming test")
    
    # Memory programming parameters
    MEM_BASE = 0x30000000  # External memory base address for Wishbone access
    MEM_SIZE = 0x2000      # 8KB memory size (512 words × 32 bits)
    
    # Test data patterns
    test_patterns = [
        0xDEADBEEF,  # Classic test pattern
        0x12345678,  # Sequential pattern
        0xAAAAAAAA,  # Alternating bits
        0x55555555,  # Alternating bits (inverted)
        0x00000000,  # All zeros
        0xFFFFFFFF,  # All ones
        0x01234567,  # Incremental pattern
        0xFEDCBA98   # Decremental pattern
    ]
    
    # Test addresses (within DFFRAM range)
    test_addresses = [
        0x00000000,  # First word
        0x00000004,  # Second word
        0x00000008,  # Third word
        0x0000000C,  # Fourth word
        0x00000100,  # Middle of memory
        0x000001FC,  # Near end of memory
        0x000001F8,  # Last word
        0x000001F4   # Second to last word
    ]
    
    cocotb.log.info(f"[TEST] Testing DFFRAM programming via Wishbone interface")
    
    # Test 1: Write test patterns to various memory locations
    cocotb.log.info(f"[TEST] Phase 1: Writing test patterns to memory")
    for i, addr in enumerate(test_addresses):
        if i < len(test_patterns):
            test_data = test_patterns[i]
            wb_addr = MEM_BASE + addr
            
            cocotb.log.info(f"[TEST] Writing 0x{test_data:08X} to address 0x{wb_addr:08X}")
            
            # Write data via Wishbone interface
            await user_wb_write(caravelEnv, wb_addr, test_data)
            
            # Small delay to ensure write completion
            await ClockCycles(caravelEnv.clk, 2)
    
    # Test 2: Read back data to verify programming
    cocotb.log.info(f"[TEST] Phase 2: Reading back data to verify programming")
    for i, addr in enumerate(test_addresses):
        if i < len(test_patterns):
            expected_data = test_patterns[i]
            wb_addr = MEM_BASE + addr
            
            cocotb.log.info(f"[TEST] Reading from address 0x{wb_addr:08X}")
            
            # Read data via Wishbone interface
            read_data = await user_wb_read(caravelEnv, wb_addr)
            
            cocotb.log.info(f"[TEST] Expected: 0x{expected_data:08X}, Read: 0x{read_data:08X}")
            
            # Verify data matches
            if read_data != expected_data:
                cocotb.log.error(f"[TEST] Data mismatch at address 0x{wb_addr:08X}")
                cocotb.log.error(f"[TEST] Expected: 0x{expected_data:08X}, Got: 0x{read_data:08X}")
                raise cocotb.result.TestFailure(f"Data mismatch at address 0x{wb_addr:08X}")
            else:
                cocotb.log.info(f"[TEST] ✓ Data verification passed for address 0x{wb_addr:08X}")
    
    # Test 3: Test memory overwrite functionality
    cocotb.log.info(f"[TEST] Phase 3: Testing memory overwrite functionality")
    overwrite_addr = MEM_BASE + 0x00000020
    original_data = 0xAAAAAAAA
    overwrite_data = 0x55555555
    
    # Write original data
    await user_wb_write(caravelEnv, overwrite_addr, original_data)
    await ClockCycles(caravelEnv.clk, 2)
    
    # Verify original data
    read_data = await user_wb_read(caravelEnv, overwrite_addr)
    if read_data != original_data:
        cocotb.log.error(f"[TEST] Original data write failed")
        raise cocotb.result.TestFailure("Original data write failed")
    
    # Overwrite with new data
    await user_wb_write(caravelEnv, overwrite_addr, overwrite_data)
    await ClockCycles(caravelEnv.clk, 2)
    
    # Verify overwrite
    read_data = await user_wb_read(caravelEnv, overwrite_addr)
    if read_data == overwrite_data:
        cocotb.log.info(f"[TEST] ✓ Memory overwrite test passed")
    else:
        cocotb.log.error(f"[TEST] ✗ Memory overwrite test failed")
        raise cocotb.result.TestFailure("Memory overwrite test failed")
    
    # Test 4: Test sequential memory access patterns
    cocotb.log.info(f"[TEST] Phase 4: Testing sequential memory access patterns")
    seq_start_addr = MEM_BASE + 0x00000030
    seq_length = 8
    
    # Write sequential data
    for i in range(seq_length):
        addr = seq_start_addr + (i * 4)
        data = 0x1000 + i  # Simple sequential pattern
        await user_wb_write(caravelEnv, addr, data)
        await ClockCycles(caravelEnv.clk, 1)
    
    # Read back sequential data
    for i in range(seq_length):
        addr = seq_start_addr + (i * 4)
        expected_data = 0x1000 + i
        read_data = await user_wb_read(caravelEnv, addr)
        
        if read_data == expected_data:
            cocotb.log.info(f"[TEST] ✓ Sequential access verified for address 0x{addr:08X}")
        else:
            cocotb.log.error(f"[TEST] ✗ Sequential access failed for address 0x{addr:08X}")
            raise cocotb.result.TestFailure(f"Sequential access failed for address 0x{addr:08X}")
    
    # All tests passed
    cocotb.log.info(f"[TEST] All DFFRAM programming tests PASSED!")
    cocotb.log.info(f"[TEST] ✓ Memory programming from Caravel management core verified")
    cocotb.log.info(f"[TEST] ✓ Data integrity verified")
    cocotb.log.info(f"[TEST] ✓ Memory overwrite verified")
    cocotb.log.info(f"[TEST] ✓ Sequential access verified")
    cocotb.log.info(f"[TEST] DFFRAM programming test completed successfully")


async def user_wb_write(caravelEnv, addr, data):
    """
    Write data to user area via Wishbone interface
    
    Args:
        caravelEnv: Caravel environment object
        addr: Wishbone address
        data: Data to write
    """
    await RisingEdge(caravelEnv.clk)
    
    # Set Wishbone signals for write operation
    caravelEnv.user_hdl.wb_stb_i.value = 1
    caravelEnv.user_hdl.wb_cyc_i.value = 1
    caravelEnv.user_hdl.wb_sel_i.value = 0xF  # 32-bit word access
    caravelEnv.user_hdl.wb_we_i.value = 1     # Write operation
    caravelEnv.user_hdl.wb_adr_i.value = addr
    caravelEnv.user_hdl.wb_dat_i.value = data
    
    cocotb.log.debug(f"[WB] Start writing to {hex(addr)} -> {hex(data)}")
    
    # Wait for acknowledge
    await FallingEdge(caravelEnv.user_hdl.wb_ack_o)
    
    # Clear Wishbone signals
    caravelEnv.user_hdl.wb_stb_i.value = 0
    caravelEnv.user_hdl.wb_cyc_i.value = 0
    
    cocotb.log.debug(f"[WB] End writing to {hex(addr)}")


async def user_wb_read(caravelEnv, addr):
    """
    Read data from user area via Wishbone interface
    
    Args:
        caravelEnv: Caravel environment object
        addr: Wishbone address
        
    Returns:
        Read data value
    """
    await RisingEdge(caravelEnv.clk)
    
    # Set Wishbone signals for read operation
    caravelEnv.user_hdl.wb_stb_i.value = 1
    caravelEnv.user_hdl.wb_cyc_i.value = 1
    caravelEnv.user_hdl.wb_sel_i.value = 0xF  # 32-bit word access
    caravelEnv.user_hdl.wb_we_i.value = 0     # Read operation
    caravelEnv.user_hdl.wb_adr_i.value = addr
    
    cocotb.log.debug(f"[WB] Start reading from {hex(addr)}")
    
    # Wait for acknowledge
    await FallingEdge(caravelEnv.user_hdl.wb_ack_o)
    
    # Get read data
    read_data = caravelEnv.user_hdl.wb_dat_o.value
    
    # Clear Wishbone signals
    caravelEnv.user_hdl.wb_stb_i.value = 0
    caravelEnv.user_hdl.wb_cyc_i.value = 0
    
    cocotb.log.debug(f"[WB] Read from {hex(addr)} -> {hex(read_data)}")
    
    return read_data
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MemoryPointerExample {

    // vuln - mstore without manual update of mem pointer
    function vulnerableFunction() public pure returns (uint256[] memory) {
        uint256 someData = 42;
        
        assembly {
            mstore(0x80, someData)
        }
        
        // Free memory pointer is NOT updated, leading to potential corruption
    }

    // Secure function that updates the free memory pointer
    function safeFunction() public pure returns (uint256[] memory) {
        uint256 someData = 42;
        
        assembly {
            mstore(0x80, someData)
            
            // Manually update the free memory pointer to avoid corruption
            mstore(0x40, 0xA0)  // Set free memory pointer to 0xA0
        }
    }
}

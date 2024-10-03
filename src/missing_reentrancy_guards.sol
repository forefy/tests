// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract MissingReentrancyGuards is ReentrancyGuard {
    mapping(address => uint256) public balances;

    // Not vuln - not making an external call
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Not vuln - makes ext call, but has nonReentrant modifier 
    function withdraw() public nonReentrant {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance");

        balances[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }

    // vuln - ext call and no modifier (although CEI is followed)
    function withdraw2() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance");

        balances[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
    }
}
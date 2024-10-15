// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MsgValueReuse {
    mapping(address => uint256) public tokenBalance;

    function buyTokens(uint256 times) public payable {
        require(msg.value > 0, "Must send ETH to buy tokens");
        
        for (uint256 i = 0; i < times; i++) {
            // vuln -  msg.value reused in each loop iteration
            uint256 tokens = msg.value * 100;
            tokenBalance[msg.sender] += tokens;
        }
    }

    receive() external payable {}
}
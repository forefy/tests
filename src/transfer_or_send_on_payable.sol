// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableContract {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdrawWithTransfer(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(address(this).balance >= amount, "Insufficient balance");

        // vuln -  use of send on a payable address
        owner.transfer(amount);
    }

    function withdrawWithSend(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(address(this).balance >= amount, "Insufficient balance");

        // vuln -  use of send on a payable address
        bool sent = owner.send(amount);
        require(sent, "Send failed");
    }
}

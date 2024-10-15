// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TxOriginExample {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // vuln - function using tx.origin for authorization
    function transferOwnershipVulnerable(address newOwner) public {
        require(tx.origin == owner, "Not authorized: tx.origin");
        owner = newOwner;
    }

    // ok - using msg.sender
    function transferOwnershipSecure(address newOwner) public {
        require(msg.sender == owner, "Not authorized: msg.sender");
        owner = newOwner;
    }

    function withdraw() public {
        require(msg.sender == owner, "Not authorized: msg.sender");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
